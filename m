From: InKi Dae <daeinki@gmail.com>
Date: Wed, 30 Jun 2010 04:36:31 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <AANLkTikxu_p-F4iJnwiY7GvP0Zkf-WsZEAeLzfJuljlB@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29CFBD.3040205@samsung.com>
	<AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
In-Reply-To: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jaya,

2010/6/30 Jaya Kumar <jayakumar.lkml@gmail.com>:
> 2010/6/29 InKi Dae <inki.dae@samsung.com>:
>> CPU interface needs cs, wr setup, wr act and hold delay.
>> I added some members for them to common framework.
>
> Hi InKi Dae,
>
> The patch looks interesting. Could you help us understand more about
> it from a big picture perspective? ie: how is this "cpu interface"
> used? I think fb_var_screeninfo is intended to be a very generic data
> structure and since it is exposed to userspace we should be cautious
> about what we add to it. I didn't understand the purpose of exposing
> cs, wr setup, wr act and hold delay to userspace.

in case of lcd panel with cpu interface, it could get screen data
through arm core
or display controller supporting cpu interface mode.
display controller of s5pv210 chip can create cpu interface signal according to
cs, wr setup, wr act and hold time setting.
the reason I added cpu timing variables to fb_var_screeninfo is for using common
framework when setting them to the display controller as cpu timing info.
please, see [PATCH 2/3], s3c_fb_set_timing function part.

and cpu timing could be adjusted by user through fb_var_screeninfo,
for this, suitable checking should be considered at machine specific
fb_check_var func.
also you can see that through [PATCH 2/3], s3c_fb_check_var.

> Are the MIPI display
> parameters being specified from userspace? I also didn't understand
> the fb_cmdmode_to_var export. I looked through the other 2 patches
> (3/3 and 2/3) and didn't see it used so I might have missed something.

I just exported fb_cmdmode_to_var for future use. it doesn't use this func yet.
now, modedb.c and fb.h have no variables for cpu interface. perhaps, more codes
for cpu interface should be added to them.

> Also, I wanted to ask, since there are now multiple MIPI-DSI host
> controller drivers in fbdev (omap and also mobile-sh), is there any
> work that could be done to make these implementations share more code?

can MIPI-DSI host controller drivers you said use commonly?
I think these drivers are machine specific. so driver for MIPI-DSI
controller of S5PV210
should be implemented.

this patch code is MIPI Master driver and it can registered multiple
MIPI client driver
(mipi based lcd panel driver).
to use master driver, mipi client driver have to define some callbacks to struct
mipi_lcd_driver, and register them through s5p_dsim_register_lcd_driver func.
after this, client driver would be registered to master driver, and
client driver registered
would be probed when master driver was probed scaning client driver name.

please, see [PATCH 3/3], s5p_dsim_probe func part.

thank you for your interesting.

Best Regards,
InKi Dae.
