From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 13 Dec 2010 11:38:30 +0000
Subject: Re: [PATCH 5/9] Add i.MX5 framebuffer driver
Message-Id: <20101213113830.GE6017@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
	<AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
In-Reply-To: <AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Dec 12, 2010 at 02:13:40PM +0800, Liu Ying wrote:
> Hello, Sascha,
> 
> I have following comments to this patch:
> 1) Please modify the commit message, as IPUv3 is not embedded in i.MX50 SoC.

ok.

> 2) ADC is not supported yet in the framebuffer driver, so please
> modify this comment:
>    > + * Framebuffer Framebuffer Driver for SDC and ADC.

ok.

> 3) 'ipu_dp_set_window_pos()' is called only once in
> imx_ipu_fb_set_par_overlay(). So, the framebuffer driver doesn't
> support to change the overlay framebuffer position. Need a
> mechanism/interface for users to change the overlay framebuffer
> position.

Yes. The overlay support is currently only present in the driver because
I didn't want to break it in general. There is no generic overlay API in
the kernel and I didn't want to invent the n+1 API. Currently the
possible use cases of the overlay support are not clear to me. Number
one use case would probably be to display video output, but the
corresponding driver would be a v4l2 driver, so in this case we would
only need an in-kernel API.
Anyway, I have not the resources to implement complete overlay support.
So either we keep it like it is and it more has an example character
or we remove it completely from the driver for now.

> 4) Need to make sure the framebuffer on DP-FG is blanked before the
> framebuffer on DP-BG is blanked. Meanwhile, the framebuffer on DP-FG
> should be unblanked after the framebuffer on DP-BG is unblanked
> 5) Need to check the framebuffer on DP-FG doesn't run out of the range
> of the framebuffer on DP-BG.

I tend to remove the overlay support.

> 6) I prefer to find the video mode in modedb first, and if we cannot
> find the video mode in common video mode data base, we can find a
> video mode in custom video mode data base which is defined in platform
> data. In this way, we don't need to export common modefb.

I exported the modedb to be able to show the different modes under
/sys/class/graphics/fb0/modes and to set it with
/sys/class/graphics/fb0/mode. If you want this there is no way around
exporting it. The ioctl interface for mode setting is independent of the
specific modes anyway.

BTW please make comments specific to specific code inline.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
