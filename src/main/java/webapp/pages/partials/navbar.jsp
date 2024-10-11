<%@ page import="com.devsync.domain.entities.User" %>
<%@ page import="com.devsync.domain.entities.TaskRequest" %>
<%@ page import="com.devsync.service.TaskRequestService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Duration" %>

<html>
<head>
    <title>Title</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.css"  rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>

</head>
<body>

<nav class="fixed top-0 z-40 w-full bg-white border-b border-gray-200">
    <div class="px-3 py-3 lg:px-5 lg:pl-3">
        <div class="flex items-center justify-between">
            <div class="flex items-center justify-start rtl:justify-end">
                <button data-drawer-target="logo-sidebar" data-drawer-toggle="logo-sidebar" aria-controls="logo-sidebar" type="button" class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg sm:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200">
                    <span class="sr-only">Open sidebar</span>
                    <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" fill-rule="evenodd" d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"></path>
                    </svg>
                </button>
                <a href="/" class="flex ms-2 md:me-24">
                    <img src="/pages/assets/images/logo.png" class="h-8 me-3" alt="FlowBite Logo" />
                    <span class="self-center text-xl font-semibold sm:text-2xl whitespace-nowrap">ALI</span>
                </a>
            </div>
            <div class="flex items-center">
                <%
                    User SessionUser = (User) session.getAttribute("user");
                    if (SessionUser != null ) {
                        TaskRequestService taskRequestService = new TaskRequestService();
                        List<TaskRequest> tasks = taskRequestService.findAll();
                %>

                <div class="flex items-center ms-3">

                    <button id="dropdownNotificationButton" data-dropdown-toggle="dropdownNotification" class="relative me-5 inline-flex items-center text-md font-medium text-center text-gray-500 hover:text-gray-900 focus:outline-none " type="button">
                        <svg class="w-7 h-7" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 14 20">
                            <path d="M12.133 10.632v-1.8A5.406 5.406 0 0 0 7.979 3.57.946.946 0 0 0 8 3.464V1.1a1 1 0 0 0-2 0v2.364a.946.946 0 0 0 .021.106 5.406 5.406 0 0 0-4.154 5.262v1.8C1.867 13.018 0 13.614 0 14.807 0 15.4 0 16 .538 16h12.924C14 16 14 15.4 14 14.807c0-1.193-1.867-1.789-1.867-4.175ZM3.823 17a3.453 3.453 0 0 0 6.354 0H3.823Z"/>
                        </svg>

                        <div class="absolute block w-3 h-3 bg-red-500 border-2 border-white rounded-full -top-0.5 start-2.5 ">
                            <%= tasks.size() %>
                        </div>
                    </button>

                    <div id="dropdownNotification" class="z-20 hidden w-full max-w-sm bg-white divide-y divide-gray-100 rounded-lg shadow" aria-labelledby="dropdownNotificationButton">
                        <div class="block px-4 py-2 font-medium text-center text-gray-700 rounded-t-lg bg-gray-50">
                            Approved Tasks
                        </div>
                        <%  if(SessionUser.getUserType().name().equals("USER")){%>
                        <div class="divide-y divide-gray-100">
                            <% for (TaskRequest task : tasks) {
                                if (task.getUser().getId().equals(SessionUser.getId()) && task.getTaskRequestStatus().name().equals("APPROVED")) {
                                    LocalDateTime createdDate = task.getDate();
                                    LocalDateTime now = LocalDateTime.now();
                                    Duration duration = Duration.between(createdDate, now);
                                    String timeAgo;
                                    if (duration.toHours() > 0) {
                                        timeAgo = duration.toHours() + " hour" + (duration.toHours() > 1 ? "s" : "") + " ago";
                                    } else if (duration.toMinutes() > 0) {
                                        timeAgo = duration.toMinutes() + " minute" + (duration.toMinutes() > 1 ? "s" : "") + " ago";
                                    } else {
                                        timeAgo = "just now";
                                    }
                            %>
                            <div class="flex items-center px-4 py-3 hover:bg-gray-100">
                                <div class="flex-shrink-0">
                                    <img class="rounded-full w-11 h-11" src="pages/assets/images/default-avatar.png" alt="User Avatar">
                                </div>
                                <div class="w-full ps-3">
                                    <div class="text-gray-500 text-sm mb-1.5">Task:
                                        <span class="font-semibold text-gray-900"><%= task.getTask().getTitle() %></span>
                                    </div>
                                    <div class="text-xs text-blue-600"><%= timeAgo %></div>
                                </div>

                                <form action="tasks-request" method="post">
                                    <input type="hidden" name="id" value="<%=task.getId()%>">
                                    <input type="hidden" name="_method"  value="PENDING">
                                    <button type="submit" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" <%= task.getUser().getTokens() > 0 ?  "" : "disabled" %> <%=task.getTask().isAssigned() ?"disabled":"" %>  >
                                        Reject
                                    </button>
                                </form>
                            </div>
                            <%
                                    }
                                }
                                if (tasks.isEmpty()) {
                            %>
                            <div class="px-4 py-2 text-center text-gray-500">No new tasks</div>
                            <% } %>
                        </div>
                        <% }%>

                    </div>


                    <div>
                        <button type="button" class="flex text-sm bg-gray-800 rounded-full focus:ring-4 focus:ring-gray-300" aria-expanded="false" data-dropdown-toggle="dropdown-user">
                            <span class="sr-only">Open user menu</span>
                            <img class="w-8 h-8 rounded-full" src="pages/assets/images/me.png" alt="user photo">
                        </button>
                    </div>
                    <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded shadow" id="dropdown-user">
                        <div class="px-4 py-3" role="none">
                            <p class="text-sm text-gray-900" role="none"><%= SessionUser.getUsername() %></p>
                            <p class="text-sm font-medium text-gray-900 truncate" role="none"><%= SessionUser.getEmail() %></p>
                            <p class="text-sm font-medium text-gray-900 truncate" role="none"><%= SessionUser.getUserType() %></p>
                        </div>
                        <ul class="py-1" role="none">
                            <li>
                                <form action="/login" method="POST">
                                    <input type="hidden" name="_method" value="DESTROY"/>
                                    <input type="submit" value="LogOut" class="text-left w-full block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem"/>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>

                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>

