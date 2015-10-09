From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri, 09 Oct 2015 21:02:32 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20151009230232.6d21d9be@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Thierry,

On Mon, 21 Sep 2015 11:33:17 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
>=20
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

Anything preventing this series from being applied (AKA ping)?

>=20
> Best Regards,
>=20
> Boris
>=20
> Changes since v2:
> - rebased on top of 4.3-rc2
> - reintroduced pwm-regulator patches
>=20
> Changes since v1:
> - dropped applied patches
> - squashed Heiko's fixes into the rockchip driver changes
> - made a few cosmetic changes
> - added kerneldoc comments
> - added Heiko's patch to display more information in debugfs
> - dropped pwm-regulator patches (should be submitted separately)
>=20
> Boris Brezillon (11):
>   pwm: introduce default period and polarity concepts
>   pwm: define a new pwm_state struct
>   pwm: move the enabled/disabled info to pwm_state struct
>   backlight: pwm_bl: remove useless call to pwm_set_period
>   pwm: declare a default PWM state
>   pwm: add the PWM initial state retrieval infra
>   pwm: add the core infrastructure to allow atomic update
>   pwm: rockchip: add initial state retrieval
>   pwm: rockchip: add support for atomic update
>   regulator: pwm: implement ->enable(), ->disable() and ->is_enabled
>     methods
>   regulator: pwm: properly initialize the ->state field
>=20
> Heiko St=C3=BCbner (1):
>   pwm: add information about polarity, duty cycle and period to debugfs
>=20
>  drivers/leds/leds-pwm.c              |   2 +-
>  drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++++=
++----
>  drivers/pwm/pwm-pxa.c                |   2 +-
>  drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
>  drivers/pwm/pwm-sun4i.c              |   3 +-
>  drivers/regulator/pwm-regulator.c    |  65 ++++++++++++--
>  drivers/video/backlight/lm3630a_bl.c |   4 +-
>  drivers/video/backlight/pwm_bl.c     |  10 ++-
>  drivers/video/fbdev/ssd1307fb.c      |   2 +-
>  include/linux/pwm.h                  |  89 +++++++++++++++---
>  10 files changed, 392 insertions(+), 73 deletions(-)
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
