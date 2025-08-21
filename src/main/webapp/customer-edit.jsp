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
                        brand: {
                            DEFAULT: '#0f172a',    // deep navy for text
                            accent: '#06b6d4',     // teal-cyan accent
                            gradientFrom: '#7c3aed', // vivid purple
                            gradientTo: '#06b6d4'    // teal
                        },
                        neutralSoft: '#f8fafc'
                    },
                    boxShadow: {
                        'soft-lg': '0 10px 30px rgba(2,6,23,0.14)'
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.45s ease-in-out',
                        'float-up': 'floatUp 0.45s cubic-bezier(.2,.8,.2,1)'
                    },
                    keyframes: {
                        fadeIn: {'0%': {opacity: '0'}, '100%': {opacity: '1'}},
                        floatUp: {'0%': {transform: 'translateY(8px)', opacity: '0'}, '100%': {transform: 'translateY(0)', opacity: '1'}}
                    }
                }
            }
        }
    </script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Floating label pattern using Tailwind utilities but small CSS for transitions */
        .field-wrap {
            position: relative;
        }
        .save-chang{
            background-color: #3e79fb;
        }
        .floating-label {
            position: absolute;
            left: 14px;
            top: 12px;
            pointer-events: none;
            transition: all .18s ease;
            font-size: .875rem;
            color: rgba(15,23,42,0.55);
        }
        input:focus + .floating-label,
        input:not(:placeholder-shown) + .floating-label,
        textarea:focus + .floating-label,
        textarea:not(:placeholder-shown) + .floating-label {
            transform: translateY(-28px) scale(.92);
            color: rgba(124,58,237,1); /* purple */
        }

        /* small toast */
        .toast {
            position: fixed;
            right: 20px;
            bottom: 20px;
            background: linear-gradient(90deg,#10b981,#06b6d4);
            color: white;
            padding: 10px 16px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(2,6,23,0.15);
            transform: translateY(18px);
            opacity: 0;
            transition: all .28s ease;
            z-index: 60;
        }
        .toast.show { transform: translateY(0); opacity: 1; }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-neutralSoft via-white to-indigo-50 flex items-center justify-center p-6">

<%
    Customer customer = (Customer) request.getAttribute("customer");
%>

<div class="w-full max-w-5xl animate-fade-in">
    <div class="mb-6 flex items-center justify-between">
        <div class="flex items-center gap-4">
            <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-brand.gradientFrom to-brand.gradientTo flex items-center justify-center text-white text-2xl font-extrabold shadow-soft-lg">
                CU
            </div>
            <div>
                <h1 class="text-2xl font-semibold text-brand">Edit Customer</h1>
                <p class="text-sm text-slate-500">Update records for <span class="font-medium"><%= customer.getFull_name() %></span></p>
            </div>
        </div>

        <div class="flex items-center gap-3">
            <a href="listCustomers" class="text-sm text-slate-600 hover:text-brand.gradientFrom inline-flex items-center gap-2">
                <i class="fas fa-arrow-left"></i> Back to list
            </a>
        </div>
    </div>

    <div class="bg-white rounded-2xl shadow-soft-lg border border-gray-100 overflow-hidden grid grid-cols-1 lg:grid-cols-3 gap-0">
        <!-- Left: Summary / preview -->
        <aside class="p-6 bg-gradient-to-b from-white to-indigo-50 lg:rounded-l-2xl">
            <div class="mb-4">
                <h2 class="text-lg font-semibold text-brand">Customer Snapshot</h2>
                <p class="text-sm text-slate-500 mt-1">Quick overview & interactive preview</p>
            </div>

            <div class="space-y-3">
                <div class="rounded-lg p-4 bg-white border border-gray-100 shadow-sm">
                    <div class="text-xs text-slate-400">Account</div>
                    <div class="mt-1 font-medium text-brand.gradientFrom"><%= customer.getAccount_number() %></div>
                </div>

                <div class="rounded-lg p-4 bg-white border border-gray-100 shadow-sm">
                    <div class="text-xs text-slate-400">Contact</div>
                    <div class="mt-1 text-slate-700"><%= customer.getContact_no() %></div>
                    <div class="text-xs mt-1 text-slate-400"><%= customer.getAddress() %></div>
                </div>

                <div class="rounded-lg p-4 bg-gradient-to-r from-indigo-50 to-white border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <div class="text-xs text-slate-400">Estimated Bill</div>
                            <div id="estimateLabel" class="mt-1 text-2xl font-semibold text-brand.gradientTo">$0.00</div>
                        </div>
                        <div class="text-right text-xs text-slate-400">
                            <div>Unit Rate</div>
                            <div class="font-medium text-slate-700">$<span id="unitRateLabel">5.50</span>/unit</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-6 text-xs text-slate-500">
                Tip: Adjust "Units Consumed" to preview the estimated bill. Client-side validation will guide inputs.
            </div>
        </aside>

        <!-- Right: Form -->
        <main class="p-6 lg:col-span-2">
            <form id="editCustomerForm" action="updateCustomer" method="post" class="space-y-6" novalidate>
                <input type="hidden" name="customer_id" value="<%= customer.getCustomer_id() %>"/>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="field-wrap">
                        <input name="account_number" id="account_number" type="text" required
                               class="peer form-input block w-full px-4 py-3 rounded-xl border border-gray-200 bg-white focus:ring-2 focus:ring-brand.accent focus:border-transparent transition"
                               value="<%= customer.getAccount_number() %>" placeholder="ACC000" />
                        <label for="account_number" class="floating-label">Account Number</label>
                    </div>

                    <div class="field-wrap">
                        <input name="full_name" id="full_name" type="text" required
                               class="peer form-input block w-full px-4 py-3 rounded-xl border border-gray-200 bg-white focus:ring-2 focus:ring-brand.gradientFrom focus:border-transparent transition"
                               value="<%= customer.getFull_name() %>" placeholder="John Vick" />
                        <label for="full_name" class="floating-label">Full Name</label>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="field-wrap">
                        <input name="address" id="address" type="text" required
                               class="peer form-input block w-full px-4 py-3 rounded-xl border border-gray-200 bg-white focus:ring-2 focus:ring-brand.accent focus:border-transparent transition"
                               value="<%= customer.getAddress() %>" placeholder="No.01, Mian St, Torento" />
                        <label for="address" class="floating-label">Address</label>
                    </div>

                    <div class="field-wrap">
                        <input name="contact_no" id="contact_no" type="tel" pattern="[07]{2}[0-9]{8}" required
                               class="peer form-input block w-full px-4 py-3 rounded-xl border border-gray-200 bg-white focus:ring-2 focus:ring-brand.gradientFrom focus:border-transparent transition"
                               value="<%= customer.getContact_no() %>" placeholder="07XXXXXXXX" />
                        <label for="contact_no" class="floating-label">Contact Number</label>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                    <div class="field-wrap md:col-span-2">
                        <input id="unit_consumed" name="unit_consumed" type="number" min="0" required
                               class="peer form-input block w-full px-4 py-3 rounded-xl border border-gray-200 bg-white focus:ring-2 focus:ring-brand.accent focus:border-transparent transition"
                               value="<%= customer.getUnit_consumed() %>" placeholder="10" />
                        <label for="unit_consumed" class="floating-label">Units Consumed</label>
                    </div>

                    <div class="flex gap-3 items-center">
                        <div class="text-xs text-slate-500">Bill Preview</div>
                        <div id="miniEstimate" class="ml-auto text-right text-lg font-semibold text-brand.gradientFrom">$0.00</div>
                    </div>
                </div>

                <div class="flex items-center justify-between gap-4 pt-4 border-t">
                    <a href="listCustomers" class="px-4 py-2 text-sm rounded-lg text-slate-700 hover:text-white hover:bg-slate-700 transition flex items-center gap-2">
                        <i class="fas fa-times"></i> Cancel
                    </a>

                    <div class="flex items-center gap-3">
                        <button type="button" id="resetBtn"
                                class="px-4 py-2 text-sm rounded-lg bg-white border border-gray-200 text-slate-700 hover:bg-slate-50 transition">
                            Reset
                        </button>

                        <button type="submit"
                                class="save-chang inline-flex items-center gap-2 px-6 py-2.5 bg-gradient-to-r from-brand.gradientFrom to-brand.gradientTo text-white text-sm font-medium rounded-xl shadow hover:scale-[.995] focus:outline-none focus:ring-2 focus:ring-brand.accent transition">
                            <i class="fas fa-save"></i>
                            Save Changes
                        </button>
                    </div>
                </div>
            </form>

            <div class="mt-4 text-sm text-slate-500">
                <i class="fas fa-info-circle text-brand.gradientFrom mr-2"></i>
                Changes are saved to the database when you press "Save Changes".
            </div>
        </main>
    </div>
</div>

<!-- Toast -->
<div id="toast" class="toast" role="status" aria-live="polite">Saved successfully</div>

<script>
    (function () {
        const unitField = document.getElementById('unit_consumed');
        const estimateLabel = document.getElementById('estimateLabel');
        const miniEstimate = document.getElementById('miniEstimate');
        const unitRate = 5.50; // example per-unit rate (customize on server if needed)
        document.getElementById('unitRateLabel').textContent = unitRate.toFixed(2);

        function updateEstimate() {
            const units = parseFloat(unitField.value) || 0;
            const total = units * unitRate;
            const formatted = total.toLocaleString(undefined, {style:'currency', currency:'USD'});
            estimateLabel.textContent = formatted;
            miniEstimate.textContent = formatted;
        }

        // initialize
        updateEstimate();

        unitField.addEventListener('input', function () {
            // keep non-negative
            if (this.value < 0) this.value = 0;
            updateEstimate();
        });

        // form validation + toast
        const form = document.getElementById('editCustomerForm');
        const toast = document.getElementById('toast');
        form.addEventListener('submit', function (e) {
            if (!form.checkValidity()) {
                // let browser show native errors
                form.reportValidity();
                e.preventDefault();
                return;
            }
            // show quick saved toast while the form submits (server will actually update)
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 2200);
            // allow actual submit to proceed
        });

        // reset button to restore values from server-provided initial dataset
        document.getElementById('resetBtn').addEventListener('click', function () {
            // reset client fields to server values (read from rendered values)
            document.getElementById('account_number').value = "<%= customer.getAccount_number() %>";
            document.getElementById('full_name').value = "<%= customer.getFull_name() %>";
            document.getElementById('address').value = "<%= customer.getAddress() %>";
            document.getElementById('contact_no').value = "<%= customer.getContact_no() %>";
            document.getElementById('unit_consumed').value = "<%= customer.getUnit_consumed() %>";
            updateEstimate();
        });

        // enhance phone input UX: allow only certain chars
        const phone = document.getElementById('contact_no');
        phone.addEventListener('input', function () {
            // keep digits and basic symbols
            this.value = this.value.replace(/[^0-9+()\- \.]/g, '');
        });
    })();
</script>
</body>
</html>