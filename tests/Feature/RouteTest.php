<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * Get home route.
     *
     * @return void
     */
    public function testHome()
    {
        $this->get(route('home'))->assertSuccessful();
    }
}
