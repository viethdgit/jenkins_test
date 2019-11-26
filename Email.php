<html>
<body>
Ver:5<br>
<form action = "<?php $_PHP_SELF ?>" method = "POST">
    Mail: <input type="text" name="fname"/>
<input type="submit"/>
</form>
<?php
class Email
{
    private $email;
    private function __construct($email) {
        $this->ensureIsValidEmail($email);
        $this->email=$email;
    }
    public function __toString() {
        return $this->email;
    }
    public function fromString(string $email): self {
        return new self($email);
    }
    private function ensureIsValidEmail(string $email)
    {
        /*if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {*/
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo 'Not a valid email address';
            throw new InvalidArgumentException(
                sprintf('"%s" is not a valid email address',$email)
            );
        }
        /*elseif (!strpos($email, "@vega.com.vn")) {*/
        elseif (substr($email, -12) !== "@vega.com.vn") {
            echo 'Not a vega email address';
            throw new InvalidArgumentException(sprintf('"%s" is not a vega email address',$email));
        }
    }
}

if ($_POST["fname"]) {
    /*$sinhvien = new Email($_POST['fname']); }
    $sinhvien = new Email();*/
    $sinhvien = Email::fromString($_POST['fname']);
    echo $sinhvien->__toString();
}
?>
</body>
</html>
