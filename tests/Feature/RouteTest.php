<?php

namespace Tests\Feature;

use Tests\TestCase;

class RouteTest extends TestCase
{
    /**
     * Get home route.
     *
     * @return void
     */
    public function testHomeRouteExists()
    {
        $this->get(route('home'))->assertSuccessful();
    }
}
