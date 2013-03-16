From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Mar 2013 22:38:57 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <CAOMZO5AwD7Q3G+xp9DW0vioZnHZJX538nFeE9F-P+jbHMHPqoQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <1363471581-10132-1-git-send-email-marex@denx.de>
In-Reply-To: <1363471581-10132-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, Mar 16, 2013 at 7:06 PM, Marek Vasut <marex@denx.de> wrote:
> The issue fixed by this patch manifests only then using X11
> with mxsfb driver. The X11 will display either shifted image
> or otherwise distorted image on the LCD.
>
> The problem is that the X11 tries to reconfigure the framebuffer
> and along the way call fb_ops.fb_set_par() with it's configuration
> values. The field of particular interest is fb_info->var.sync which
> contains non-standard values if configured by kernel. These are
> FB_SYNC_DATA_ENABLE_HIGH_ACT and FB_SYNC_DOTCLK_FAILING_ACT defined
> in include/linux/mxsfb.h . The driver interprets those and configures
> the LCD controller accordingly. Yet X11 only has access to standard
> values for this field defined in include/uapi/linux/fb.h and thus
> omits these special values. This results in distorted image on the
> LCD.
>
> This patch moves these non-standard values into new field of the
> mxsfb_platform_data structure so the driver can in turn check this
> field instead of the video mode field for these specific portions.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estavem@freescale.com>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
> Cc: Lothar Wa=C3=9Fmann <LW@karo-electronics.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

This fixes the X11 offset issue on my mx28evk, thanks!

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
