From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 08 Aug 2012 19:17:18 +0000
Subject: Re: [PATCH 8/8] ARM: vt8500: gpio: Devicetree support for arch-vt8500
Message-Id: <201208081917.19111.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
 <5022B242.1050001@wwwdotorg.org>
In-Reply-To: <5022B242.1050001@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 08 August 2012, Stephen Warren wrote:
> I think that's all just:
> 
> module_platform_driver(vt8500_gpio_driver);
> 
> (except that _init uses platform_driver_probe() rather than
> platform_driver_register(), which seems unusual. I guess that explains
> the of_find_matching_node() above too.)

Ah, I totally missed both of these. Using platform_driver_register
is definitely preferred over platform_driver_probe in cases like
this, so using module_platform_driver is the right simplification.

	Arnd
