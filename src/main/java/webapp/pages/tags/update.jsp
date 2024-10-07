
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
<div class="max-w-lg mx-auto mt-20">
    <h2 class="text-center text-2xl font-bold mb-5">Update Tag</h2>
    <form action="/tags" method="POST" class="space-y-5">
        <input type="hidden" name="id" value="${tag.id}">
        <input type="hidden" name="_method" value="PUT" required>

        <div class="">
            <div class="">
                <label for="name" class="block mb-2 text-sm font-medium text-gray-900">Name:</label>
                <input type="text" id="name" name="name" value="${tag.name}" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" required />
            </div>

        </div>



        <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Update</button>
    </form>
</div>
</div>

</body>
</html>
