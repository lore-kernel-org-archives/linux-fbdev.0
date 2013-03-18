From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 18 Mar 2013 12:44:24 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <20130318122650.GD12462@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <1363471581-10132-1-git-send-email-marex@denx.de>
In-Reply-To: <1363471581-10132-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, Mar 16, 2013 at 11:06:21PM +0100, Marek Vasut wrote:
> The issue fixed by this patch manifests only then using X11
> with mxsfb driver. The X11 will display either shifted image
> or otherwise distorted image on the LCD.
>=20
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
>=20
> This patch moves these non-standard values into new field of the
> mxsfb_platform_data structure so the driver can in turn check this
> field instead of the video mode field for these specific portions.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estavem@freescale.com>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
> Cc: Lothar Wa=DFmann <LW@karo-electronics.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |   22 +++++++++++-----------
>  drivers/video/mxsfb.c        |    7 +++++--
>  include/linux/mxsfb.h        |    7 +++++--
>  3 files changed, 21 insertions(+), 15 deletions(-)

Since it touches mach-mxs as well, let me send it through arm-soc tree
as fix for 3.9.

Shawn

