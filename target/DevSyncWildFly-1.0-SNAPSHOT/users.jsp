<%@ page import="com.example.devsyncss.entities.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/profile.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }

        .form-group label {
            font-weight: bold;
            color: #343a40;
        }

        .table th, .table td {
            vertical-align: middle;
            color: #343a40;
        }

        .btn-primary {
            background-color: #343a40;
            border: none;
        }

        .btn-primary:hover {
            background-color: #23272b;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .modal-header {
            background-color: #343a40;
            color: #fff;
        }

        .modal-footer .btn-primary {
            background-color: #343a40;
            border: none;
        }

        .modal-footer .btn-primary:hover {
            background-color: #23272b;
        }
    </style>
</head>
<body>
    <% List<User> users = (List<User>) request.getAttribute("users"); %>
<%@ include file="shared/_header.jsp" %>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <h1>Users</h1>
        </div>
        <%@ include file="shared/_alert.jsp" %>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addUserModal">
                Add User
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-center">Users</h2>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (User u : users) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getUsername() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getRole() %></td>
                            <td>
                                <a href="users/<%= u.getId() %>" class="btn btn-primary">Edit</a>
                                <form action="delete-user/<%= u.getId() %>" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Add User</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="add-user" method="post">
                    <div class="form-group mt-3">
                        <label for="username">Username</label>
                        <input type="text" name="username" id="username" class="form-control">
                    </div>
                    <div class="form-group mt-3">
                        <label for="firstName">First Name</label>
                        <input type="text" name="firstName" id="firstName" class="form-control">
                    </div>
                    <div class="form-group mt-3">
                        <label for="lastName">Last Name</label>
                        <input type="text" name="lastName" id="lastName" class="form-control">
                    </div>
                    <div class="form-group mt-3">
                        <label for="email">Email</label>
                        <input type="email" name="email" id="email" class="form-control">
                    </div>
                    <div class="form-group mt-3">
                        <label for="role">Role</label>
                        <select name="role" id="role" class="form-control">
                            <option value="USER">User</option>
                            <option value="MANAGER">Manager</option>
                        </select>
                    </div>
                    <div class="form-group mt-3">
                        <label for="manager">Manager</label>
                        <select name="managerId" id="manager" class="form-control">
                            <% List<User> Managers = users.stream().filter((u)->u.getRole().name().equalsIgnoreCase("MANAGER")).collect(Collectors.toList()); %>
                            <option value="" selected>Select Manager</option>
                            <% for (User u : Managers) { %>
                                <option value="<%= u.getId() %>"><%= u.getFirstName() %> <%= u.getLastName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group mt-3">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" class="form-control">
                    </div>
                    <div class="form-group mt-3">
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>