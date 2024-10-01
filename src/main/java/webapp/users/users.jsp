<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css"  rel="stylesheet" />

</head>
<body>

<div class="relative overflow-x-auto  mx-auto mt-10">
    <table class="w-1/2 mx-auto text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
        <tr>
            <th scope="col" class="px-6 py-3">
                ID
            </th>
            <th scope="col" class="px-6 py-3">
                userName
            </th>
            <th scope="col" class="px-6 py-3">
                name
            </th>
            <th scope="col" class="px-6 py-3">
                prenom
            </th>
            <th scope="col" class="px-6 py-3">
                email
            </th>
            <th scope="col" class="px-6 py-3">
                email
            </th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
            if (users != null) {
                for (User user : users) {
        %>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getId() %>
            </th>
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getUsername() %>
            </th>
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getName() %>
            </th>
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getPrenom() %>
            </th>
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getEmail() %>
            </th>
            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                <%= user.getEmail() %>
            </th>
            <td class="px-6 py-4 flex">
                <form action="/users" method="post">
                    <input type="hidden" name="id" value="<%= user.getId() %>">
                    <input type="hidden" name="_method" value="DELETE">
                    <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">Delete</button>
                </form>
                <form action="/users" method="post">
                    <input type="hidden" name="id" value="<%= user.getId() %>">
                    <input type="hidden" name="_method" value="PUT">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <a href="/"> back</a>
</div>


<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>