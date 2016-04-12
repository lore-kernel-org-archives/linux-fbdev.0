From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Apr 2016 10:09:38 +0000
Subject: Re: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
Message-Id: <20160412100938.GA14664@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
 <20160330212410.GX2350@sirena.org.uk>
 <20160407235431.788dc24a@bbrezillon>
 <20160412044203.GW3351@sirena.org.uk>
 <20160412103722.0bfe1d4d@bbrezillon>
In-Reply-To: <20160412103722.0bfe1d4d@bbrezillon>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 10:37:22AM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 07, 2016 at 11:54:31PM +0200, Boris Brezillon wrote:

> > I'm not sure there's a strong one, we don't really use the class device
> > for anything, but without doing a full audit I couldn't guarantee that.

> At first glance I don't see any problem (even the rdev_err/info/...()
> functions do not use dev_err/info/...()). The patch will be part of v6
> (unless you want me to send it independently).

I'd rather it didn't get sucked into this series since it seems that
it's getting delayed indefinitely - I can apply it to the regulator tree
and create a tag that can be pulled into other trees as needed if things
do get applied.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDMlfAAoJECTWi3JdVIfQvMUH/3Z6WfaLEZ3dG7gtf2OoWH3O
xW/vVHZ2g9eI2UE5Opj4slfZIX/5iDJ+B8m86i44rKq9usgjvVtSnXsEJDF3zeDY
FyDZ2SKAdvHKYA509OUo8ry+OjL17KimcaElkshpHfSBzkfVso6O5NtJjXwQtdOI
7cuvL7yPpnoYRGWBCS+1k/z5vBP6CpwbFVndAlUmlayFx/MXfBSQ5WEXwqSR1OtC
E1byy1Q6WNEB/S49T8xyo9UyJpkPUUVs92ViI1Bo4IakEfKGFAsch9fLI7mFKwQ4
MJE1eS3cKMmeKzxXybjVbq9O3lopdMP2mSFIE58kCkU3zBfZ2XXoOHZpLvUHLoM=
=vn5g
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
