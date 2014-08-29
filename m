From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 29 Aug 2014 14:38:14 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829143812.GC31264@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826143550.GB3027@ulmo> <53FCE704.4030103@redhat.com>
 <20140827093121.GA23186@ulmo> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
In-Reply-To: <20140829141244.GH15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
> On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> > I would think the memory should still be reserved anyway to make sure
> > nothing else is writing over it. And it's in the device tree anyway
> > because the driver needs to know where to put framebuffer content. So
> > the point I was trying to make is that we can't treat the memory in the
> > same way as clocks because it needs to be explicitly managed. Whereas
> > clocks don't. The driver is simply too generic to know what to do with
> > the clocks.
>=20
> You agreed on the fact that the only thing we need to do with the
> clocks is claim them. Really, I don't find what's complicated there
> (or not generic).

That's not what I agreed on. What I said is that the only thing we need
to do with the clocks is nothing. They are already in the state that
they need to be.

> > It doesn't know what frequency they should be running at
>=20
> We don't care about that. Just like we don't care about which
> frequency is the memory bus running at. It will just run at whatever
> frequency is appropriate.

Exactly. And you shouldn't have to care about them at all. Firmware has
already configured the clocks to run at the correct frequencies, and it
has made sure that they are enabled.

> > or what they're used for
>=20
> And we don't care about that either. You're not interested in what
> output the framebuffer is setup to use, which is pretty much the same
> here, this is the same thing here.

That's precisely what I've been saying. The only thing that simplefb
cares about is the memory it should be using and the format of the
pixels (and how many of them) it writes into that memory. Everything
else is assumed to have been set up.

Including clocks.

> > so by any definition of what DT should describe they're useless for
> > this virtual device.
> >
> > Furthermore it's fairly likely that as your kernel support progresses
> > you'll find that the driver all of a sudden needs to manage some other
> > type of resource that you just haven't needed until now because it may
> > default to being always on. Then you'll have a hard time keeping
> > backwards-compatibility and will have to resort to the kinds of hacks
> > that you don't want to see in the kernel.
>=20
> Not such a hard time. An older DT wouldn't define the new requirements
> anyway, so they wouldn't be used, and we would end up in pretty much
> the current case.

Except that you have firmware in the wild that sets up an incomplete
simplefb node and if you don't want to break compatibility you need to
provide fallbacks for the resources that aren't listed in the DT node.
And given that those fallbacks are all very board specific you'll need
to find ways to keep them enabled if you want to keep existing setups
working.

Thierry

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAJBUAAoJEN0jrNd/PrOhABEP/RiFL8UAyHrSgqAWbm0A3Zs0
2yfhEdIaqRNZXqx1ClM0pI69OVgZ7h9y656STzA5Fcbg1Ywzw+7g5lQqcncQk8UW
gG5qlawHLpok1Nka43Brpt0jPtjUeq+BWJHKaKHHEeB94fanhl/o/jOfH4GrA83A
KK6qMo0IlRmJEW5+Z7RjBs1A8LKWfDneEafmgvNwaUAMeqyoxiR457ze1R5unikR
lewvoG0dXoB/aSAQrkPRMh/bDOhbOKOxcawXwjbVq7KzoWPbOlDpOJ6q5WhEvEeN
u0hzAN/7ezzatjUvDJR3kYoIUpRBtDno5+8j7iN7/6xkLRA+Gla//XFa0e0Tkru0
fVPRT+mpyuf2B2XZ/zJp09MJA9jFqqvod0PbyVMt6ztKR4uYJ/HL4OmZZ0PgbDYe
QCu7XUA/3CHegFbmUHwax+VBe0wJKAN8Z5ecc6IcKxcFzXqJLYYmrUGgg6L20Z2R
daHKxDcwO4BVR5QpRfGhRJjOlTNfAdEIe19FmwTIoSajK4Oa44TytqAbjoO3iuSV
f6dtG5wRwV5AJF00hNN87hZpmuz4xpHBrvcTWJBftc0QJhnQlXRdItxXjev9aY7n
Gvgf5wQA0bHHILaDkUeHJTrqx2oQZExzfmu/8vfi0+jdCLqD0CCw8P7y1TyPZejp
86k9Z1/4UjGai51Zu4em
=s94B
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
