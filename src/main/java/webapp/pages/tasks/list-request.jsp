<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.TaskRequest" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Duration" %>

<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">

    <div class="relative mx-auto w-full mt-10 pt-10 overflow-x-auto">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-indigo-800">Tasks Requests</h2>
        </div>
        <table class="min-w-full mx-auto text-sm text-left mt-5 rtl:text-right text-gray-500">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3">ID</th>
                <th scope="col" class="px-6 py-3">Task Title</th>
                <th scope="col" class="px-6 py-3">Assigned to</th>
                <th scope="col" class="px-6 py-3">Date</th>
                <th scope="col" class="px-6 py-3">Status</th>
                <th scope="col" class="px-6 py-3">Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<TaskRequest> tasks = (List<TaskRequest>) request.getAttribute("tasks");
                if (tasks != null) {
                    for (TaskRequest task : tasks) {
                        if (task.getUser().getId().equals(SessionUser.getId()) && task.getTaskRequestStatus().name().equals("PENDING")) {
            %>
            <tr class="bg-white border-b">
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getId() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getTask().getTitle() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getUser().getName() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%

                        LocalDateTime createdDate = task.getDate();
                        LocalDateTime now = LocalDateTime.now();
                        Duration duration = Duration.between(createdDate, now);

                        String timeAgo;
                        if (duration.toHours() > 0) {
                            timeAgo = duration.toHours() + " hour" + (duration.toHours() > 1 ? "s" : "") + " ago";
                        } else if (duration.toMinutes() > 0) {
                            timeAgo = duration.toMinutes() + " minute" + (duration.toMinutes() > 1 ? "s" : "") + " ago";
                        } else {
                            timeAgo = "just now";
                        }
                    %>
                    <%= timeAgo %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getTaskRequestStatus() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap flex">
                    <form action="/tasks-request" method="post" class="mr-2">
                        <input type="hidden" name="id" value="<%=task.getId()%>">
                        <input type="hidden" name="_method" value="APPROVED">
                        <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded delete-btn">APPROVED</button>
                    </form>
                    <form action="tasks-request" method="post">
                        <input type="hidden" name="id" value="<%=task.getId()%>">
                        <input type="hidden" name="_method" value="REJECTED">
                        <button type="submit" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">REJECTED</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
