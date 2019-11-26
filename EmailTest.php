<?php
use PHPUnit\Framework\TestCase;

/*require __DIR__ . "/../src/Email.php";*/

final class EmailTest extends TestCase
{
    public function testCanBeCreatedFromValidEmailAddress()
    {
        $this->assertInstanceOf(
            Email::class,
            Email::fromString('user@vega.com.vn')
        );
    }

    public function testCannotBeCreatedFromInvalidEmailAddress()
    {
        $this->expectException(InvalidArgumentException::class);

        Email::fromString('viethd@vega.com');
    }

}
?>
