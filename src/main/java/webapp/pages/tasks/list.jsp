<%@ page import="com.devsync.domain.entities.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.enums.TaskStatus" %>
<%@ page import="com.devsync.domain.entities.Tag" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>

<div class="p-4 sm:ml-64">
    <div class="bg-white rounded-lg p-6 mt-16 pt-10">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-indigo-800">Tasks</h2>
            <a href="/tasks?action=create" class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out transform">
                <i class="fas fa-plus mr-2"></i>Add Task
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">


            <div class="bg-gray-100 p-4 rounded-lg">
                <h3 class="text-lg font-medium mb-4 text-gray-700">To Do</h3>
                <div class="space-y-3" id="todo-column" data-status="TODO" >
                    <%
                        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                        if (tasks != null) {
                            for (Task task : tasks) {
                                if (task.getStatus() == TaskStatus.TODO) {
                    %>
                    <div class=" p-3 rounded shadow  bg-white <%=task.getDateEnd().isBefore(LocalDate.now()) ? " border-2 border-red-700" : "selected"%> " draggable="<%=task.getDateEnd().isBefore(LocalDate.now()) ? "true" : "false"%> " data-task-id="<%= task.getId() %>" >
                        <h4 class="font-medium <%=task.getDateEnd().isBefore(LocalDate.now()) ? " text-red-700" : ""%>"><%= task.getTitle() %></h4>
                        <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                        <div class="flex items-center mt-2">
                            <button data-modal-target="assigned-modal-<%= task.getId() %>" data-modal-toggle="assigned-modal-<%= task.getId() %>" class="block text-white " type="button">
                                <div class="flex ">
                                    <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                                    <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername() %></span>
                                </div>
                            </button>
                            <div id="assigned-modal-<%= task.getId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-40 right-0 left-0 z-50 justify-center items-center w-full  max-h-full">
                                <div class="relative p-4 w-full max-w-md max-h-full">
                                    <div class="relative bg-white rounded-lg">
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t ">
                                            <h3 class="text-xl font-semibold text-gray-900 ">
                                                Assigned To:
                                            </h3>
                                            <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center " data-modal-hide="assigned-modal-<%= task.getId() %>">
                                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <div class="p-4 md:p-5">
                                            <form class="space-y-4" action="/tasks" method="post" >
                                                <input type="hidden" value="UPDATE_USER" name="_method">
                                                <input type="hidden" value="<%= task.getId() %>" name="task_id">

                                                <div class="">
                                                    <select id=" " name="user_id" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                                        <% List<User> users = (List<User>) request.getAttribute("users");
                                                            for (User user : users) { %>
                                                        <option value="<%= user.getId() %>"    <%= user.getId() == task.getUser().getId() ? "selected" : ""%> >
                                                            <%= user.getUsername() %> --- tokens: <%= user.getTokens() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <button type="submit" value="Assign" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create</button>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ml-2 space-x-1 mt-2">
                            <% List<Tag> tags = task.getTags();
                                if (tags != null && !tags.isEmpty()) {
                                    for (Tag tag : tags) { %>
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
            <div class="bg-gray-100 p-4 rounded-lg">
                <h3 class="text-lg font-medium mb-4 text-gray-700">In Progress</h3>
                <div class="space-y-3"  id="inprogress-column" data-status="IN_PROGRESS" >
                    <%
                        if (tasks != null) {
                            for (Task task : tasks) {
                                if (task.getStatus() == TaskStatus.IN_PROGRESS) {
                    %>
                    <div class="bg-white p-3 rounded shadow selected" draggable="true" data-task-id="<%= task.getId() %>">
                        <h4 class="font-medium"><%= task.getTitle() %></h4>
                        <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                        <div class="flex items-center mt-2">
                            <button data-modal-target="assigned-modal-<%= task.getId() %>" data-modal-toggle="assigned-modal-<%= task.getId() %>" class="block text-white " type="button">
                                <div class="flex ">
                                    <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                                    <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername() %></span>
                                </div>
                            </button>
                            <div id="assigned-modal-<%= task.getId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-40 right-0 left-0 z-50 justify-center items-center w-full  max-h-full">
                                <div class="relative p-4 w-full max-w-md max-h-full">
                                    <div class="relative bg-white rounded-lg">
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t ">
                                            <h3 class="text-xl font-semibold text-gray-900 ">
                                                Assigned To:
                                            </h3>
                                            <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center " data-modal-hide="assigned-modal-<%= task.getId() %>">
                                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <div class="p-4 md:p-5">
                                            <form class="space-y-4" action="/tasks" method="post" >
                                                <input type="hidden" value="UPDATE_USER" name="_method">
                                                <input type="hidden" value="<%= task.getId() %>" name="task_id">

                                                <div class="">
                                                    <select id="" name="user_id" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                                        <% List<User> users = (List<User>) request.getAttribute("users");
                                                            for (User user : users) { %>
                                                        <option value="<%= user.getId() %>"    <%= user.getId() == task.getUser().getId() ? "selected" : ""%> >
                                                            <%= user.getUsername() %> --- tokens: <%= user.getTokens() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <button type="submit" value="Assign" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create</button>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ml-2 space-x-1 mt-2">
                            <% List<Tag> tags = task.getTags();
                                if (tags != null && !tags.isEmpty()) {
                                    for (Tag tag : tags) { %>
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


            <div class="bg-gray-100 p-4 rounded-lg" >
                <h3 class="text-lg font-medium mb-4 text-gray-700">Done</h3>
                <div class="space-y-3" id="done-column" data-status="DONE" >
                    <%
                        if (tasks != null) {
                            for (Task task : tasks) {
                                if (task.getStatus() == TaskStatus.DONE) {
                    %>
                    <div class="bg-white p-3 rounded shadow selected" draggable="true" data-task-id="<%= task.getId() %>">
                        <h4 class="font-medium"><%= task.getTitle() %></h4>
                        <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                        <div class="flex items-center mt-2">
                            <button data-modal-target="assigned-modal-<%= task.getId() %>" data-modal-toggle="assigned-modal-<%= task.getId() %>" class="block text-white " type="button">
                                <div class="flex ">
                                    <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                                    <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername() %></span>
                                </div>
                            </button>
                            <div id="assigned-modal-<%= task.getId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-40 right-0 left-0 z-50 justify-center items-center w-full  max-h-full">
                                <div class="relative p-4 w-full max-w-md max-h-full">
                                    <div class="relative bg-white rounded-lg">
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t ">
                                            <h3 class="text-xl font-semibold text-gray-900 ">
                                                Assigned To:
                                            </h3>
                                            <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center " data-modal-hide="assigned-modal-<%= task.getId() %>">
                                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <div class="p-4 md:p-5">
                                            <form class="space-y-4" action="/tasks" method="post" >
                                                <input type="hidden" value="UPDATE_USER" name="_method">
                                                <input type="hidden" value="<%= task.getId() %>" name="task_id">

                                                <div class="">
                                                    <select  name="user_id" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                                        <% List<User> users = (List<User>) request.getAttribute("users");
                                                            for (User user : users) { %>
                                                        <option value="<%= user.getId() %>"    <%= user.getId() == task.getUser().getId() ? "selected" : ""%> >
                                                            <%= user.getUsername() %> --- tokens: <%= user.getTokens() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <button type="submit" value="Assign" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create</button>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ml-2 space-x-1 mt-2">
                            <% List<Tag> tags = task.getTags();
                                if (tags != null && !tags.isEmpty()) {
                                    for (Tag tag : tags) { %>
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


            <div class="bg-gray-100 p-4 rounded-lg"  >
                <h3 class="text-lg font-medium mb-4 text-gray-700">Overdue</h3>
                <div class="space-y-3" id="overdue-column" data-status="OVERDUE" >
                    <%
                        if (tasks != null) {
                            for (Task task : tasks) {
                                if (task.getStatus() == TaskStatus.OVERDUE) {
                    %>
                    <div class="bg-white p-3 rounded  selected" draggable="true" data-task-id="<%= task.getId() %>" >
                        <h4 class="font-medium"><%= task.getTitle() %></h4>
                        <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>

                        <div class="flex items-center mt-2">
                        <button data-modal-target="assigned-modal-<%= task.getId() %>" data-modal-toggle="assigned-modal-<%= task.getId() %>" class="block text-white " type="button">
                            <div class="flex ">
                            <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                            <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername() %></span>
                            </div>
                        </button>
                            <div id="assigned-modal-<%= task.getId() %>" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-40 right-0 left-0 z-50 justify-center items-center w-full  max-h-full">
                                <div class="relative p-4 w-full max-w-md max-h-full">
                                    <div class="relative bg-white rounded-lg">
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t ">
                                            <h3 class="text-xl font-semibold text-gray-900 ">
                                                Assigned To:
                                            </h3>
                                            <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center " data-modal-hide="assigned-modal-<%= task.getId() %>">
                                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <div class="p-4 md:p-5">
                                            <form class="space-y-4" action="/tasks" method="post" >
                                                <input type="hidden" value="UPDATE_USER" name="_method">
                                                <input type="hidden" value="<%= task.getId() %>" name="task_id">

                                                <div class="">
                                                    <select id="userId" name="user_id" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                                        <% List<User> users = (List<User>) request.getAttribute("users");
                                                            for (User user : users) { %>
                                                         <option value="<%= user.getId() %>"    <%= user.getId() == task.getUser().getId() ? "selected" : ""%> >
                                                            <%= user.getUsername() %> --- tokens: <%= user.getTokens() %>
                                                        </option>
                                                        <% } %>
                                                    </select>
                                                </div>
                                                <button type="submit" value="Assign" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create</button>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ml-2 space-x-1 mt-2">
                            <% List<Tag> tags = task.getTags();
                                if (tags != null && !tags.isEmpty()) {
                                    for (Tag tag : tags) { %>
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

        </div>
    </div>
</div>
<script>
    document.querySelectorAll('.space-y-3').forEach(function(column) {
        new Sortable(column, {
            group: 'tasks',
            multiDrag: true,
            selectedClass: 'selected',
            fallbackTolerance: 3,
            ghostClass: 'blue-background-class',
            animation: 200,
            onEnd: function(evt) {
                let draggedTaskId = evt.item.dataset.taskId;
               // let newStatus = evt.from.dataset.status;
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
</script>
</body>
</html>
