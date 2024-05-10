<?php

namespace Tests\Feature;

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
}
