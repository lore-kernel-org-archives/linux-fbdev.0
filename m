From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 11:02:19 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930110218.GB27560@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929162814.GE4081@lukather>
 <20140929165842.GC5599@skynet.be> <20140929220250.GD5599@skynet.be>
 <20140930053900.GD29874@ulmo> <20140930080354.GI4081@lukather>
In-Reply-To: <20140930080354.GI4081@lukather>
To: linux-arm-kernel@lists.infradead.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 10:03:54AM +0200, Maxime Ripard wrote:
> On Tue, Sep 30, 2014 at 07:39:02AM +0200, Thierry Reding wrote:
> > You keep bringing up the Raspberry Pi for some reason and suggest that
> > it is somehow inferior to sunxi. What makes you think it's less entitled
> > to be supported on Linux than sunxi? I don't care about the Raspberry Pi
> > and I equally don't care about sunxi. I don't own a Raspberry Pi and I
> > don't own any Allwinner hardware. What I do care about is Linux and I
> > want it to work well for all SoCs equally.
> >=20
> > Perhaps if you could put aside your crusade against the Raspberry Pi for
> > just a second you'll realize that we're all on the same team. This isn't
> > a competition and I'm not trying to put a spoke in your wheel. On the
> > contrary, I'm actually trying to help you.
>=20
> We've been over this already, and I'll tell you again that you're
> getting this wrong.
>=20
> No platform is more entitled to get merged than another one. I do care
> about the Allwinner SoCs, and I care just as much about the broader
> Linux support for all the other SoCs, be it from nvidia, samsung or
> whatever vendor you can come up with.

Okay, I'm glad our goals aren't that far apart then. It would be helpful
to stop dragging the Raspberry Pi into this, though, since it isn't at
all relevant.

> But you can't hide the fact that the bcm2835 still has a very limited
> clock support, and I really don't know about its clock tree, but I
> guess that if the times come when they add a more complete clock
> support, they will face the same issue.

This isn't at all relevant. And that's exactly why I think it's good to
hide all the resource management behind firmware. That way it becomes
easy to support any SoC with any firmware.

> If the driver would have been developped initially to create a
> framebuffer on the Allwinner SoCs, at a time when we didn't have any
> clock support too, calling it only usable on sunxi wouldn't have
> shocked me tbh.

The functionality that it provides is still very generic. And the
firmware interface is generic too. It is this abstraction that allows
it to be generic. You on the other hand seem to be arguing that by
making it abstract we've made it less generic.

Abstraction is about hiding details to capture commonality.

Thierry

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKo26AAoJEN0jrNd/PrOhOd8P/RtDdWw6Gbie6TuH8RnXhJqF
b/Tk3TCaZbvMWZGuITXDaPNJjD9ziV9IPdOEeZ0+4lgIoIs1nRzg1QTieT+eD0KQ
4q01bhW0vqoWA46LxSahIGPbdM4vKhStitvHkCZNlnHHfLCZn1r00ZF34ChcBNN9
PONsBcA60B9Nvuj/GaDDnPw5Hmqe/q2SkK9BXsiP12IXAIpuL7Lzo0hGFQqIiiRK
W41xO1vAS1Od+yXBoXG6u5ro3bQl2UGHOOPeLbHkI2JhwSHn/W/GbiZfI9bFRjml
0DF0ORvhm+wbr2dy5Jrtf4SKO7Ud/rKZXb+lMch6VNGMmMJTudjEb3th8zmAH8iU
kcuVtdxhpn6GZpvOM74ZCZy3PLIXHnJgIHcgTyr2H0wmtiePiOos9/BbSYdN3UaT
yRLmbO3NWDFtTqpd3CuTstvE3jv/+0uhAwOZ9n2CLtXoDJ+K7qd3ZKg+x9xQGMfQ
l9VdIUc0fZ8flkY3bMD/6LLEJ8R0dTQJai6rKk5iFHSK2cVXRPkvAW9eohVpujq9
HEOQV74cHwU9Pj/bnGEzMo/fTPrHlbZIY90Ayp+Yu3Q9sHYsXFOEpczb0baIS3rs
/L7Ewi2bbWSNwCQDIpBYzFWkU22RrATKn4scQ8BCMFvKyWKi5LTPXVpSwT3xqoUh
rXBUi1HcJtEsgZJjyAOI
=H6h9
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
