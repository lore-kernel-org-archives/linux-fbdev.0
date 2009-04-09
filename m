From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: It has added ARGB1888 and ARGB4888 features to Samsung SoC 
	Framebuffer driver.
Date: Thu, 9 Apr 2009 09:59:24 -0700
Message-ID: <9c9fda240904090959w6b72d08fm9347fd8b0a30eafc@mail.gmail.com>
References: <90b950fc0904090059l39229aa9hd3399782a15e1bf9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936086AbZDIQ7v@vger.kernel.org>
In-Reply-To: <90b950fc0904090059l39229aa9hd3399782a15e1bf9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: InKi Dae <daeinki@gmail.com>
Cc: ben-linux@fluff.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com

Hi,

On Thu, Apr 9, 2009 at 12:59 AM, InKi Dae <daeinki@gmail.com> wrote:
> This patch supports ARGB1888 and ARGB4888 for Samsung SoC Framebuffer
> driver. (s3c-fb.c)
> I tested and is working fine.
>
> If this patch has any problem, please let me know.
> I'll look forward to applying to mainline.
>
> Thank you,
> InKi Dae.

Please give you signed-off-by here and more descriptions

>
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
----------------------------------------------------------------------
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index e0e7899..55d2298 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -358,9 +358,16 @@ static int s3c_fb_set_par(struct fb_info *info)
> =A0writel(data, regs + VIDOSD_B(win_no));
>
> =A0data =3D var->xres * var->yres;
> +
> + u32 osdc_data =3D 0;
> +
> + osdc_data =3D VIDISD14C_ALPHA1_R(0xf) |
> + =A0VIDISD14C_ALPHA1_G(0xf) |
> + =A0VIDISD14C_ALPHA1_B(0xf);
> +
> =A0if (s3c_fb_has_osd_d(win_no)) {
> =A0 writel(data, regs + VIDOSD_D(win_no));
> - =A0writel(0, regs + VIDOSD_C(win_no));
> + =A0writel(osdc_data, regs + VIDOSD_C(win_no));
> =A0} else
> =A0 writel(data, regs + VIDOSD_C(win_no));
>
> @@ -409,8 +416,12 @@ static int s3c_fb_set_par(struct fb_info *info)
> =A0 =A0 data |=3D WINCON1_BPPMODE_19BPP_A1666;
> =A0 =A0else
> =A0 =A0 data |=3D WINCON1_BPPMODE_18BPP_666;
> - =A0} else if (var->transp.length !=3D 0)
> - =A0 data |=3D WINCON1_BPPMODE_25BPP_A1888;
> + =A0} else if (var->transp.length =3D=3D 1)
> + =A0 data |=3D WINCON1_BPPMODE_25BPP_A1888
> + =A0 =A0| WINCON1_BLD_PIX;
> + =A0else if (var->transp.length =3D=3D 4)
> + =A0 data |=3D WINCON1_BPPMODE_28BPP_A4888
> + =A0 =A0| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
> =A0 else
> =A0 =A0data |=3D WINCON0_BPPMODE_24BPP_888;
>
> @@ -418,6 +429,20 @@ static int s3c_fb_set_par(struct fb_info *info)
> =A0 break;
> =A0}
>
> + /* It has no color key control register for window0 */
> + if (win_no > 0) {
> + =A0u32 keycon0_data =3D 0, keycon1_data =3D 0;
> +
> + =A0keycon0_data =3D ~(WxKEYCON0_KEYBL_EN |
> + =A0 =A0WxKEYCON0_KEYEN_F |
> + =A0 =A0WxKEYCON0_DIRCON) | WxKEYCON0_COMPKEY(0);
> +
> + =A0keycon1_data =3D WxKEYCON1_COLVAL(0xffffff);
> +
> + =A0writel(keycon0_data, regs + WxKEYCONy(win_no-1, 0));
> + =A0writel(keycon1_data, regs + WxKEYCONy(win_no-1, 1));
> + }
> +
> =A0writel(data, regs + WINCON(win_no));
> =A0writel(0x0, regs + WINxMAP(win_no));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
