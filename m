From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2016 21:22:24 +0000
Subject: Re: [PATCH v5 27/46] regulator: pwm: adjust PWM config at probe time
Message-Id: <20160330212224.GV2350@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+FNB8hLr74QeaOK6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-28-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-28-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee


--+FNB8hLr74QeaOK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 10:03:50PM +0200, Boris Brezillon wrote:
> The PWM attached to a PWM regulator device might have been previously
> configured by the bootloader.
> Make sure the bootloader and linux config are in sync, and adjust the PWM
> config if that's not the case.

Acked-by: Mark Brown <broonie@kernel.org>

--+FNB8hLr74QeaOK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/EOPAAoJECTWi3JdVIfQWWoH/2Twb+EMdVjxYbvoP9B+iqS8
GgeyI/BocMSlpDdLD5gxifkN8lrti5/ZXCVSiNqF/8Ji3W5L9hpDqYyyUCpaaxrj
VK+/waBde1BwNWf2NX4cKjG7JeMGz5I2NoQWye9xEueYXsYtwGQMOVJ9VPvyiJjH
xZcl00q0HkS2taXHetbfRmKuXFBK+/qS5oMU5L0BLeHYksH3dRhN2ffRdcqYBVpW
NYq42vcR0lNOeQxZYZVuljMgqOtXFEjyCj3cNvFngURtqPNH5P7xNdLvjdjFuF/T
dFcDhLQtTtG09EEbGHfrJxzqYZILnSRXA7fxPEm0bIMvg7R0azC3nUfrQXZdUZI=
=TtR5
-----END PGP SIGNATURE-----

--+FNB8hLr74QeaOK6--
