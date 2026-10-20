
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.dao.AdminUserDAO.Customer" %>

<%
    List<Customer> customers =
        (List<Customer>) request.getAttribute("customers");

    String updated = request.getParameter("updated");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers | ShopSphere Admin</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f4f6fb;
            color: #1f2937;
            font-family: Arial, Helvetica, sans-serif;
        }

        .admin-header {
            background: #172554;
            color: #fff;
            padding: 22px 5%;
        }

        .header-inner {
            max-width: 1250px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .brand {
            margin: 0;
            font-size: 25px;
        }

        .brand span {
            color: #93c5fd;
        }

        .subtitle {
            margin: 7px 0 0;
            color: #cbd5e1;
            font-size: 14px;
        }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 9px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            border: 1px solid #64748b;
            border-radius: 8px;
            padding: 10px 13px;
            font-size: 14px;
        }

        .nav-links a:hover {
            background: #263b70;
        }

        .container {
            max-width: 1250px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-heading {
            margin-bottom: 22px;
        }

        .page-heading h2 {
            margin: 0 0 7px;
            font-size: 27px;
        }

        .page-heading p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
        }

        .alert {
            padding: 14px 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
        }

        .alert-success {
            color: #166534;
            background: #dcfce7;
            border: 1px solid #bbf7d0;
        }

        .table-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.04);
        }

        .table-scroll {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
        }

        thead {
            background: #f8fafc;
        }

        th {
            padding: 16px 14px;
            text-align: left;
            color: #475569;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            white-space: nowrap;
            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 15px 14px;
            font-size: 14px;
            border-bottom: 1px solid #eef2f7;
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .customer-id {
            color: #64748b;
        }

        .customer-name {
            font-weight: 600;
            color: #1e293b;
        }

        .customer-email {
            color: #2563eb;
            overflow-wrap: anywhere;
        }

        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
        }

        .badge-active {
            background: #dcfce7;
            color: #166534;
        }

        .badge-inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .action-form {
            margin: 0;
        }

        .btn {
            padding: 9px 12px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            white-space: nowrap;
        }

        .btn-deactivate {
            background: #fee2e2;
            color: #b91c1c;
        }

        .btn-deactivate:hover {
            background: #fecaca;
        }

        .btn-activate {
            background: #dcfce7;
            color: #166534;
        }

        .btn-activate:hover {
            background: #bbf7d0;
        }

        .empty-state {
            text-align: center;
            padding: 45px 20px;
            color: #64748b;
        }

        .empty-state strong {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-size: 17px;
        }

        .table-footer {
            padding: 14px 18px;
            border-top: 1px solid #e5e7eb;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .admin-header {
                padding: 18px 20px;
            }

            .brand {
                font-size: 22px;
            }

            .container {
                margin: 22px auto;
                padding: 0 12px;
            }

            .page-heading h2 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>

<header class="admin-header">
    <div class="header-inner">
        <div>
            <h1 class="brand">Shop<span>Sphere</span> Admin</h1>
            <p class="subtitle">Manage customer accounts and account status</p>
        </div>

        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/admin/dashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/admin/products">Products</a>
            <a href="<%= request.getContextPath() %>/admin/categories">Categories</a>
            <a href="<%= request.getContextPath() %>/admin/orders">Orders</a>
        </nav>
    </div>
</header>

<main class="container">

    <div class="page-heading">
        <h2>Customer Management</h2>
        <p>View registered customers and activate or deactivate their accounts.</p>
    </div>

    <% if ("1".equals(updated)) { %>
        <div class="alert alert-success" role="status">
            Customer status updated successfully.
        </div>
    <% } %>

    <section class="table-card">
        <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer Name</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Registered At</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                <% if (customers == null || customers.isEmpty()) { %>
                    <tr>
                        <td colspan="7">
                            <div class="empty-state">
                                <strong>No customers found</strong>
                                Registered customer accounts will appear here.
                            </div>
                        </td>
                    </tr>
                <% } else {
                       for (Customer customer : customers) { %>
                    <tr>
                        <td class="customer-id">
                            #<%= customer.getUserId() %>
                        </td>

                        <td class="customer-name">
                            <%= customer.getName() == null ? "" : customer.getName() %>
                        </td>

                        <td class="customer-email">
                            <%= customer.getEmail() == null ? "" : customer.getEmail() %>
                        </td>

                        <td>
                            <%= customer.getMobile() == null ? "" : customer.getMobile() %>
                        </td>

                        <td>
                            <%= customer.getCreatedAt() == null ? "" : customer.getCreatedAt() %>
                        </td>

                        <td>
                            <% if (customer.isStatus()) { %>
                                <span class="badge badge-active">Active</span>
                            <% } else { %>
                                <span class="badge badge-inactive">Inactive</span>
                            <% } %>
                        </td>

                        <td>
                            <form class="action-form"
      method="post"
      action="<%= request.getContextPath() %>/admin/users"
      onsubmit="return confirm('Are you sure you want to change this customer status?');">

                                <input type="hidden"
                                       name="userId"
                                       value="<%= customer.getUserId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="<%= customer.isStatus() ? "0" : "1" %>">

                                <% if (customer.isStatus()) { %>
                                    <button class="btn btn-deactivate" type="submit">
                                        Deactivate
                                    </button>
                                <% } else { %>
                                    <button class="btn btn-activate" type="submit">
                                        Activate
                                    </button>
                                <% } %>
                            </form>
                        </td>
                    </tr>
                <%     }
                   } %>
                </tbody>
            </table>
        </div>

        <% if (customers != null && !customers.isEmpty()) { %>
            <div class="table-footer">
                Total customers displayed: <%= customers.size() %>
            </div>
        <% } %>
    </section>

</main>

</body>
</html>