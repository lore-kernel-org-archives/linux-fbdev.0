From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 21 Dec 2011 11:11:57 +0000
Subject: RE: [PATCH] video: da8xx-fb: reset LCDC only if functional clock
Message-Id: <A73F36158E33644199EB82C5EC81C7BC0263DE@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324452460-10646-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1324452460-10646-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Sriram,

On Wed, Dec 21, 2011 at 16:17:01, Madhvapathi Sriram wrote:
> Prakash,
>=20
> On Wed, Dec 21, 2011 at 12:57 PM, Manjunathappa, Prakash
> <prakash.pm@ti.com> wrote:
> >
> > LCDC functional clock may or may not be derived from CPU/MPU DPLL,
> > For example,
> > AM335x =3D> Separate independent DPLL for LCDC
> > Davinci =3D> Same DPLL as MPU
> >
> > So, on platforms where LCDC functional clock is not derived from CPU/MPU
> > PLL it is not required to reset LCDC module, if CPU frequency does not
> > change with DVFS.
> Is it not the case that the CPU frequency always changes during DVFS?
> This sentence does not strike me straight.
> Did you mean that if the frequency of the PLL (from which LCDC
> derives) does not change with DVFS, then LCDC module is not required
> to be reset?

Ok I will re-phrase it as below:
So, on platforms where LCDC functional clock is not derived from CPU/MPU
PLL it is not required to reset LCDC module as its functional clock does no=
t change with DVFS.
=20
> >
> > This patch adds check to do reset only if functional clock changes
> > between pre and post notifier callbacks with DVFS.
> >
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > ---
> > =A0drivers/video/da8xx-fb.c | =A0 13 ++++++++-----
> > =A01 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > index 29577bf..1334a68 100644
> > --- a/drivers/video/da8xx-fb.c
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -161,6 +161,7 @@ struct da8xx_fb_par {
> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vsync_timeou=
t;
> > =A0#ifdef CONFIG_CPU_FREQ
> > =A0 =A0 =A0 =A0struct notifier_block =A0 freq_transition;
> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0lcd_fck_rate;
> > =A0#endif
> > =A0 =A0 =A0 =A0void (*panel_power_ctrl)(int);
> > =A0};
> > @@ -840,11 +841,12 @@ static int lcd_da8xx_cpufreq_transition(struct no=
tifier_block *nb,
> > =A0 =A0 =A0 =A0struct da8xx_fb_par *par;
> >
> > =A0 =A0 =A0 =A0par =3D container_of(nb, struct da8xx_fb_par, freq_trans=
ition);
> > - =A0 =A0 =A0 if (val =3D CPUFREQ_PRECHANGE) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_disable_raster();
> > - =A0 =A0 =A0 } else if (val =3D CPUFREQ_POSTCHANGE) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_calc_clk_divider(par);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_enable_raster();
> > + =A0 =A0 =A0 if (val =3D CPUFREQ_POSTCHANGE) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (par->lcd_fck_rate !=3D clk_get_rate(p=
ar->lcdc_clk)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_disable_raster();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_calc_clk_divider(par);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_enable_raster();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0return 0;
> > @@ -1137,6 +1139,7 @@ static int __devinit fb_probe(struct platform_dev=
ice *device)
> >
> > =A0 =A0 =A0 =A0par =3D da8xx_fb_info->par;
> > =A0 =A0 =A0 =A0par->lcdc_clk =3D fb_clk;
> > + =A0 =A0 =A0 par->lcd_fck_rate =3D clk_get_rate(fb_clk);
> > =A0 =A0 =A0 =A0par->pxl_clk =3D lcdc_info->pxl_clk;
> > =A0 =A0 =A0 =A0if (fb_pdata->panel_power_ctrl) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->panel_power_ctrl =3D fb_pdata->pane=
l_power_ctrl;
> > --
> > 1.7.1
> >
> > _______________________________________________
> > Davinci-linux-open-source mailing list
> > Davinci-linux-open-source@linux.davincidsp.com
> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>=20

