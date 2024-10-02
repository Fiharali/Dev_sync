

<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
<div class="max-w-xl mx-auto mt-20">
    <h2 class="text-center text-2xl font-bold mb-5">Register User</h2>
    <form action="/users" method="POST" class="space-y-5">
        <input type="hidden" name="_method" value="POST" required>

        <div>
            <label for="username" class="block mb-2 text-sm font-medium text-gray-900">Username:</label>
            <input type="text" id="username" name="username" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            <p class="mt-2 text-sm text-red-600"><%= request.getAttribute("usernameError") != null ? request.getAttribute("usernameError") : "" %></p>
        </div>


        <div class="flex space-x-4">
            <div class="w-1/2">
                <label for="name" class="block mb-2 text-sm font-medium text-gray-900">Name:</label>
                <input type="text" id="name" name="name" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>
            <div class="w-1/2">
                <label for="prenom" class="block mb-2 text-sm font-medium text-gray-900">Prenom:</label>
                <input type="text" id="prenom" name="prenom" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>
        </div>
        <div class="flex space-x-4">
            <div class="w-1/2">
                <label for="email" class="block mb-2 text-sm font-medium text-gray-900">Email:</label>
                <input type="email" id="email" name="email" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>
            <div class="w-1/2">
                <label for="password" class="block mb-2 text-sm font-medium text-gray-900">Password:</label>
                <input type="password" id="password" name="password" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>
        </div>

        <div>
            <label for="userType" class="block mb-2 text-sm font-medium text-gray-900">User Type:</label>
            <select id="userType" name="userType" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required>
                <option value="MANAGER">MANAGER</option>
                <option value="USER">User</option>
            </select>
        </div>

        <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create</button>
    </form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>
