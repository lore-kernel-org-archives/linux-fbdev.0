From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Sep 2014 12:41:40 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930124140.GC4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LwW0XdcUbUexiWVK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be>
In-Reply-To: <20140929220250.GD5599@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 12:02:50AM +0200, Luc Verhaegen wrote:

> 2) Simplefb will only have a single user: the rpi. As the only other=20
> users i can think of, which does not have a full driver and which does=20
> not have clocks automatically disabled, are discrete cards. And they do=
=20
> not really tend to happen with dt or platform devices.

I thought the goal was for other platforms to use simplefb while waiting
for the real drivers to be loaded (so you can get get console output as
early as possible from a built in driver for example)?

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKqUEAAoJECTWi3JdVIfQfe4H/3Fr3SihJx5wCa6IXpEDBKeh
aF2rx+at3ND58WNfBBjLCsBUZm9g7PGl9S+OPVLk3pVkIKpvXti+aE5AnCUYcG0Y
VmPHvDPNXntnrFvFQ90kgSR5IM/bzfEll96F8rjIgI8WB/fsb1UcEUaOxXUYVMQD
u2CZNVim7tUVdG4qBOAd+E0VPsrxR7yYs85J2a8FTUtLrHSRvQHQIEiXEWEGvZ7X
en7nmyT0oWD03q5NIslPzzJI8SPFuxeZypsQcGcErxMz/62GT8koZG34EyB2FjBN
hmR+nZ5Im/2pIN3bdf6Yt9uKQDMWaJjqQZmWUlVOuLM0s6gqpTZahIGqB6/P/Xw=
=FMug
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
