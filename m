From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Mon, 18 Mar 2013 11:20:07 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <CAHkwnC-aHwd24S5MyLhnVzTqqQj2L7MMuVX9dirhS-G830jZcw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <201303152018.09094.arnd@arndb.de>
 <CAHkwnC9YFTw8gVzyZB3_gZCgM5zMA6tLch15EDqcA2F4CAOpAQ@mail.gmail.com>
 <201303181058.51641.arnd@arndb.de>
In-Reply-To: <201303181058.51641.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 18, 2013 at 11:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 March 2013, Fabio Porcedda wrote:
>> Since by using platform_driver_probe() the  function
>> ep93xx_pwm_probe() is freed after initialization,
>> is better to use module_platform_drive_probe().
>> IMHO i don't see any good reason to use module_platform_driver() for
>> this driver.
>
> As I commented earlier, the platform_driver_probe() and
> module_platform_drive_probe() interfaces are rather dangerous in combination
> with deferred probing, I would much prefer Harley's patch.

Since those drivers don't use -EPROBE_DEFER i was thinking that they don't use
deferred probing.
I'm missing something?

Best regards
Fabio Porcedda

>         Arnd
