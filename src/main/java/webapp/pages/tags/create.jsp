<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>
<div class="p-4 sm:ml-64">
    <div class="max-w-xl mx-auto mt-20">
        <h2 class="text-center text-2xl font-bold mb-5">Create Tag</h2>
        <form action="/tags" method="POST" class="space-y-5" id="form-tag">
            <input type="hidden" name="_method" value="POST" required>

            <div>
                <label for="name" class="block mb-2 text-sm font-medium text-gray-900">Tag Name:</label>
                <input type="text" id="name" name="name" class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"  />
            </div>

            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center w-full">Create Tag</button>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('#form-tag');


        form.addEventListener('submit', function (event) {
            let isValid = true;
            const title = document.getElementById('name');


            clearErrors();

            if (title.value.trim() === '' || title.value.trim().length < 3) {
                showError(title, 'Name of tag  must be at least 3 characters.');
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
</script>
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
</body>
</html>