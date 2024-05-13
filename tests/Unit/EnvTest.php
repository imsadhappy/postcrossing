<?php

namespace Tests\Unit;

use Tests\TestCase;
//use PHPUnit\Framework\TestCase;

class EnvTest extends TestCase
{
    /**
     * Check .env file exists.
     */
    public function testEnvExists(): void
    {
        $this->assertFileExists(sprintf('%s/../../.env.%s', __DIR__, $this->app['env']));
    }
}
