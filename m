From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 11:46:00 +0000
Subject: Re: [PATCH v5 04/46] pwm: get rid of pwm->lock
Message-Id: <20160412114600.GL18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Mit9XoPEfICDqq/V"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160412112246.GJ18882@ulmo.ba.sec>
 <20160412133255.73cea027@bbrezillon>
In-Reply-To: <20160412133255.73cea027@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 01:32:55PM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Tue, 12 Apr 2016 13:22:46 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Mar 30, 2016 at 10:03:27PM +0200, Boris Brezillon wrote:
> > > PWM devices are not protected against concurrent accesses. The lock in
> > > pwm_device might let PWM users think it is, but it's actually only
> > > protecting the enabled state.
> > >=20
> > > Removing this lock should be fine as long as all PWM users are aware =
that
> > > accesses to the PWM device have to be serialized, which seems to be t=
he
> > > case for all of them except the sysfs interface.
> > > Patch the sysfs code by adding a lock to the pwm_export struct and ma=
king
> > > sure it's taken for all accesses to the exported PWM device.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/pwm/core.c  | 19 ++++--------------
> > >  drivers/pwm/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++-=
----------
> > >  include/linux/pwm.h |  2 --
> > >  3 files changed, 50 insertions(+), 28 deletions(-)
> >=20
> > This is a little overzealous. Only accesses that can cause races need to
> > be protected by the lock. All of the *_show() callbacks don't modify the
> > PWM device in any way, so there is no need to protect them against
> > concurrent accesses.
>=20
> This is probably true for this set of changes, but what will happen
> when we'll switch to the atomic API? There's no guarantee that
> pwm->state =3D *newstate is done atomically, and you may see a partially
> updated state when calling pwm_get_state() while another thread is
> calling pwm_apply_state().

I'd argue that for sysfs it doesn't matter since the userspace API is
non-atomic anyway. As such it doesn't really matter which part of the
state you're getting because only one field from the query is exposed
to userspace, hence the coherence of the state is irrelevant.

All other users should be taking care of the serialization themselves
already.

Thierry

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDN/4AAoJEN0jrNd/PrOhunwP/1m1tbxsX8QvdaPGs9FFgrBU
TdLMaN8vCxiwS7p8SwNXiJI3lRvxah2MiLtbfXiwWGRh7sKQvAnG1t3suo6VWw9u
OKn8wWPkJ1a4n5OFOofQOTMz6nNqunopEtIJya/qpTAuqY+qUtsBs8IGmdq22AzG
tLUd9WpzSms+wpskXJPJ+Ya6XiMHYwFSwugLof3n0I0HiqHC7VN7C6atzCcjenSm
CVkOYyTuJ0YPbBNTqdxU0aMrJNVAISVnf6DxvlqDV9pbXMrKhdHB9paKNZ9lPjUV
9qEQWeGumQRS60CUiFUo+QLuNbE08AuindvGwzYWAmNIn6X+gPs19dTvLeynfSR9
kWnUsgVmKrxofZLQOs6zLKnLRTywRCl6pUFdDtdlrBeqfIyDddv+yG8o7za3f/Ey
62A0yw/BT4ZsaDxoRGiqbstKXBU8cc/6oc+NMfhsGMNyuh1N75XTb0XFmCXD/wh2
E+PUcKFRNzyRoXWpL20cRgA1AdwC347g2H9jWXZwXsy89Ut65JSi06FHmur87ABk
h0lVt7zcfV8D4QMYy4YeOWyIoQOER81gRpUVeGCffnjUk71mTy4391vm/0EoQc/b
+19CpkYcbpZXCra4V6rjeHhrAt97VA1W4kX5ImgqS8hVd6qufxvQLHUWPdP4uBbP
a4PzXe+SvvKZxBEi1NEw
=o8Op
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--
