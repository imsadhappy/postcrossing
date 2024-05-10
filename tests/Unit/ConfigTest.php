<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ConfigTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function testEnvConfigExists(): void
    {
        $this->assertFileExists(__DIR__.'/../../.env');
    }
}
