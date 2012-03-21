From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Mar 2012 01:10:20 +0000
Subject: Re: [PATCH v3] fbdev: remove dependency of FB_SH_MOBILE_MERAM from FB_SH_MOBILE_LCDC
Message-Id: <87pqc6wyh3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87d38qwmi9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d38qwmi9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Florian

> > MERAM can be used for other IP blocks as well in the future.
> > It doesn't necessarily mean that the MERAM driver depends on the LCDC.
> > This patch corrects dependency.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v2 -> v3
> > 
> > - move config FB_SH_MOBILE_MERAM out of "choice"
> 
> I am afraid but this is still not correct. The problem is that after
> your patch this config option has no longer any dependency on the
> framebuffer subsystem. As "FB" is a menuconfig option I guess the first
> config option without any direct or indirect dependency on FB terminates
> the menu. As I don't understand how this driver is used I don't know how
> I should resolve this: either leave it where it is and just add an
> dependency on "FB" or move it even further down, probably just before
> endmenu (AFAIK the first thing that breaks it is OMAP2).

Thank you for checking my patch.
And sorry for breaking menuconfig

As Laurent/Hayama-san said that the MERAM will be used
from VIDEO_SH_MOBILE_CEU (${LINUX}/drivers/media/video/Kconfig)
in the future.

I move it to before endmenu (without "FB" dependency)

Best regards
---
Kuninori Morimoto
