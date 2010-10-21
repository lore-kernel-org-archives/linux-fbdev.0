From: Grazvydas Ignotas <notasas@gmail.com>
Date: Thu, 21 Oct 2010 09:02:04 +0000
Subject: Re: [PATCH V3] OMAP: DSS2: don't power off a panel twice
Message-Id: <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
In-Reply-To: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: tomi.valkeinen@nokia.com
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org, bryan.wu@canonical.com, mathieu.poirier@canonical.com, linux-fbdev@vger.kernel.org

Tomi can you queue this? This has been tested by multiple people now,
also see here:
http://marc.info/?l=3Dlinux-omap&m=128759415821646&w=3D2

On Fri, Sep 3, 2010 at 6:03 AM, Stanley.Miao <stanley.miao@windriver.com> w=
rote:
> If we blank the panel by
> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
>
> Then, we reboot the sytem, the kernel will crash at
> drivers/video/omap2/dss/core.c:323
>
> This is because the panel is closed twice. Now check the state of a dssdev
> to forbid a panel is power on or power off twice.
>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
> =A0drivers/video/omap2/displays/panel-acx565akm.c =A0 =A0 | =A0 =A06 ++++=
++
> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0 =A06 ++=
++++
> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0 =A06 ++++++
> =A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =A0 =A06 ++++++
> =A0.../video/omap2/displays/panel-toppoly-tdo35s.c =A0 =A0| =A0 =A06 ++++=
++
> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 =A06 ++++=
++
> =A06 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/vid=
eo/omap2/displays/panel-acx565akm.c
> index 07fbb8a..e773106 100644
> --- a/drivers/video/omap2/displays/panel-acx565akm.c
> +++ b/drivers/video/omap2/displays/panel-acx565akm.c
> @@ -587,6 +587,9 @@ static int acx_panel_power_on(struct omap_dss_device =
*dssdev)
>
> =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
>
> =A0 =A0 =A0 =A0r =3D omapdss_sdi_display_enable(dssdev);
> @@ -644,6 +647,9 @@ static void acx_panel_power_off(struct omap_dss_devic=
e *dssdev)
>
> =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
>
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
>
> =A0 =A0 =A0 =A0if (!md->enabled) {
> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video=
/omap2/displays/panel-generic.c
> index 300eff5..395a68d 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -39,6 +39,9 @@ static int generic_panel_power_on(struct omap_dss_devic=
e *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -58,6 +61,9 @@ err0:
>
> =A0static void generic_panel_power_off(struct omap_dss_device *dssdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/dri=
vers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> index 1026746..0c6896c 100644
> --- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> @@ -43,6 +43,9 @@ static int sharp_lq_panel_power_on(struct omap_dss_devi=
ce *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -65,6 +68,9 @@ err0:
>
> =A0static void sharp_lq_panel_power_off(struct omap_dss_device *dssdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/dri=
vers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> index 7d9eb2b..9a138f6 100644
> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> @@ -135,6 +135,9 @@ static int sharp_ls_power_on(struct omap_dss_device *=
dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r =3D 0;
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -157,6 +160,9 @@ err0:
>
> =A0static void sharp_ls_power_off(struct omap_dss_device *dssdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/driver=
s/video/omap2/displays/panel-toppoly-tdo35s.c
> index e320e67..526e906 100644
> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> @@ -46,6 +46,9 @@ static int toppoly_tdo_panel_power_on(struct omap_dss_d=
evice *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -65,6 +68,9 @@ err0:
>
> =A0static void toppoly_tdo_panel_power_off(struct omap_dss_device *dssdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/driver=
s/video/omap2/displays/panel-tpo-td043mtea1.c
> index e866e76..dbe9d43 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -269,6 +269,9 @@ static int tpo_td043_power_on(struct omap_dss_device =
*dssdev)
> =A0 =A0 =A0 =A0int nreset_gpio =3D dssdev->reset_gpio;
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -308,6 +311,9 @@ static void tpo_td043_power_off(struct omap_dss_devic=
e *dssdev)
> =A0 =A0 =A0 =A0struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&ds=
sdev->dev);
> =A0 =A0 =A0 =A0int nreset_gpio =3D dssdev->reset_gpio;
>
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0tpo_td043_write(tpo_td043->spi, 3,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TPO_R03_VAL_STANDBY | TPO_=
R03_EN_PWM);
>
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
