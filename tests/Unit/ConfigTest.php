<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function testEnvConfigExists(): void
    {
        $this->assertFileExists(getcwd() . DIRECTORY_SEPARATOR . '.env');
    }
}
