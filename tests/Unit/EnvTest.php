<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ConfigTest extends TestCase
{
    /**
     * Check .env file exists.
     */
    public function testEnvExists(): void
    {
        $this->assertFileExists(__DIR__.'/../../.env');
    }
}
