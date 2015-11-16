From: Mark Brown <broonie@kernel.org>
Date: Mon, 16 Nov 2015 18:42:38 +0000
Subject: Re: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <20151116184238.GJ31303@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVh9lyqKgK19OcEf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
 <20151116105558.GB31303@sirena.org.uk>
 <20151116132359.39d84279@bbrezillon>
In-Reply-To: <20151116132359.39d84279@bbrezillon>
To: linux-arm-kernel@lists.infradead.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 01:23:59PM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:

> > > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);

> > It's not clear to me that we're not looking for the current period here
> > or in the other use.  Won't configuring based on a period other than the
> > one that has been set give the wrong answer?

> Hm, maybe that's naming problem. What I call the 'default' period here
> is actually the period configured in your board file (using a PWM lookup
> table) or your DT. This value represent the period requested by the PWM
> user not a default value specified by the PWM chip driver.

> The reason we're not using the 'current' period value is because it may
> have been set by the bootloader, and may be inappropriate for our use
> case (ie. the period may be to small to represent the different
> voltages).

> ITOH, we're using the current period value when calculating the current
> voltage, because we want to get the correct voltage value, and the PWM
> device may still use the configuration set by the bootloader (not the
> default one specified in your board or DT files).

> I hope this clarifies the differences between the current and default
> period, and why we should use the default value here.

To be honest I'm still a bit confused here.  When do we actually apply
the default setting and why do we keep on having to constantly override
it rather than doing this once at boot?  It feels wrong to be using it
every time we set anything.  I'd expect it to be something we only need
to do at probe time or which would automatically be handled by the PWM
framework (but that'd have issues changing the state and potentially
breaking things if done in an uncoordiated fashion).

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSiOeAAoJECTWi3JdVIfQIdUH/1scRqSmMSZgRyJZIIZMQoDg
QI1nBFfCeHoulxgsKhCVxriZUsJi0JgZ0mBZF9ca0Bna9Mug0uKkXm51T+8Kkh8f
Di1+BXRuQ0G1VS/YnQf7HG9Pwx+oDFvThQV/mvbc9cd4Wp6XQteeaBVjIt3P0p2L
Yc8+SNOQOTITyLT3i3zpfRC4xVcOpBsZLx5/4Dceq/teTnZ6PglWvg02Z+kmgsMx
ly5upQb1ESXbVu0rcwTtEf+S+m2JjL82AjOrFGi5VupQa0CYBH022kG9nPBSUH4y
IoolWK/VjIufMUc5QU6mO2zGWMrbIPyZpQiZEEmvMMzgqdZtPdbd+Y2dM7242VU=
=YZof
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
