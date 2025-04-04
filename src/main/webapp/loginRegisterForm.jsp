<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/loginRegister.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/loginRegister.js"></script>
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

</head>
<body class="bg-cover bg-center" style="background-image: url('<%= request.getContextPath() %>/static/img/login-background.jpg');">
    <div class="capsule rounded-xl">
        <div class="right-slant-seperator opacity-50"></div>
        <div class="left-slant-seperator opacity-50"></div>


        <!--LOGIN FORM-->
        <div class="form-box Login">
            <h1 class="switch-animation" style="--X:0; --Z:15">Login</h1>
            <form action="#">
                <div class="input-box switch-animation" style="--X:1; --Z:16">
                    <input type="text" required>
                    <label>Username</label>
                    <span class="icon-[tabler--user] size-5"></span>
                </div>
                <div class="input-box switch-animation" style="--X:2; --Z:17">
                    <input type="password" required>
                    <label>Password</label>
                    <span class="icon-[tabler--lock] size-5"></span>
                </div>
                <div class="input-box switch-animation" style="--X:3; --Z:18">
                    <button class="button" type="submit">Login</button>
                </div>
                <div class="register-link switch-animation" style="--X:4; --Z:19">
                    <p>Don't have an account? <a href="#" class="signUpLink">Sign up now!</a></p>
                </div>
            </form>
        </div>
        <div class="info-segment Login">
            <h2 class="switch-animation" style="--X:0; --Z:15">WELCOME BACK!</h2>
            <p class="switch-animation" style="--X:1; --Z:16">Happy to see you again! Ready to purchase more?
            </p>
        </div>


        <!--REGISTER FORM-->
        <div class="form-box Register">
            <h2 class="switch-animation" style="--Y:16; --Z:0">Register</h2>
            <form action="#">
                <div class="input-box switch-animation" style="--Y:17; --Z:1">
                    <input type="text" name="username" id="username" placeholder='' required>
                    <label for="username">Username</label>
                    <span class="icon-[tabler--user] size-5"></span>
                </div>
                
                <div class="input-box switch-animation" style="--Y:18; --Z:2">
                    <input type="email" name="email" id="email" placeholder='' required>
                    <label for="email">Email</label>
                    <span class="icon-[tabler--mail] size-5"></span>
                </div>

                <div class="input-box switch-animation" style="--Y:19; --Z:3">
                    <input type="password" name="password" id="password" placeholder='' required>
                    <label for="password">Password</label>
                    <span class="icon-[tabler--lock] size-5"></span>
                </div>
                <div class="input-box switch-animation" style="--Y:20; --Z:4">
                    <input type="text" name="birthdate" onfocus="(this.type='date')" onblur="if(!this.value) (this.type='text')"  id="birthdate" placeholder='' required>
                    <label for="birthdate">Date of Birth</label>
                    <span class="icon-[tabler--cake] size-5"></span>
                </div>
                <div class="input-box switch-animation" style="--Y:21; --Z:5">
                    <button class="button" type="submit">Register</button>
                </div>
                <div class="register-link switch-animation" style="--Y:22; --Z:6">
                    <p>Already have an account? <a href="#" class="loginLink">Log in now!</a></p>
                </div>
            </form>
        </div>
        <div class="info-segment Register">
            <h2 class="switch-animation" style="--Y:16; --Z:0">HELLO! WELCOME!</h2>
            <p class="switch-animation" style="--Y:17; --Z:1">Sign up now to be part of our community, and start shopping!
            </p>
        </div>
    </div>
</body>
</html>