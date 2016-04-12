From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 11:22:46 +0000
Subject: Re: [PATCH v5 04/46] pwm: get rid of pwm->lock
Message-Id: <20160412112246.GJ18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QnBU6tTI9sljzm9u"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-5-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:27PM +0200, Boris Brezillon wrote:
> PWM devices are not protected against concurrent accesses. The lock in
> pwm_device might let PWM users think it is, but it's actually only
> protecting the enabled state.
>=20
> Removing this lock should be fine as long as all PWM users are aware that
> accesses to the PWM device have to be serialized, which seems to be the
> case for all of them except the sysfs interface.
> Patch the sysfs code by adding a lock to the pwm_export struct and making
> sure it's taken for all accesses to the exported PWM device.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 19 ++++--------------
>  drivers/pwm/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----=
------
>  include/linux/pwm.h |  2 --
>  3 files changed, 50 insertions(+), 28 deletions(-)

This is a little overzealous. Only accesses that can cause races need to
be protected by the lock. All of the *_show() callbacks don't modify the
PWM device in any way, so there is no need to protect them against
concurrent accesses.

I've dropped the changes when applying.

Thanks,
Thierry

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNqDAAoJEN0jrNd/PrOh/vAQAKV4cr0k4hIkuQzUAxTydr3e
J2KR01Td7f6t5RRgL036NiAdezmQjUHpjsWrvGzhoXGFG18xJcOvDaEqx4eBZVO8
AcvoTPJBPb7cK4iQzIBFj6f7pRuDLJiO3VvbGnt5KBX6gxb5L7Ob6uCh7KUqcPQY
TSVZEyvCz5IOrjY3+ae1z182RMPUpSgYhvoPOvCnnWf55L1uM5PYTDQfYK3mCVMq
XEsuynzPOdMmFSBwY2EDnfMH20rReqWpkJt8p2t1JRCQKEV4+APC56MSqALX70ru
WcjrwHGAfbB0D9vBDRyS6MKfQHKvSN8vr/tKLgyARHCGQaVIaWlSn0YIVrUBvu7e
w/wjJzgjUPHHJRid3V+8iSzJXnx7VFkmo6kEsIPx2bPPzehKD0IwvuBvWly6/SEn
NYzRO0ACcUC6BZTREIIEIDvIYNLoArvDM0KzraPdFOCaOGeJPUYA7QpzqZyViD/B
2fXH+Vd9N5Fu2b5ZrVEvqlT+hZ+LF7226wqTD/swx1uBqlyE813nuGiJ1GEydppL
Zwbr/YgOwd6sbUC2BLd6FXRkvvUnOuL924jivltGKF1zMZRcc0mNRLcqtmQH/DOM
Vo+LsKMjdOQ5xPEcthrnAIL09zThghXmNo0nefauiz8rKhsfzGOAK8bmcoNZ6M+Y
a5yLktJ92zpWwaSBfX5R
=ImQE
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
