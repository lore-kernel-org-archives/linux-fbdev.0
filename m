From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 17 Aug 2015 07:18:27 +0000
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Message-Id: <20150817091827.70eae7eb@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150725083657.6111ff59@bbrezillon>
In-Reply-To: <20150725083657.6111ff59@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, 25 Jul 2015 08:36:57 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Thierry,
>=20
> Should I resend a new version rebased on Mark's pwm topic branch or
> would you like to review this one first ?

Ping.

>=20
> Best Regards,
>=20
> Boris
>=20
> On Mon, 20 Jul 2015 17:31:57 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>=20
> > Hello Thierry,
> >=20
> > This series adds support for atomic PWM update, or IOW, the capability
> > to update all the parameters of a PWM device (enabled/disabled, period,
> > duty and polarity) in one go.
> >=20
> > Best Regards,
> >=20
> > Boris
> >=20
> > Changes since v1:
> > - dropped applied patches
> > - squashed Heiko's fixes into the rockchip driver changes
> > - made a few cosmetic changes
> > - added kerneldoc comments
> > - added Heiko's patch to display more information in debugfs
> > - dropped pwm-regulator patches (should be submitted separately)
> >=20
> > Boris Brezillon (9):
> >   pwm: introduce default period and polarity concepts
> >   pwm: define a new pwm_state struct
> >   pwm: move the enabled/disabled info to pwm_state struct
> >   backlight: pwm_bl: remove useless call to pwm_set_period
> >   pwm: declare a default PWM state
> >   pwm: add the PWM initial state retrieval infra
> >   pwm: add the core infrastructure to allow atomic update
> >   pwm: rockchip: add initial state retrieval
> >   pwm: rockchip: add support for atomic update
> >=20
> > Heiko St=C3=BCbner (1):
> >   pwm: add information about polarity, duty cycle and period to debugfs
> >=20
> >  drivers/leds/leds-pwm.c              |   2 +-
> >  drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++=
++++----
> >  drivers/pwm/pwm-pxa.c                |   2 +-
> >  drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
> >  drivers/pwm/pwm-sun4i.c              |   3 +-
> >  drivers/regulator/pwm-regulator.c    |   2 +-
> >  drivers/video/backlight/lm3630a_bl.c |   4 +-
> >  drivers/video/backlight/pwm_bl.c     |  10 ++-
> >  drivers/video/fbdev/ssd1307fb.c      |   2 +-
> >  include/linux/pwm.h                  |  86 +++++++++++++++---
> >  10 files changed, 336 insertions(+), 63 deletions(-)
> >=20
>=20
>=20
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
