From: Jason Chen <weitway@gmail.com>
Date: Sat, 19 Feb 2011 02:22:08 +0000
Subject: Re: [PATCH 3/7] Add i.MX5 framebuffer driver
Message-Id: <AANLkTi=hm41HUtwXJSdfGtjj2pRo1xAv1AmZ5zaTp5Sj@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTina46_CMvB_9cqc4=PvcPxaV_BQ_H_ghJZFFxg8@mail.gmail.com>
	<20110218095221.GK24426@pengutronix.de>
In-Reply-To: <20110218095221.GK24426@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

hi, Sascha,

2011/2/18 Sascha Hauer <s.hauer@pengutronix.de>:
> Hi Jason,
>
> On Fri, Feb 18, 2011 at 05:22:09PM +0800, Jason Chen wrote:
>> hi, Sasha,
>>
>> > + =A0 =A0 =A0 if (var->vmode & FB_VMODE_ODD_FLD_FIRST) /* PAL */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.odd_field_first =3D 1;
>> > + =A0 =A0 =A0 if (var->sync & FB_SYNC_EXT)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.ext_clk =3D 1;
>> > + =A0 =A0 =A0 if (var->sync & FB_SYNC_HOR_HIGH_ACT)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_cfg.Hsync_pol =3D 1;
>> Please remove FB_SYNC_EXT support.
>
> No problem, can do. But why? Is it nonfunctional in the hardware
> or is it that the current code just misses more pieces to support
> this?
>
This flag represents external sync, some application will not check
this flag when they reset fb var, for example, X server fb driver will
ignore it, if so, the ipu external clock can not be set correctly.
I think ipu should decide external clock usage by other method. The
latest method in freesacle mainline is decide it automatically -- if
internal clock can not fit target clock rate well, switch it to
external.
>>
>> +static void imx_ipu_fb_disable_overlay(struct fb_info *ovl)
>> +{
>> + =A0 =A0 =A0 struct imx_ipu_fb_info *mxc_ovl =3D ovl->par;
>> +
>> + =A0 =A0 =A0 if (!mxc_ovl->enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 ipu_dp_disable_fg(mxc_ovl->dp);
>> + =A0 =A0 =A0 ipu_wait_for_interrupt(451, 100);
>> + =A0 =A0 =A0 ipu_idmac_disable_channel(mxc_ovl->ipu_ch);
>> + =A0 =A0 =A0 ipu_dmfc_disable_channel(mxc_ovl->dmfc);
>> + =A0 =A0 =A0 mxc_ovl->enabled =3D 0;
>> +}
>> Had better has a definition of ipu irq 451.
>
> Ok.
>
> Sascha
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
