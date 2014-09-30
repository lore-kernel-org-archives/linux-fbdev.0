From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 05:39:02 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930053900.GD29874@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ylS2wUBXLOxYXZFQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be>
In-Reply-To: <20140929220250.GD5599@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 12:02:50AM +0200, Luc Verhaegen wrote:
> On Mon, Sep 29, 2014 at 06:58:42PM +0200, Luc Verhaegen wrote:
> >=20
> > In the 2nd round of this discussion, i stated that another fb or even a=
=20
> > drm driver altogether seemed to be the sensible way out of this mess.
> >=20
> > I suggest drm_rescue.
> >=20
> > Very early on, now almost two months back, i used the word "denialfb".
> > rpifb is the real name of this thing though, but then the dt binding=20
> > names would have to change and whatnot.
> >=20
> > I don't get the resistance, at least not from a technical point of view=
=2E=20
> > And i do not care enough to get properly involved in this pointless and=
=20
> > endless discussion. drm_rescue it is.
> >=20
> > Luc Verhaegen.
>=20
> So Thierry, let's review what we have achieved here.
>=20
> 1) you keep simplefb absolutely true to the name. Congratulations.
> 2) Simplefb will only have a single user: the rpi. As the only other=20
> users i can think of, which does not have a full driver and which does=20
> not have clocks automatically disabled, are discrete cards. And they do=
=20
> not really tend to happen with dt or platform devices.
> 3) a competing driver will be created, which will do these dt-ishy=20
> things.

You clearly haven't bothered to even try and understand what I wanted to
achieve. If you had you'd realize that creating a competing driver isn't
going to change anything.

> 4) it's just a matter of time before the rpi either gets a full driver,=
=20
> or switches over to the driver that everyone else is actually using. And=
=20
> then the misnomer gets deprecated.
>=20
> Was that the outcome you were looking for? I think not.

I had, perhaps naively, expected that you guys would be willing to look
beyond your own nose. You clearly aren't. You've been outright
dismissing any proposals beyond what you originally posted.

You keep bringing up the Raspberry Pi for some reason and suggest that
it is somehow inferior to sunxi. What makes you think it's less entitled
to be supported on Linux than sunxi? I don't care about the Raspberry Pi
and I equally don't care about sunxi. I don't own a Raspberry Pi and I
don't own any Allwinner hardware. What I do care about is Linux and I
want it to work well for all SoCs equally.

Perhaps if you could put aside your crusade against the Raspberry Pi for
just a second you'll realize that we're all on the same team. This isn't
a competition and I'm not trying to put a spoke in your wheel. On the
contrary, I'm actually trying to help you.

Thierry

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKkH0AAoJEN0jrNd/PrOhvJ0P/2Z2M5eRuhUKVKahVnvkJ1Od
c/UTnireP0Qm/UO0U+RgImGgiZyx7dZ3lJil33LvSkk7Ht6ECgEHaLslGTUhTlt5
LxSL5jNg0aaGxtJE4fVgQZ/pA8hvfc5ccr+ci8RA+hlZErm4sSO4kD0RH2hnh+mR
O09LzOV+MXxJ4Brz58wX13AqpUnCtF+FvDWWfYlA07Dh8MclIXIY0/qLiwUAe5Sp
aex/ZVRCKzXasI8vtDrw1CvygJGeAKnVVwOdAyylWV1i5xbgAvyHIWWwyADDO4vh
k11pxkXvpE36AcsqkKO/AqH2M42to0vQckh1N7AYPlgfoOukdU7SzJ6kFm9dwmb8
DMhRarG3fNnn/9ArnfBVa2O3VK2n7c++uRgAhPOcKMyb9/SgPXPjCacRcj3UZw1J
1s+rIgU0Ml+fEZuDCfseuE7U5GzHYKNd8rHjmxWivxzrkOWntEYEtYCWs4SDJmCW
AYfEIwglUNWRZaFvJKm/2VjIbktWN1gtMg8+59P4IytvkPtiNMurWSNF31pQIsZv
MfOkjGlKYTe+Vuo7jih9SFVFWrvb1X4QUsdMdfu4o1Q1wN0EMut2G6FCsaJBTXYW
Q5BqraANDNka/yfilnlcWArYuaO7vPsosT9ZCe2bo/tIWvlO8cr+xew8M7jmqye5
eHLY9zEx49iQNLAU+3fM
=UKXa
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
