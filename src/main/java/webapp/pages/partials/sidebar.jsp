<aside id="logo-sidebar" class="fixed top-0 left-0 z-30 w-64 h-screen pt-20 transition-transform -translate-x-full bg-white border-r border-gray-200 sm:translate-x-0" aria-label="Sidebar">
    <div class="h-full px-3 pb-4 overflow-y-auto bg-white mt-10">
        <ul class="space-y-2 font-medium">
            <li>
                <a href="/" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-duotone fa-solid fa-home w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> Home </span>
                </a>
            </li>
            <hr>

            <li>
                <a href="/users" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-duotone fa-solid fa-users w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> Users </span>
                </a>
            </li>
            <hr>
            <li>
                <a href="/tasks" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-duotone fa-solid fa-list-check w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> Tasks </span>
                </a>
            </li>
            <hr>
            <li>
                <a href="/tags" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-solid fa-hashtag fa-list-check w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> tags </span>
                </a>
            </li>

            <%
                User userSession = (User) session.getAttribute("user");
                if (userSession.getUserType().name().equals("USER")) {
            %>
            <hr>

            <li>
                <a href="/tasks-request" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-sharp-duotone fa-solid fa-list-check w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> New Tasks  </span>
                </a>
            </li>
            <% }else { %>
            <hr>

            <li>
                <a href="/tasks-request?action=rejected-tasks" class="flex items-center p-2 text-gray-900 rounded-lg hover:bg-gray-100 group">
                    <i class="fa-sharp-duotone fa-solid fa-list-check w-5 h-5 text-gray-500 transition duration-75 group-hover:text-gray-900"></i>
                    <span class="ms-3"> Tasks rejected   </span>
                </a>
            </li>
            <% } %>

        </ul>
    </div>
</aside>
