<%@ page import="com.devsync.domain.enums.TaskStatus" %>
<%@ page import="com.devsync.domain.entities.User" %>
<%@ page import="java.util.List" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
    <div class="max-w-xl mx-auto mt-20">
        <h2 class="text-center text-2xl font-bold mb-5">Create Task</h2>
        <form action="/tasks" method="POST" class="space-y-5">
            <input type="hidden" name="_method" value="POST" required>

            <div>
                <label for="title" class="block mb-2 text-sm font-medium text-gray-900">Title:</label>
                <input type="text" id="title" name="title" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>



            <div>
                <label for="status" class="block mb-2 text-sm font-medium text-gray-900">Status:</label>
                <select id="status" name="status" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required>
                    <% for (TaskStatus status : TaskStatus.values()) { %>
                    <option value="<%= status  %>"><%= status.name() %></option>
                    <% } %>
                </select>
            </div>

            <div>
                <label for="dateCreated" class="block mb-2 text-sm font-medium text-gray-900">Date Created:</label>
                <input type="date" id="dateCreated" name="dateCreated" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>

            <div>
                <label for="dateEnd" class="block mb-2 text-sm font-medium text-gray-900">Date End:</label>
                <input type="date" id="dateEnd" name="dateEnd" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>

            <div>
                <label for="userId" class="block mb-2 text-sm font-medium text-gray-900">Assigned To:</label>
                <select id="userId" name="userId" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required>
                    <option value="">Select a user</option>
                    <%
                        List<User> users = (List<User>) request.getAttribute("users");
                        for (User user : users) { %>
                    <option value="<%= user.getId()  %>"><%= user.getUsername() %></option>
                    <% } %>
                </select>
            </div>
            <div>
                <label for="description" class="block mb-2 text-sm font-medium text-gray-900">Description:</label>
                <textarea id="description" name="description" rows="3" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required></textarea>
            </div>

            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create Task</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>