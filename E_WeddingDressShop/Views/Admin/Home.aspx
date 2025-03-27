<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="E_WeddingDressShop.Views.Admin.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
            max-width: 1100px;
            width: 100%;
        }

        .card {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .card h3 {
                margin: 0;
                font-size: 16px;
                color: #666666;
            }

            .card .value {
                font-size: 28px;
                font-weight: bold;
                margin: 10px 0;
                color: #0066ff;
            }

        .chart {
            height: 120px;
            background: linear-gradient(90deg, #0066ff, #cccccc);
            border-radius: 8px;
        }

        .bar-chart {
            display: flex;
            justify-content: space-around;
            align-items: flex-end;
            height: 120px;
            background-color: #f0f0f0;
            border-radius: 8px;
            padding: 10px;
        }

        .bar {
            width: 20px;
            background-color: #0066ff;
            border-radius: 4px;
        }

        .pie-chart {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: conic-gradient(#cccccc 0, #cccccc 100%);
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="dashboard">
                <!-- Card 1 -->
                <div class="card">
                    <h3>Total Sales</h3>
                    <asp:Label ID="lblTotalSales" runat="server" CssClass="value" Text="15,984.12 USD"></asp:Label>
                    <small>7D ▲ 1.2%</small>
                </div>

                <!-- Card 2 -->
                <div class="card">
                    <h3>Gross Sales</h3>
                    <asp:Label ID="lblGrossSales" runat="server" CssClass="value" Text="246 USD"></asp:Label>
                    <small>7D ▼ 1.2%</small>
                </div>

                <!-- Card 3: Delivery Types -->
                <div class="card">
                    <h3>Delivery Types</h3>
                    <div class="pie-chart" id="pieChart"></div>
                    <ul id="pieLegend">
                        <!-- Legend items will be dynamically populated -->
                    </ul>
                </div>

                <!-- Card 4: Cancellations -->
                <div class="card">
                    <h3>Cancellations</h3>
                    <asp:Label ID="lblCancellations" runat="server" CssClass="value" Text="0.84%"></asp:Label>
                    <small>7D ▼ 1.6%</small>
                    <div class="bar-chart" id="barChart">
                        <!-- Bars will be dynamically populated -->
                    </div>
                </div>

                <!-- Additional Cards -->

            </div>
        </div>
        <script>
            // Biểu đồ cột
            const barData = [50, 20, 70, 90, 60];
            const barChartContainer = document.getElementById('barChart');

            // Render Bars
            barData.forEach(height => {
                const bar = document.createElement('div');
                bar.classList.add('bar');
                bar.style.height = `${height}%`;
                barChartContainer.appendChild(bar);
            });

            // Biểu đồ tròn (40+30+30=100%)
            const pieData = [
                { label: "Delivery", value: 30, color: "#0066ff" },
                { label: "Pickup", value: 30, color: "#ff9900" },
                { label: "Other", value: 40, color: "#cccccc" }
            ];

            const pieChartContainer = document.getElementById('pieChart');
            const pieLegendContainer = document.getElementById('pieLegend');

            // Render Pie Chart
            let currentAngle = 0;
            const pieSegments = pieData.map(data => {
                const angle = (data.value / 100) * 360;
                const startAngle = currentAngle;
                currentAngle += angle;
                return `${data.color} ${startAngle}deg ${currentAngle}deg`;
            }).join(', ');

            pieChartContainer.style.background = `conic-gradient(${pieSegments})`;

            // Render Pie Chart Legend
            pieData.forEach(data => {
                const legendItem = document.createElement('li');
                legendItem.textContent = `${data.label}: ${data.value}%`;
                legendItem.style.color = data.color;
                pieLegendContainer.appendChild(legendItem);
            });
        </script>
    </form>
</body>
</html>
