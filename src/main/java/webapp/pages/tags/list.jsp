
<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.Tag" %>
<%@ page import="com.devsync.domain.entities.Tag" %>


<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">

    <div class="relative mx-auto w-full mt-10 pt-10 overflow-x-auto">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-indigo-800">tags</h2>
            <a   href="/tags?action=create"    class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out transform ">
                <i class="fas fa-plus mr-2"></i>Add Tag
            </a>
        </div>
        <table class="min-w-full mx-auto text-sm text-left mt-5 rtl:text-right text-gray-500">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3">ID</th>
                <th scope="col" class="px-6 py-3">tagName</th>
                <th scope="col" class="px-6 py-3">Action</th>

            </tr>
            </thead>
            <tbody>
            <%
                List<Tag> tags = (List<Tag>) request.getAttribute("tags");
                if (tags != null) {
                    for (Tag tag : tags) {
            %>
            <tr class="bg-white border-b">
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= tag.getId() %>
                </td>
               
                <td class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    <%= tag.getName() %>
                </td>
            
                <td class="px- py-4 flex">
                    <form action="/tags" method="post" class="mr-2">
                        <input type="hidden" name="id" value="<%= tag.getId() %>">
                        <input type="hidden" name="_method" value="DELETE">
                        <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded delete-btn">Delete</button>
                    </form>
                    <form action="tags" method="post">
                        <input type="hidden" name="id" value="<%= tag.getId() %>">
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
                        text: "tag has been deleted.",
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