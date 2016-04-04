From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 04 Apr 2016 15:22:54 +0000
Subject: Re: [PATCH v5 32/46] pwm: deprecate pwm_config(), pwm_enable() and pwm_disable()
Message-Id: <20160404152254.GB17856@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
 <20160331173858.GB39098@dtor-ws>
 <20160331205454.630734ab@bbrezillon>
In-Reply-To: <20160331205454.630734ab@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jon>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 08:54:54PM +0200, Boris Brezillon wrote:
> Hi Dmitry,
>=20
> On Thu, 31 Mar 2016 10:38:58 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>=20
> > Hi Boris,
> >=20
> > On Wed, Mar 30, 2016 at 10:03:55PM +0200, Boris Brezillon wrote:
> > > Prefix those function as deprecated to encourage all existing users to
> > > switch to pwm_apply_state().
> >=20
> > Why not keep at least some of them as wrappers where we do not need to
> > chnage several parameters at once? It is much easier to have a driver
> > do:
> >=20
> > 	error =3D pwm_enable(pwm);
> > 	if (error)
> > 		...
> >=20
> > rather than declaring the state variable, fectch it, adjust and then
> > apply.
>=20
> True. Actually deprecating the non-atomic API was not my primary goal.
> Thierry would you mind if we keep both APIs around?

I'm fine with keeping these around, though purely as shortcuts. If users
need to modify two parameters at once (e.g. duty cycle and enable) then
they should be converted to use the atomic API, otherwise there'd be
little point in introduce it.

Thierry

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXAobOAAoJEN0jrNd/PrOhbMEP/2DnMXfDO3dPUupPXHVnApG7
P03B4P1PaX5ZZlgEfqr3Wb4Z7gTVW2ZDjCJTN8iMV9ZKhMZr9w8iU2XXTDylE/2/
bmfVYYWOkGfU/pWfrAlxg/9IohVMK8K1XpGPOv9ODo0RZrlMcziUtx2X78IRJBym
+LhBMoWNXQuFCGScUdTBLqo4UMy4U7dEbMJdi8m3eAfn6Ox/u3W7LQDRYvkJhXmJ
LwzEkBhXEWEAaWUaebfAa6xEdWvcTH8PV5muwi7KZszCJqrNbPT3xc2nkOJJAG4E
xoEgOhMYaw6a1Cwt/hwjvzsXrMj7JMA2CLkZtkgv1ceLALG+O8Yo8+TiZI1Xu7yM
0yv+A9FqV8B/h+ou13DLoqk78559Dy7HhVegEn/C3Gu8QlGLX3Nuh+HfXfYqr+mE
Cj04NZz+PKWTZJO4ROGMAyue8HgNtTqwv6Emfd4+rN41YeVaB/ERIEXXU+QnhBZJ
lhoqi5hXa9Cm+/JNSJQiBDNt8GWoxy/CadmAT9wslfX0ZLWHWirKiebgc4zbFmI4
YVZgJRC4KLOITYfYwcaf7MtztW7MEGUqkoo2zVfwTcMzvDwIaGTc7rslB9irKKmi
5T8emrW3eAYOWamLKnv4jrMVr1Agrn1AxG496vqS0Mg9iXHi6syZzwe9MqHhshhv
UYUxq1mR6q8f+fGL7SFN
=twQ2
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
