From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 02 Jul 2015 07:55:20 +0000
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Message-Id: <20150702095520.3088852f@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3250976.mr9RMtjrdC@diego>
In-Reply-To: <3250976.mr9RMtjrdC@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 01 Jul 2015 23:57:57 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Boris,
>=20
> Am Mittwoch, 1. Juli 2015, 10:21:46 schrieb Boris Brezillon:
> > Hello Thierry,
> >=20
> > This series adds support for atomic PWM update, or ITO, the capability
> > to update all the parameters of a PWM device (enabled/disabled, period,
> > duty and polarity) in one go.
> >=20
> > This implementation is still experimental, and I may have missed some k=
ey
> > aspect, so any feedback are welcome.
> >=20
> > Also note that I haven't protected the state update with any locking.
> > That's because the existing config does not protect against concurrent
> > access to a requested PWM device (see the pwm_config implementation).
> > I guess the PWM framework assume the user will implement the proper loc=
king
> > scheme if it has to concurrently access the device.
> >=20
> > The 5 first patches prepare the addition of the pwm_state concept, which
> > will be used to allow atomic updates.
> > The following patches introduce the pwm_state struct, initial state
> > retrieval and atomic update concepts.
> >=20
> > Patches 12 and 13 are showing how one can implement the initial state
> > retrieval and atomic update features in a PWM driver (in this specific
> > case I implemented it in the rockchip driver).
> >=20
> > The last 2 patches are making use of those changes to improve the
> > pwm-regulator driver (initializing the regulator state based on the
> > initial PWM state).
>=20
> at first I got very strange readings (very wrong values and wrong polarit=
y),=20
> which resulted from the issues I pointed out in the replies to individual=
=20
> patches. After fixing these, the pwm read-back now returns exactly the ex=
pected=20
> values :-) .

Sorry about that, as I said I only compile tested the series :-/.
Anyway, thanks for providing fixes for these bugs, they'll be applied
in the next version.

>=20
> And with the original voltage table from the Chromeos-devicetrees, the pw=
m-
> regulator also returns the expected 1.2V that coreboot initially set.

Great! And thanks for testing the patches.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
