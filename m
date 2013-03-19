From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 19 Mar 2013 05:51:19 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <20130319055118.GJ12462@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363631042-5321-1-git-send-email-marex@denx.de>
In-Reply-To: <1363631042-5321-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 18, 2013 at 07:24:02PM +0100, Marek Vasut wrote:
> The issue fixed by this patch manifests only then using X11
> with mxsfb driver. The X11 will display either shifted image
> or otherwise distorted image on the LCD.
>=20
> The problem is that the X11 tries to reconfigure the framebuffer
> and along the way calls fb_ops.fb_set_par() with X11's desired
> configuration values. The field of particular interest is
> fb_info->var.sync which contains non-standard values if
> configured by kernel. These are either FB_SYNC_DATA_ENABLE_HIGH_ACT,
> FB_SYNC_DOTCLK_FAILING_ACT or both, depending on the platform
> configuration. Both of these values are defined in the
> include/linux/mxsfb.h file.
>=20
> The driver interprets these values and configures the LCD controller
> accordingly. Yet X11 only has access to the standard values for this
> field defined in include/uapi/linux/fb.h and thus, unlike kernel,
> omits these special values. This results in distorted image on the
> LCD.
>=20
> This patch moves these non-standard values into new field of the
> mxsfb_platform_data structure so the driver can in turn check this
> field instead of the video mode field for these specific portions.
>=20
> Moreover, this patch prefixes these values with MXSFB_SYNC_ prefix
> instead of FB_SYNC_ prefix to prevent confusion of subsequent users.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
> Cc: Lothar Wa=DFmann <LW@karo-electronics.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with one trivial change below.

...

> @@ -407,6 +404,8 @@ static void __init cfa10049_init(void)
>  	mxsfb_pdata.mode_count =3D ARRAY_SIZE(cfa10049_video_modes);
>  	mxsfb_pdata.default_bpp =3D 32;
>  	mxsfb_pdata.ld_intf_width =3D STMLCDIF_18BIT;
> +	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
> +

I removed this unnecessary new line.

Shawn

>  }

