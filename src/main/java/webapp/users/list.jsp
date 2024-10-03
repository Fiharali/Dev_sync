
<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.User" %>


<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
    <div class="relative mx-auto w-full mt-10 pt-10 overflow-x-auto">
        <table class="min-w-full mx-auto text-sm text-left mt-5 rtl:text-right text-gray-500">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3">ID</th>
                <th scope="col" class="px-6 py-3">userName</th>
                <th scope="col" class="px-6 py-3">name</th>
                <th scope="col" class="px-6 py-3">prenom</th>
                <th scope="col" class="px-6 py-3">email</th>
                <th scope="col" class="px-6 py-3">User type</th>
                <th scope="col" class="px-6 py-3">Tokens</th>
                <th scope="col" class="px-6 py-3">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null) {
                    for (User user : users) {
            %>
            <tr class="bg-white border-b">
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getId() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getUsername() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getName() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getPrenom() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getEmail() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getUserType() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= user.getTokens()     %>
                </td>
                <td class="px- py-4 flex">
                    <form action="/users" method="post" class="mr-2">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <input type="hidden" name="_method" value="DELETE">
                        <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded delete-btn">Delete</button>
                    </form>
                    <form action="users" method="post">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <input type="hidden" name="_method" value="UPDATE">
                        <button type="submit" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
    const deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach((button) => {
        button.addEventListener('click', (event) => {
            event.preventDefault();
            const form = button.parentElement;
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: "Deleted!",
                        text: "User has been deleted.",
                        icon: "success"
                    });
                    setTimeout(() => {
                        form.submit();
                    }, 1000);

                }
            });
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>