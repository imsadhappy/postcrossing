<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\Artisan;
use Tests\TestCase;

class DBTest extends TestCase
{
    /**
     * Check if DB credentials are correct and DB exists.
     *
     * @return void
     */
    public function testDatabaseConnectionWorks()
    {
        $this->assertInstanceOf(\PDO::class, $this->getConnection()->getPdo());
    }

    /**
     * Purge database and migrate from scratch.
     *
     * @return void
     */
    public function testDatabaseResetForTests()
    {
        if ($this->app->environment('testing')) {
            Artisan::call('migrate:fresh');
            $this->assertTrue(true);
        } else {
            $this->markTestSkipped('skipping in ' . $this->app['env']);
        }
    }
}
