From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2016 21:23:04 +0000
Subject: Re: [PATCH v5 28/46] regulator: pwm: swith to the atomic PWM API
Message-Id: <20160330212304.GW2350@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s3puAW9DMBtS2ARW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-29-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-29-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee


--s3puAW9DMBtS2ARW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 10:03:51PM +0200, Boris Brezillon wrote:
> pwm_config/enable/disable() have been deprecated in favor of
> pwm_apply_state().
> Replace all those calls with the equivalent pwm_get/apply_state().

Acked-by: Mark Brown <broonie@kernel.org>

--s3puAW9DMBtS2ARW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/EOzAAoJECTWi3JdVIfQ+k8H/0AJ6dz8O64HpBcKpVdlzTjm
XadmMu/4rogd7PPyfk9L6YU6L4pdMMxPaO/LURz/OTOb4L3uzeDXmidHCXV10oka
2lwnEmngQ5LZHQo/+jcNDdljpG1RYYT8RI7Zoy/tLx5wrtHIajyx7nui1snwgvYA
ggbi93H4s/KC+jTcG6b1RxxApC+Dv56xEyAlNVw1t+YIHuM4KGOA/aoLy3+60Hp/
d70O6IlMh53v4SvFMDjG4pCLKc5mA/dCninOcrqMbjA7NXcqnNgDJLnHuuJQNOLM
8MKUHRy64dGTGrE1T/Ybq0oE8RyntPT/ANNlV4Or6Lbv+cLWuT4GAErGrExQxFM=
=CoDU
-----END PGP SIGNATURE-----

--s3puAW9DMBtS2ARW--
