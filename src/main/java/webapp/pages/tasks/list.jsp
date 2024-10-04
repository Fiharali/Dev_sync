<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.Task" %>
<%@ page import="com.devsync.domain.enums.TaskStatus" %>

<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
    <div class="relative mx-auto w-full mt-10 pt-10 overflow-x-auto">
        <table class="min-w-full mx-auto text-sm text-left mt-5 rtl:text-right text-gray-500">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3">ID</th>
                <th scope="col" class="px-6 py-3">Title</th>
                <th scope="col" class="px-6 py-3">Description</th>
                <th scope="col" class="px-6 py-3">Status</th>
                <th scope="col" class="px-6 py-3">Date Created</th>
                <th scope="col" class="px-6 py-3">Date End</th>
                <th scope="col" class="px-6 py-3">Assigned To</th>
                <th scope="col" class="px-6 py-3">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                if (tasks != null) {
                    for (Task task : tasks) {
            %>
            <tr class="bg-white border-b">
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getId() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getTitle() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getDescription() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getStatus() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getDateCreated() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getDateEnd() %>
                </td>
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= task.getUser().getUsername() %>
                </td>
                <td class="px-6 py-4 flex">
                    <form action="/tasks" method="post" class="mr-2">
                        <input type="hidden" name="id" value="<%= task.getId() %>">
                        <input type="hidden" name="_method" value="DELETE">
                        <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded delete-btn">Delete</button>
                    </form>
                    <form action="tasks" method="post">
                        <input type="hidden" name="id" value="<%= task.getId() %>">
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
                        text: "Task has been deleted.",
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