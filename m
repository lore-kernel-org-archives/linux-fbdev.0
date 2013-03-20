From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2013 10:20:14 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <201303201020.14654.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <201303191759.27762.arnd@arndb.de>
 <CAHkwnC-3_dDM3JO8y3yeNFz7=fpP=MtZ9D-3cMH8rNF9C1NZBA@mail.gmail.com>
In-Reply-To: <CAHkwnC-3_dDM3JO8y3yeNFz7=fpP=MtZ9D-3cMH8rNF9C1NZBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 20 March 2013, Fabio Porcedda wrote:
> I think we can check inside the  deferred_probe_work_func()
> if the dev->probe function pointer is equal to platform_drv_probe_fail().

I think it's too late by then, because that would only warn if we try to probe
it again, but when platform_driver_probe() does not succeed immediately, it
unregisters the driver again, so we never get there.

	Arnd
