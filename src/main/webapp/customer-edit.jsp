<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Edit Customer</title>

    <!-- Tailwind CDN with runtime config for custom colors & animations -->
    <script>
        tailwind = window.tailwind || {};
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4f46e5',
                        secondary: '#475569',
                        slate: '#f1f5f9'
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in',
                        'slide-up': 'slideUp 0.5s ease-out',
                        'bounce-in': 'bounceIn 0.5s cubic-bezier(0.36,0,0.66,1)',
                        'spin-slow': 'spin 3s linear infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': {opacity: '0'},
                            '100%': {opacity: '1'},
                        },
                        slideUp: {
                            '0%': {transform: 'translateY(20px)', opacity: '0'},
                            '100%': {transform: 'translateY(0)', opacity: '1'},
                        },
                        bounceIn: {
                            '0%': {transform: 'scale(0.3)', opacity: '0'},
                            '50%': {transform: 'scale(1.05)'},
                            '70%': {transform: 'scale(0.9)'},
                            '100%': {transform: 'scale(1)', opacity: '1'},
                        }
                    }
                }
            }
        }
    </script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #f6f8fc 0%, #e9edf5 100%);
        }

        .form-input {
            @apply px-4 py-2.5 rounded-lg border border-gray-300 bg-white focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary transition-all duration-300 hover:shadow-md;
        }

        .form-label {
            @apply text-sm font-medium text-gray-700 mb-1.5 flex items-center gap-2;
        }

        .gradient-text {
            @apply bg-clip-text text-transparent bg-gradient-to-r from-primary to-purple-600;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-6">

<%
    Customer customer = (Customer) request.getAttribute("customer");
%>

<div class="max-w-4xl w-full animate-fade-in">
    <div class="mb-8 flex justify-between items-center">
        <div>
            <h1 class="text-3xl font-bold gradient-text">Edit Customer Details</h1>
            <p class="mt-1 text-sm text-gray-600 animate-slide-up">Update information for <%= customer.getFull_name() %>
            </p>
        </div>

        <a href="listCustomers"
           class="inline-flex items-center gap-2 text-gray-600 hover:text-primary transition-colors duration-300">
            <i class="fas fa-arrow-left"></i>
            Back to List
        </a>
    </div>

    <div class="bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden hover:shadow-xl transition-shadow duration-300 animate-bounce-in">
        <div class="p-8">
            <form action="updateCustomer" method="post" class="space-y-6">
                <input type="hidden" name="customer_id" value="<%= customer.getCustomer_id() %>"/>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <label class="block group">
                        <span class="form-label"><i class="fas fa-hashtag text-primary"></i> Account Number</span>
                        <input type="text" name="account_number" value="<%= customer.getAccount_number() %>"
                               class="form-input w-full group-hover:border-primary" required/>
                    </label>

                    <label class="block group">
                        <span class="form-label"><i class="fas fa-user text-primary"></i> Full Name</span>
                        <input type="text" name="full_name" value="<%= customer.getFull_name() %>"
                               class="form-input w-full group-hover:border-primary" required/>
                    </label>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <label class="block group">
                        <span class="form-label"><i class="fas fa-location-dot text-primary"></i> Address</span>
                        <input type="text" name="address" value="<%= customer.getAddress() %>"
                               class="form-input w-full group-hover:border-primary" required/>
                    </label>

                    <label class="block group">
                        <span class="form-label"><i class="fas fa-phone text-primary"></i> Contact Number</span>
                        <input type="text" name="contact_no" value="<%= customer.getContact_no() %>"
                               class="form-input w-full group-hover:border-primary" required/>
                    </label>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <label class="block group">
                        <span class="form-label"><i class="fas fa-bolt text-primary"></i> Units Consumed</span>
                        <input type="number" name="unit_consumed" value="<%= customer.getUnit_consumed() %>"
                               class="form-input w-full group-hover:border-primary" required min="0"/>
                    </label>
                </div>

                <div class="flex items-center justify-end gap-4 pt-4 border-t">
                    <a href="listCustomers"
                       class="px-4 py-2 text-sm font-medium text-gray-700 hover:text-gray-900 transition-colors duration-300">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </a>

                    <button type="submit"
                            class="px-6 py-2.5 bg-gradient-to-r from-primary to-purple-600 text-white text-sm font-medium rounded-lg hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-primary/50 active:opacity-80 transition-all duration-300 flex items-center gap-2">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <p class="mt-4 text-sm text-center text-gray-500 animate-slide-up">
        <i class="fas fa-info-circle mr-2 text-primary"></i>
        Please review all information carefully before saving changes
    </p>
</div>

</body>
</html>