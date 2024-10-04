<%@ page import="com.devsync.domain.entities.Task" %>
<%@ page import="java.util.List" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
<div class="bg-white rounded-lg shadow-md p-6 mt-16 pt-10   ">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-indigo-800">Tasks</h2>
        <button      class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out transform hover:scale-105">
            <i class="fas fa-plus mr-2"></i>Add Task
        </button>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div class="bg-gray-100 p-4 rounded-lg">
            <h3 class="text-lg font-medium mb-4 text-gray-700">To Do</h3>
            <div class="space-y-3" id="todo-column">
                <%
                    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                    if (tasks != null) {
                        for (Task task : tasks) {
//                            if (task.getStatus().equals("TODO")) {
                %>
                <div class="bg-white p-3 rounded shadow">
                    <h4 class="font-medium"><%= task.getTitle() %></h4>
                    <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                    <div class="flex items-center mt-2">
                        <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                        <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername()%></span>
                    </div>
                </div>
                <%
                            }
//                        }
                    }
                %>
            </div>
        </div>

        <div class="bg-gray-100 p-4 rounded-lg">
            <h3 class="text-lg font-medium mb-4 text-gray-700">In Progress</h3>
            <div class="space-y-3" id="inprogress-column">
                <%
                    if (tasks != null) {
                        for (Task task : tasks) {
                            if (task.getStatus().equals("IN_PROGRESS")) {
                %>
                <div class="bg-white p-3 rounded shadow">
                    <h4 class="font-medium"><%= task.getTitle() %></h4>
                    <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                    <div class="flex items-center mt-2">
                        <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                        <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername()%></span>
                    </div>
                </div>
                <%
                            }
                        }
                    }
                %>
            </div>
        </div>

        <!-- Done Column -->
        <div class="bg-gray-100 p-4 rounded-lg">
            <h3 class="text-lg font-medium mb-4 text-gray-700">Done</h3>
            <div class="space-y-3" id="done-over">
                <%
                    if (tasks != null) {
                        for (Task task : tasks) {
                            if (task.getStatus().equals("DONE")) {
                %>
                <div class="bg-white p-3 rounded shadow">
                    <h4 class="font-medium"><%= task.getTitle() %></h4>
                    <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                    <div class="flex items-center mt-2">
                        <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                        <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername()%></span>
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
            <h3 class="text-lg font-medium mb-4 text-gray-700">OverDue</h3>
            <div class="space-y-3" id="done-column">
                <%
                    if (tasks != null) {
                        for (Task task : tasks) {
                            if (task.getStatus().equals("OVERDUE")) {
                %>
                <div class="bg-white p-3 rounded shadow">
                    <h4 class="font-medium"><%= task.getTitle() %></h4>
                    <p class="text-sm text-gray-600 mt-1"><%= task.getDescription() %></p>
                    <div class="flex items-center mt-2">
                        <img src="pages/assets/images/me.png" alt="Assignee" class="w-6 h-6 rounded-full bg-gray-300">
                        <span class="ml-2 text-xs text-gray-500"><%= task.getUser().getUsername()%></span>
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
