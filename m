From: Chen Jie-B02280 <B02280@freescale.com>
Date: Thu, 16 Dec 2010 02:07:03 +0000
Subject: RE: [PATCH 5/9] Add i.MX5 framebuffer driver
Message-Id: <33F32152BE7EC740BC2C838D2836AC8704B2F3@039-SN1MPN1-002.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <33F32152BE7EC740BC2C838D2836AC8704A957@039-SN1MPN1-002.039d.mgd.msft.net>
	<33F32152BE7EC740BC2C838D2836AC8704A9F5@039-SN1MPN1-002.039d.mgd.msft.net>
	<20101215143844.GE6017@pengutronix.de>
In-Reply-To: <20101215143844.GE6017@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi, Sascha,



Jason Chen / Chen Jie
NMG / MAD
Freescale Semiconductor (China) Ltd.
2F, Building B, 177#, Bi Bo Rd
Pu Dong New District Shanghai=A0201203
Tel:=A0=A0=A0=A0 021-28937178=A0
Fax:=A0=A0=A0=A0 021-28937444
E-mail:=A0=A0Jason.Chen@freescale.com


-----Original Message-----
From: saschahauer@web.de [mailto:saschahauer@web.de] On Behalf Of s.hauer@p=
engutronix.de
Sent: Wednesday, December 15, 2010 10:39 PM
To: Chen Jie-B02280
Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; lin=
ux-fbdev@vger.kernel.org; Zhang Lily-R58066; arnaud.patard@rtp-net.org
Subject: Re: [PATCH 5/9] Add i.MX5 framebuffer driver

On Tue, Dec 14, 2010 at 12:38:08PM +0000, Chen Jie-B02280 wrote:
> Hi, Sascha,
>=20
> Few comments inline with [Jason]

Please consider switching to a sane mailer which is able to quote correctly.

>=20
> I have following comments to this patch:
> 1) Please modify the commit message, as IPUv3 is not embedded in i.MX50 S=
oC.
> 2) ADC is not supported yet in the framebuffer driver, so please=20
> modify this comment:
>   > + * Framebuffer Framebuffer Driver for SDC and ADC.
> 3) 'ipu_dp_set_window_pos()' is called only once in=20
> imx_ipu_fb_set_par_overlay(). So, the framebuffer driver doesn't=20
> support to change the overlay framebuffer position. Need a=20
> mechanism/interface for users to change the overlay framebuffer=20
> position.
> [Jason] DP-FG should be one fb device, sequence ioctl should be added=20
> after it, like global alpha , color key etc.

As said before, I have no interest in making the overlay fully functional a=
tm. So either we'll leave it here for reference if someone ever tries to im=
plement it properly or I'll remove it completely.
[Jason] Ok, then pls keep it as reference.

> > +static int imx_ipu_fb_set_par(struct fb_info *fbi) {
> > +       int ret;
> > +       struct ipu_di_signal_cfg sig_cfg;
> > +       struct imx_ipu_fb_info *mxc_fbi =3D fbi->par;
> > +       u32 out_pixel_fmt;
> > +       int interlaced =3D 0;
> > +       struct fb_var_screeninfo *var =3D &fbi->var;
> > +       int enabled =3D mxc_fbi->enabled;
> > +
> > +       dev_dbg(fbi->device, "Reconfiguring framebuffer %dx%d-%d\n",
> > +               fbi->var.xres, fbi->var.yres,=20
> > + fbi->var.bits_per_pixel);
> > +
> > +       if (enabled)
> > +               imx_ipu_fb_disable(fbi);
> > +
> > +       fbi->fix.line_length =3D var->xres_virtual *=20
> > + var->bits_per_pixel / 8;
> > +
> > +       var->yres_virtual =3D var->yres;
> > +
> > +       ret =3D imx_ipu_fb_map_video_memory(fbi);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (var->vmode & FB_VMODE_INTERLACED)
> > +               interlaced =3D 1;
> > +
> > +       memset(&sig_cfg, 0, sizeof(sig_cfg));
> > +       out_pixel_fmt =3D mxc_fbi->ipu_di_pix_fmt;
> > +
> > +       if (var->vmode & FB_VMODE_INTERLACED)
> > +               sig_cfg.interlaced =3D 1;
> > +       if (var->vmode & FB_VMODE_ODD_FLD_FIRST) /* PAL */
> > +               sig_cfg.odd_field_first =3D 1;
> > +       if (var->sync & FB_SYNC_EXT)
> > +               sig_cfg.ext_clk =3D 1;
> [Jason] FB_SYNC_EXT has not be used in FSL kernel mainline, it=20
> represent SYNC ext, should not be flag of ext clk. Some application=20
> for example X-server could not recognize it.

Ok, I'll remove it.


> > +static int imx_ipu_fb_pan_display(struct fb_var_screeninfo *var,
> > +               struct fb_info *info) {
> > +       struct imx_ipu_fb_info *mxc_fbi =3D info->par;
> > +       unsigned long base;
> > +       int ret;
> > +
> > +       if (info->var.yoffset =3D var->yoffset)
> > +               return 0;       /* No change, do nothing */
> > +
> > +       base =3D var->yoffset * var->xres_virtual * var->bits_per_pixel=
 / 8;
> > +       base +=3D info->fix.smem_start;
> > +
> > +       ret =3D ipu_wait_for_interrupt(IPU_IRQ_EOF(mxc_fbi->ipu_channel=
_num), 100);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (ipu_idmac_update_channel_buffer(mxc_fbi->ipu_ch, 0, base)) {
> > +               dev_err(info->device,
> > +                       "Error updating SDC buf to address=3D0x%08lX\n"=
, base);
> > +       }
> [Jason] It's better to enable double -buffer for fb which could avoid tea=
ring issue.

There is no tearing as the switching is done during vsync.
[Jason] Yes, you are right.


--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


