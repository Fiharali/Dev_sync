<%@ page import="com.devsync.domain.entities.Task" %>
<%@ include file="../partials/navbar.jsp" %>
<%@ include file="../partials/sidebar.jsp" %>

<div class="p-4 sm:ml-64">
    <div class="mb-4 mt-16">
        <h1 class="text-2xl font-bold text-gray-800">Statistics Dashboard</h1>
        <p class="text-gray-500">Overview of key statistics</p>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <div class="w-full p-4 bg-white border border-gray-200 rounded-lg shadow sm:p-6">
            <div class="flex items-center">
                <div class="p-3 mr-4 bg-blue-500 text-white rounded-lg">
                    <i class="fas fa-tasks"></i>
                </div>
                <div>
                    <h5 class="text-base font-semibold text-gray-500">Total Tasks</h5>
                    <% List<Task> tasks = (List<Task>) request.getAttribute("tasks");%>

                    <h3 class="text-2xl font-bold text-gray-900"><%=tasks.stream().count()%></h3>
                </div>
            </div>
        </div>

        <div class="w-full p-4 bg-white border border-gray-200 rounded-lg shadow sm:p-6">
            <div class="flex items-center">
                <div class="p-3 mr-4 bg-green-500 text-white rounded-lg">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <h5 class="text-base font-semibold text-gray-500">Completed Tasks</h5>
                    <h3 class="text-2xl font-bold text-gray-900"><%=tasks.stream().filter(task -> task.getStatus().name().equals("DONE")).count()%></h3>
                </div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="w-full p-4 bg-white border border-gray-200 rounded-lg shadow sm:p-6">
            <div class="flex items-center">
                <div class="p-3 mr-4 bg-yellow-500 text-white rounded-lg">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div>
                    <h5 class="text-base font-semibold text-gray-500">In Progress Tasks</h5>
                    <h3 class="text-2xl font-bold text-gray-900"><%=tasks.stream().filter(task -> task.getStatus().name().equals("IN_PROGRESS")).count()%></h3>
                </div>
            </div>
        </div>


        <div class="w-full p-4 bg-white border border-gray-200 rounded-lg shadow sm:p-6">
            <div class="flex items-center">
                <div class="p-3 mr-4 bg-red-500 text-white rounded-lg">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <div>
                    <h5 class="text-base font-semibold text-gray-500">Overdue Tasks</h5>
                    <h3 class="text-2xl font-bold text-gray-900"><%=tasks.stream().filter(task -> task.getStatus().name().equals("OVERDUE")).count()%></h3>
                </div>
            </div>
        </div>
    </div>


    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">

        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow">
            <h2 class="text-xl font-semibold mb-4">Task Statistics</h2>
            <canvas id="tasksChart"></canvas>
            <div class="mt-10">
                le nombre de jetons utilises :
                <%=tasks.stream().filter(task -> task.isAssigned()).count()%>
            </div>
        </div>

        <div class="p-6 bg-white border border-gray-200 rounded-lg shadow">
            <h2 class="text-xl font-semibold mb-4">Task Status Breakdown</h2>
            <canvas id="statusChart"></canvas>
        </div>
    </div>
</div>


<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>


    async function fetchTasks() {
        try {
            const response = await fetch('http://localhost:9090/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log(data);

            return data;
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function initCharts() {
        const tasks = await fetchTasks();



        const completedTasksCount = tasks.filter(task => task.status === "DONE").length;
        const in_progressTasksCount = tasks.filter(task => task.status === "IN_PROGRESS").length;
        const overdueTasksCount = tasks.filter(task => task.status === "OVERDUE").length;
        const todoTasksCount = tasks.filter(task => task.status === "TODO").length;


        const ctx1 = document.getElementById('tasksChart').getContext('2d');
        const tasksChart = new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: ['Done', 'Todo','InProgress', 'Overdue'],
                datasets: [{
                    label: 'Tasks Overview',
                    data: [completedTasksCount,todoTasksCount, in_progressTasksCount, overdueTasksCount],
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });


        const ctx2 = document.getElementById('statusChart').getContext('2d');
        const statusChart = new Chart(ctx2, {
            type: 'pie',
            data: {
                labels: ['Done', 'Todo','InProgress', 'Overdue'],
                datasets: [{
                    label: 'Task Status Distribution',
                    data: [completedTasksCount,todoTasksCount, in_progressTasksCount, overdueTasksCount],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 205, 86, 0.6)',
                        'rgba(255, 99, 132, 0.6)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 205, 86, 1)',
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    }
                }
            }
        });
    }


    initCharts();
</script>

</body>
</html>
