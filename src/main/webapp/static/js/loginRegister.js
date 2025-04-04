const capsule=document.querySelector('.capsule');
const LoginLink=document.querySelector('.loginLink');
const RegisterLink=document.querySelector('.signUpLink');

RegisterLink.addEventListener('click', ()=> {
    capsule.classList.add('active');
})

LoginLink.addEventListener('click', ()=> {
    capsule.classList.remove('active');
})