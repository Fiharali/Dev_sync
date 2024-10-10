<%@ page import="com.devsync.domain.entities.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.enums.TaskStatus" %>
<%@ page import="com.devsync.domain.entities.Tag" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.devsync.domain.entities.User" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>

<div class="p-4 sm:ml-64">
    <div class="bg-white rounded-lg p-6 mt-16 pt-10">
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <div id="alert-3" class="flex items-center p-4 mb-4 text-green-800 rounded-lg bg-green-50" role="alert">
            <svg class="flex-shrink-0 w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"/>
            </svg>
            <div class="ms-3 text-sm font-medium">
                <%= successMessage %>
            </div>
            <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-green-50 text-green-500 rounded-lg focus:ring-2 focus:ring-green-400 p-1.5 hover:bg-green-200 inline-flex items-center justify-center h-8 w-8 " data-dismiss-target="#alert-3" aria-label="Close">
                <span class="sr-only">Close</span>
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                </svg>
            </button>
        </div>
        <% session.removeAttribute("successMessage"); %>
        <% } %>
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-indigo-800">Tasks</h2>
            <a href="/tasks?action=create" class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out transform">
                <i class="fas fa-plus mr-2"></i>Add Task
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <%
                String[] statuses = {"TODO", "IN_PROGRESS", "DONE", "OVERDUE"};
                for (String status : statuses) {
            %>
            <div class="bg-gray-100 p-4 rounded-lg">
                <h3 class="text-lg font-medium mb-4 text-gray-700"><%= status.replace("_", " ") %></h3>
                <div class="space-y-3" id="<%= status.toLowerCase() %>-column" data-status="<%= status %>">
                    <%
                        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                        if (tasks != null) {
                            for (Task task : tasks) {
                                if (task.getStatus() == TaskStatus.valueOf(status)) {
                                    LocalDate now = LocalDate.now();
                                    LocalDate taskEndDate = task.getDateEnd();
                                    boolean isPastEndDate = now.isAfter(taskEndDate);
                                    boolean isNearEndDate = now.isAfter(taskEndDate.minusDays(3));
                    %>
                    <div class="relative p-3 rounded shadow bg-white border-t-2 <%= isPastEndDate ? "border-red-700 filtered" : isNearEndDate ? "border-yellow-200" : "border-blue-700" %>"
                         draggable="<%= isPastEndDate ? "false" : "true" %>"
                         data-task-id="<%= task.getId() %>">
                        <button class="absolute top-0 right-0 me-1 mt-1 <%= isPastEndDate ? "text-red-700" : isNearEndDate ? "text-yellow-200" : "text-blue-700" %>" onclick="deleteTaskAction(<%= task.getId() %> , <%=SessionUser.getUserType().name().equals("MANAGER") || SessionUser.getDeleteTokens() > 0 %> ,<%=SessionUser.getId()%>)">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                        <h4 class="font-medium <%= isPastEndDate ? "text-red-700" : "" %>"><%= task.getTitle() %></h4>
                        <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                        <div class="flex items-center mt-2">
                            <button data-modal-target="assigned-modal-<%= task.getId() %>" data-modal-toggle="assigned-modal-<%= task.getId() %>" class="block text-white" type="button">
                                <div class="flex">
                                    <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                                    <%
                                        java.time.LocalDate today = java.time.LocalDate.now();
                                        long daysDifference = java.time.temporal.ChronoUnit.DAYS.between(today, task.getDateEnd());
                                        String daysText = (daysDifference > 0) ? daysDifference + " days" : (daysDifference < 0) ? daysDifference + " days" : "today";
                                    %>
                                    <span class="ml-2 text-xs text-gray-500 float-right">
                                            <%= task.getUser().getUsername() %>
                                            <span class="bg-gray-200 text-gray-800 text-xs font-medium ms-1 px-1 py-0.5 rounded-full"><%= daysText %></span>
                                        </span>
                                </div>
                            </button>
                            <% if (SessionUser.getUserType().name().equals("MANAGER") ) { %>
                            <div id="assigned-modal-<%= task.getId() %>" tabindex="-1" class="hidden fixed top-40 right-0 left-0 z-50 justify-center items-center w-full max-h-full">
                                <div class="relative p-4 w-full max-w-md">
                                    <div class="relative bg-white rounded-lg">
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t">
                                            <h3 class="text-xl font-semibold text-gray-900">Assigned To:</h3>
                                            <button type="button" class="end-2.5 text-gray-400 hover:bg-gray-200 rounded-lg text-sm w-8 h-8" data-modal-hide="assigned-modal-<%= task.getId() %>">
                                                <svg class="w-3 h-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <div class="p-4 md:p-5">
                                            <form class="space-y-4" action="/tasks" method="post">
                                                <input type="hidden" name="_method" value="UPDATE_USER">
                                                <input type="hidden" name="task_id" value="<%= task.getId() %>">
                                                <div>
                                                    <select name="user_id" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block w-full p-2.5">
                                                        <%
                                                            List<User> users = (List<User>) request.getAttribute("users");
                                                            for (User user : users) {
                                                        %>
                                                        <option value="<%= user.getId() %>" <%= user.getId() == task.getUser().getId() ? "selected" : "" %>>
                                                            <%= user.getUsername() %> --- tokens: <%= user.getTokens() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 rounded-lg text-sm px-5 py-2.5 text-center w-full">Assign</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <div class="ml-2 space-x-1 mt-2">
                            <%
                                List<Tag> tags = task.getTags();
                                if (tags != null && !tags.isEmpty()) {
                                    for (Tag tag : tags) {
                            %>
                            <span class="inline-block bg-blue-200 text-blue-800 text-sm px-2 rounded-full"><%= tag.getName() %></span>
                            <% } } %>
                        </div>
                    </div>
                    <%
                                }
                            }
                        }
                    %>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.space-y-3').forEach(function(column) {
        new Sortable(column, {
            group: 'tasks',
            multiDrag: true,
            selectedClass: 'selected',
            filter: '.filtered',
            fallbackTolerance: 3,
            ghostClass: 'blue-background-class',
            animation: 200,
            onEnd: function(evt) {
                let draggedTaskId = evt.item.dataset.taskId;
                let columnElement = evt.item.closest('.space-y-3');
                let newStatus = columnElement.dataset.status;

                console.log('Task ID: ' + draggedTaskId + ' moved to ' + newStatus);

                fetch("/tasks?_method=UPDATE_STATUS&taskId="+ draggedTaskId +"&newStatus="+newStatus, {
                    method: 'POST',
                })
                    .then(response => {
                        if (response.ok) {
                            console.log('Task status updated successfully');
                        } else {
                            console.error('Failed to update task status');
                        }
                    })
                    .catch(error => console.error('Error:', error));
            }
        });
    });

    function deleteTaskAction(taskId , isManager,userId) {

        if (!isManager) {
            Swal.fire({
                title: "Unauthorized",
                text: "You are not authorized to delete this task.",
                icon: "error"
            });
            return;
        }
        Swal.fire({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
                fetch("/tasks?_method=DELETE&userId="+userId+"&id="+ taskId, {
                    method: 'POST',
                })
                    .then(response => {
                        if (response.ok) {
                            console.log('Task deleted successfully');
                            Swal.fire({
                                title: "Deleted!",
                                text: "Task has been deleted.",
                                icon: "success"
                            });
                            location.reload();
                        } else {
                            console.error('Failed to delete task');
                            Swal.fire({
                                title: "Not Deleted!",
                                text: "Task not deleted.",
                                icon: "error"
                            });
                        }
                    })
                    .catch(error => console.error('Error:', error));
            }
        });
    }
</script>