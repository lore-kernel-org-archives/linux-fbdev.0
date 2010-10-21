From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Thu, 21 Oct 2010 09:20:10 +0000
Subject: RE: [PATCH V3] OMAP: DSS2: don't power off a panel twice
Message-Id: <FCCFB4CDC6E5564B9182F639FC356087034BBEC088@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
 <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
In-Reply-To: <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grazvydas Ignotas <notasas@gmail.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "mathieu.poirier@canonical.com" <mathieu.poirier@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Grazvydas Ignotas
> Sent: Thursday, October 21, 2010 2:32 PM
> To: tomi.valkeinen@nokia.com
> Cc: Stanley.Miao; linux-omap@vger.kernel.org; bryan.wu@canonical.com;
> mathieu.poirier@canonical.com; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH V3] OMAP: DSS2: don't power off a panel twice
>=20
> Tomi can you queue this? This has been tested by multiple people now,
> also see here:
> http://marc.info/?l=3Dlinux-omap&m=128759415821646&w=3D2
>=20
> On Fri, Sep 3, 2010 at 6:03 AM, Stanley.Miao <stanley.miao@windriver.com>
> wrote:
> > If we blank the panel by
> > echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> >
> > Then, we reboot the sytem, the kernel will crash at
> > drivers/video/omap2/dss/core.c:323
> >
> > This is because the panel is closed twice. Now check the state of a
> dssdev
> > to forbid a panel is power on or power off twice.
> >
> > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > ---
> > =A0drivers/video/omap2/displays/panel-acx565akm.c =A0 =A0 | =A0 =A06 ++=
++++
> > =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0 =A06 =
++++++
> > =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0 =A06 ++++++
> > =A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =A0 =A06 ++++++
> > =A0.../video/omap2/displays/panel-toppoly-tdo35s.c =A0 =A0| =A0 =A06 ++=
++++
> > =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 =A06 ++=
++++
> >=20
[Senthil]  Why is this change not applicable for panel-taal.c ?
> >
> > diff --git a/drivers/video/omap2/displays/panel-acx565akm.c
> b/drivers/video/omap2/displays/panel-acx565akm.c
> > index 07fbb8a..e773106 100644
> > --- a/drivers/video/omap2/displays/panel-acx565akm.c
> > +++ b/drivers/video/omap2/displays/panel-acx565akm.c
> > @@ -587,6 +587,9 @@ static int acx_panel_power_on(struct omap_dss_device
> *dssdev)
> >
> > =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
> >
> > + =A0 =A0 =A0 if (dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
> >
> > =A0 =A0 =A0 =A0r =3D omapdss_sdi_display_enable(dssdev);
> > @@ -644,6 +647,9 @@ static void acx_panel_power_off(struct
> omap_dss_device *dssdev)
> >
> > =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
> >
> > + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
> >
> > =A0 =A0 =A0 =A0if (!md->enabled) {
<Snip>
