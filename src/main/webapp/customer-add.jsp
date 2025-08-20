<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Customer Form</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        :root {
            --primary: #ff6d4d;
            --secondary: #309afc;
            --accent: #27f4ff;
        }

        /* gentle float animation for icons */
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-6px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        .dahsboardbtn{
            background-color: var(--secondary);
        }

        .icon-float {
            animation: float 3s ease-in-out infinite;
        }

        /* subtle pulse for CTA */
        @keyframes pulse-slow {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.03);
                opacity: .95;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        .pulse-slow {
            animation: pulse-slow 2.5s infinite;
        }

        /* motion-safe reduced animation */
        @media (prefers-reduced-motion: reduce) {
            .icon-float, .pulse-slow {
                animation: none;
            }
        }

        @media (max-width: 640px) {
            .form-container {
                padding: 1rem;
            }

            .input-group {
                margin-bottom: 1rem;
            }

            .actions {
                flex-direction: column;
                gap: 1rem;
            }

            .actions button,
            .actions a {
                width: 100%;
            }
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-b from-[#ffffff] to-[#fbfbfb] flex items-center justify-center p-4 sm:p-6">
<%
    Customer customer = (Customer) request.getAttribute("customer");
    boolean isEdit = (customer != null);
%>

<div class="w-full max-w-3xl">
    <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4 mb-6">
        <!-- Animated book icon -->
        <div class="w-16 h-16 rounded-lg flex items-center justify-center shadow-lg bg-white icon-float">
            <svg width="36" height="36" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M3 6.5C3 5.67157 3.67157 5 4.5 5H20" stroke="var(--primary)" stroke-width="1.5"
                      stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M20 19.5C20 20.3284 19.3284 21 18.5 21H4" stroke="var(--secondary)" stroke-width="1.5"
                      stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 5v14" stroke="var(--accent)" stroke-width="1.5" stroke-linecap="round"
                      stroke-linejoin="round"/>
                <path d="M12 8.5v7" stroke="var(--primary)" stroke-width="1.6" stroke-linecap="round"
                      stroke-linejoin="round"/>
            </svg>
        </div>
        <div>
            <h1 class="text-2xl font-semibold text-gray-800"><%= isEdit ? "Edit Customer" : "Add Customer" %>
            </h1>
            <p class="text-sm text-gray-500">Add or update book store customer details. Fields marked * are
                required.</p>
        </div>
    </div>

    <div class="bg-white rounded-xl shadow-md p-4 sm:p-6 md:p-8 border border-gray-100">
        <form action="CustomerServlet" method="get" class="space-y-4 sm:space-y-5">
            <input type="hidden" name="action" value="<%= isEdit ? "UPDATE" : "INSERT" %>"/>
            <% if (isEdit) { %>
            <input type="hidden" name="customer_id" value="<%= customer.getCustomer_id() %>"/>
            <% } %>

            <!-- Form Fields -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-6">
                <!-- Account Number -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Account Number *</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-[#ff6d4d] icon-float" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.2"/>
                                <path d="M8 12h8" stroke="currentColor" stroke-width="1.4" stroke-linecap="round"/>
                            </svg>
                        </span>
                        <input type="text" name="account_number" required
                               pattern="ACC[0-9]{3}"
                               placeholder="ACC001"
                               value="<%= isEdit ? customer.getAccount_number() : "" %>"
                               class="pl-11 pr-3 py-2 w-full rounded-lg border border-gray-200 focus:ring-2 focus:ring-[#ff6d4d]/25 focus:border-[#ff6d4d] transition"/>
                    </div>
                    <p class="text-xs text-gray-400 mt-1">Format: ACC followed by 3 digits</p>
                </div>

                <!-- Full Name -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
                    <div class="relative group">
                        <span class="absolute inset-y-0 left-0 pl-3 flex items-center">
                            <svg class="w-5 h-5 text-[#309afc] group-focus-within:scale-110 transition-transform"
                                 viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 12c2.5 0 4.5-2 4.5-4.5S14.5 3 12 3 7.5 5 7.5 7.5 9.5 12 12 12z"
                                      stroke="currentColor" stroke-width="1.3" stroke-linecap="round"
                                      stroke-linejoin="round"/>
                                <path d="M4 21a8 8 0 0 1 16 0" stroke="currentColor" stroke-width="1.3"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </span>
                        <input type="text" name="full_name" required
                               placeholder="John Vick"
                               value="<%= isEdit ? customer.getFull_name() : "" %>"
                               class="pl-11 pr-3 py-2 w-full rounded-lg border border-gray-200 focus:ring-2 focus:ring-[#309afc]/25 focus:border-[#309afc] transition"/>
                    </div>
                </div>

                <!-- Address -->
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Address *</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-3 flex items-center">
                            <svg class="w-5 h-5 text-[#27f4ff]" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C8 6 6 8 6 11a6 6 0 1 0 12 0c0-3-2-5-6-9z" stroke="currentColor"
                                      stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                                <circle cx="12" cy="11" r="1.5" fill="currentColor"/>
                            </svg>
                        </span>
                        <input type="text" name="address" required
                               placeholder="1234 Main St"
                               value="<%= isEdit ? customer.getAddress() : "" %>"
                               class="pl-11 pr-3 py-2 w-full rounded-lg border border-gray-200 focus:ring-2 focus:ring-[#27f4ff]/25 focus:border-[#27f4ff] transition"/>
                    </div>
                </div>

                <!-- Contact No -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Contact No *</label>
                    <div class="relative group">
                        <span class="absolute inset-y-0 left-0 pl-3 flex items-center">
                            <svg class="w-5 h-5 text-[#ff6d4d] group-focus-within:rotate-12 transition-transform"
                                 viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M22 16.92V21a1 1 0 0 1-1.11 1 19.86 19.86 0 0 1-8.63-3.07 19.53 19.53 0 0 1-6-6A19.86 19.86 0 0 1 2 3.11 1 1 0 0 1 3 2h4.09a1 1 0 0 1 1 .75c.12.77.34 1.52.64 2.23a1 1 0 0 1-.24 1.02L7.88 8.88a14.48 14.48 0 0 0 6 6l1.88-1.59a1 1 0 0 1 1.02-.24c.71.3 1.46.52 2.23.64a1 1 0 0 1 .75 1V21z"
                                      stroke="currentColor" stroke-width="1.1" stroke-linecap="round"
                                      stroke-linejoin="round"/>
                            </svg>
                        </span>
                        <input type="tel" name="contact_no" required
                               pattern="[0]{1}[7]{1}[0-9]{8}"
                               placeholder="07XXXXXXXX"
                               value="<%= isEdit ? customer.getContact_no() : "" %>"
                               class="pl-11 pr-3 py-2 w-full rounded-lg border border-gray-200 focus:ring-2 focus:ring-[#ff6d4d]/25 focus:border-[#ff6d4d] transition"/>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex flex-col sm:flex-row items-center justify-between gap-4 pt-4">
                <button type="submit"
                        class="w-full sm:w-auto flex items-center justify-center gap-3 px-5 py-2.5 rounded-lg text-white font-medium shadow-md pulse-slow"
                        style="background: linear-gradient(90deg, var(--primary), var(--secondary)); box-shadow: 0 6px 18px rgba(51,65,85,0.08);">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M5 12h14M12 5l7 7-7 7" stroke="rgba(255,255,255,0.95)" stroke-width="1.4"
                              stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span><%= isEdit ? "Update" : "Save" %></span>
                </button>

                <a href="dashboard.jsp" class="dahsboardbtn inline-flex items-center gap-2 px-4 py-2 rounded-lg text-white font-medium shadow hover:bg-brand.accent/90 transition">
                    <i class="fa-solid fa-gauge"></i> Dashboard
                </a>

                <a href="listCustomers"
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2 text-sm text-gray-600 px-4 py-2.5 rounded-lg border border-gray-200 hover:bg-gray-50 transition">
                    <svg class="w-4 h-4 text-gray-500" viewBox="0 0 24 24" fill="none"
                         xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 18l-6-6 6-6" stroke="currentColor" stroke-width="1.4" stroke-linecap="round"
                              stroke-linejoin="round"/>
                    </svg>
                    Back to List
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
