From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 27 Feb 2014 20:49:34 +0000
Subject: Re: [PATCH 3/3] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <20140227204934.GM6865@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393328624-28013-5-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1393328624-28013-5-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Feb 27, 2014 at 12:41:36PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Feb 25, 2014 at 01:09:57PM +0100, Philipp Zabel wrote:
> > Am Dienstag, den 25.02.2014, 12:43 +0100 schrieb Philipp Zabel:
> > > The i.MX Image Processing Unit (IPU) contains a number of image proce=
ssing
> > > blocks that sit right in the middle between DRM and V4L2. Some of the=
 modules,
> > > such as Display Controller, Processor, and Interface (DC, DP, DI) or =
CMOS
> > > Sensor Interface (CSI) and their FIFOs could be assigned to either fr=
amework,
> > > but others, such as the dma controller (IDMAC) and image converter (I=
C) can
> > > be used by both.
> > > The IPUv3 core driver provides an internal API to access the modules,=
 to be
> > > used by both DRM and V4L2 IPUv3 drivers.
> > [...]
> >=20
> > This one is missing:
> >=20
> > diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-d=
rm/imx-hdmi.c
> > index cb4eb76..9aeb863 100644
> > --- a/drivers/staging/imx-drm/imx-hdmi.c
> > +++ b/drivers/staging/imx-drm/imx-hdmi.c
> > @@ -28,7 +28,8 @@
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_encoder_slave.h>
> > =20
> > -#include "ipu-v3/imx-ipu-v3.h"
> > +#include <video/imx-ipu-v3.h>
> > +
>=20
> What do you mean?  I can't apply this patch?
I understand it as: Please squash this hunk changing the #include into
patch 3. But note that I don't know anything about the stuff Philipp is
working on.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
