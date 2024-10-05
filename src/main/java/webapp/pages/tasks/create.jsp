
<%@ page import="com.devsync.domain.enums.TaskStatus" %>
<%@ page import="com.devsync.domain.entities.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.devsync.domain.entities.Tag" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
    <div class="max-w-xl mx-auto mt-20">
        <h2 class="text-center text-2xl font-bold mb-5">Create Task</h2>
        <form action="/tasks" method="POST" class="space-y-5">
            <input type="hidden" name="_method" value="POST" required>

            <div>
                <label for="title" class="block mb-2 text-sm font-medium text-gray-900">Title:</label>
                <input type="text" id="title" name="title" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" />
            </div>

            <div class="flex space-x-4">
                <div class="w-1/2">
                    <label for="status" class="block mb-2 text-sm font-medium text-gray-900">Status:</label>
                    <select id="status" name="status" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <option value="">Select status</option>
                        <% for (TaskStatus status : TaskStatus.values()) { %>
                        <option value="<%= status %>"><%= status.name() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="w-1/2">
                    <label for="userId" class="block mb-2 text-sm font-medium text-gray-900">Assigned To:</label>
                    <select id="userId" name="userId" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <option value="">Select a user</option>
                        <% List<User> users = (List<User>) request.getAttribute("users");
                            for (User user : users) { %>
                        <option value="<%= user.getId() %>"><%= user.getUsername() %> --> tokens: <%= user.getTokens() %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="flex space-x-4">
                <div class="w-1/2">
                    <label for="dateEnd" class="block mb-2 text-sm font-medium text-gray-900">Date End:</label>
                    <input type="date" id="dateEnd" name="dateEnd" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" />
                </div>

                <div class="w-1/2">
                    <label for="tags" class="block mb-2 text-sm font-medium text-gray-900">Add Tags</label>
                    <select multiple id="tags" name="tags[]" class=" js-example-basic-multiple shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <option value="">Select tags</option>
                        <% List<Tag> tags = (List<Tag>) request.getAttribute("tags");
                            for (Tag tag : tags) { %>
                        <option value="<%= tag.getId() %>"><%= tag.getName() %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div>
                <label for="description" class="block mb-2 text-sm font-medium text-gray-900">Description:</label>
                <textarea id="description" name="description" rows="3" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"></textarea>
            </div>

            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create Task</button>
        </form>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('form');


        form.addEventListener('submit', function (event) {
            let isValid = true;


            const title = document.getElementById('title');
            const status = document.getElementById('status');
            const dateEnd = document.getElementById('dateEnd');
            const userId = document.getElementById('userId');
            const description = document.getElementById('description');

            clearErrors();

            if (title.value.trim() === '' || title.value.trim().length < 3) {
                showError(title, 'Title must be at least 3 characters.');
                isValid = false;
            }


            if (status.value === '') {
                showError(status, 'Please select a valid status.');
                isValid = false;
            }


            const today = new Date().toISOString().split('T')[0];
            if (dateEnd.value === '' || dateEnd.value < today) {
                showError(dateEnd, 'End date must be in the future.');
                isValid = false;
            }


            if (userId.value === '') {
                showError(userId, 'Please select a user.');
                isValid = false;
            }


            if (description.value.trim() === '' || description.value.trim().length < 10) {
                showError(description, 'Description must be at least 10 characters .');
                isValid = false;
            }


            if (!isValid) {
                event.preventDefault();
            }
        });


        function showError(element, message) {
            const error = document.createElement('span');
            error.className = 'text-red-600 text-sm';
            error.innerText = message;
            element.parentElement.appendChild(error);
            element.classList.add('border-red-500');
        }


        function clearErrors() {
            const errors = document.querySelectorAll('.text-red-600');
            errors.forEach(error => error.remove());
            const inputs = document.querySelectorAll('.border-red-500');
            inputs.forEach(input => input.classList.remove('border-red-500'));
        }
    });
    $(document).ready(function() {
        $('.js-example-basic-multiple').select2({
            placeholder: "Select tags",
            allowClear: true,

        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>