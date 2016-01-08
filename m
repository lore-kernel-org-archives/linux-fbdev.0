From: Carlos Soto <csotoalonso@gmail.com>
Date: Fri, 08 Jan 2016 20:18:41 +0000
Subject: Re: imxfb does not turn on automatically
Message-Id: <CAD7j7Q8gANUxM5zGmn3YyhUr9yZv02x4oxi_WWLnxCYemBRYZA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
In-Reply-To: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2015-02-21 16:18 GMT+01:00 Fabio Estevam <festevam@gmail.com>:
>
> Hi,
>
> Carlos Soto uses a Karo mx25 and he noticed that the LCD only works if we do:
>
> echo 1 > /sys/class/graphics/fb0/blank
> echo 0 > /sys/class/graphics/fb0/blank
>
> I can confirm the same on mx25pdk running 3.19 [1], but I could not
> understand why the display does not start turned on by default.
>
> [1] http://www.spinics.net/lists/arm-kernel/msg399949.html
>
> Any ideas?
>
> Thanks,
>
> Fabio Estevam



Hi,
I know it's been a long time since Fabio posted the issue but recently
I had some time to work on it again, and I've narrowed it down a
little.

The problem seems to be related to the IPG clock used by the iMX25
framebuffer. All clocks used by the fb are enabled in
imxfb_enable_controller(...)

...
clk_prepare_enable(fbi->clk_ipg);
clk_prepare_enable(fbi->clk_ahb);
clk_prepare_enable(fbi->clk_per);
fbi->enabled = true;

...


But if the IPG clock is disabled and enabled right after, the LCD
works fine.

The changes made in imxfb.c were:
...

clk_prepare_enable(fbi->clk_ipg);
clk_disable_unprepare(fbi->clk_ipg);
clk_prepare_enable(fbi->clk_ipg);

clk_prepare_enable(fbi->clk_ahb);
clk_prepare_enable(fbi->clk_per);
fbi->enabled = true;

...

It was suggested by Fabio that this could be caused by a wrong clock
reference count which prevented the IPG fb clock to be enabled, but
I've checked in debugfs, and both enable_cnt  and prepare_cnt seem OK
for all three FB clocks.

So, I'm really stuck here. Any hints would be greatly appreciated.

Thanks,
Carlos Soto

2015-02-21 16:18 GMT+01:00 Fabio Estevam <festevam@gmail.com>:
> Hi,
>
> Carlos Soto uses a Karo mx25 and he noticed that the LCD only works if we do:
>
> echo 1 > /sys/class/graphics/fb0/blank
> echo 0 > /sys/class/graphics/fb0/blank
>
> I can confirm the same on mx25pdk running 3.19 [1], but I could not
> understand why the display does not start turned on by default.
>
> [1] http://www.spinics.net/lists/arm-kernel/msg399949.html
>
> Any ideas?
>
> Thanks,
>
> Fabio Estevam
