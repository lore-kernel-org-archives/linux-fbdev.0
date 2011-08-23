From: Dave Airlie <airlied@gmail.com>
Date: Tue, 23 Aug 2011 09:10:00 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <CAPM=9tzF7C_gW44csqYwK+wdT9mwWBrA3O_9JQNfg=6aip4kag@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org>
In-Reply-To: <201108212242.12717.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Sun, Aug 21, 2011 at 9:42 PM, Ondrej Zary <linux@rainbow-software.org> w=
rote:
> Hello,
> this is an v2 attempt to resurrect an old (like 2.4.19) out-of-tree drive=
r for
> Intel740 graphics cards and modify it for recent kernels. The old driver =
is
> located at: http://sourceforge.net/projects/i740fbdev/files/
>
> It was easier to create a new driver based on skeletonfb, using most of t=
he
> low level HW code from the old driver. The DDC code is completely new.
>
> The driver was tested on two 8MB cards: ManLi and Diamond Stealth II G460
>
> The i740_calc_fifo() function formatting is nice but does not pass
> checkpatch. Making it checkpatch-compliant makes the code look ugly. How =
to
> make it both nice and compatible with Linux coding style?
> (the remaining // comments mark things that need attention - missing xpan
> and suspend/resume)
>
> Changes in v2:
> - fixed 15bpp (16bpp 555) mode
> - not working 1280x1024-32 is not a bug but card's feature, it's now hand=
led
> =A0correctly by the driver
> - 24bpp modes still don't work in fbtest but it looks like fbtest bug!
>
> Is there any better way to test fb drivers than fbtest?
>
> no signed-off-by yet
>
> --- linux-2.6.39-rc2-orig/drivers/video/Kconfig 2011-04-06 03:30:43.00000=
0000 +0200
> +++ linux-2.6.39-rc2/drivers/video/Kconfig =A0 =A0 =A02011-07-30 11:34:10=
.000000000 +0200
> @@ -1117,6 +1117,17 @@ config FB_RIVA_BACKLIGHT
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here if you want to control the backlight of you=
r display.
>
> +config FB_I740
> + =A0 =A0 =A0 tristate "Intel740 support (EXPERIMENTAL)"
> + =A0 =A0 =A0 depends on EXPERIMENTAL && FB && PCI && X86_32 && AGP_INTEL
> + =A0 =A0 =A0 select FB_MODE_HELPERS
> + =A0 =A0 =A0 select FB_CFB_FILLRECT
> + =A0 =A0 =A0 select FB_CFB_COPYAREA
> + =A0 =A0 =A0 select FB_CFB_IMAGEBLIT
> + =A0 =A0 =A0 select VGASTATE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This driver supports graphics cards based on Intel740 c=
hip.
> +

It shouldn't need AGP_INTEL, as its an AGP card not an integrated
chipset, it might need just AGP.

Dave.
