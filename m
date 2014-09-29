From: Mark Brown <broonie@kernel.org>
Date: Mon, 29 Sep 2014 15:55:17 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929155517.GR16977@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aH/0uqREc1VzwMkO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
In-Reply-To: <20140929134708.GB30998@ulmo>
To: linux-arm-kernel@lists.infradead.org


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:

> What happened in the Snow example is that regulators that were
> previously on would all of a sudden be automatically disabled on boot
> because there was now a driver that registered them with a generic
> framework.

Not quite - there was also DT added for them.  With just the driver the
regulator API shouldn't have touched them, it'd just have exposed them
read only.

> The same thing is going to happen with simplefb for your device. If you
> later realize that you need a regulator to keep the panel going, you'll
> have to add code to your firmware to populate the corresponding
> properties, otherwise the regulator will end up unused and will be
> automatically disabled. At the same time you're going to break upstream
> for all users of your old firmware because it doesn't add that property
> yet.

> And the same will continue to happen for every new type of resource
> you're going to add.

So long as we're ensuring that when we don't start supporting resources
without DT additions or at least require DT additions to actively manage
them (which can then include simplefb hookup) we should be fine.

> > > The difference is that with the solution I proposed we don't have to
> > > keep track of all the resources. We know that firmware has set them up
> > > and we know that a real driver will properly take them over at some
> > > point

> > You keep saying that... and you know that you can't make this
> > assumption.

> Why not? Are you really expecting to keep running with simplefb forever?
> Nobody is going to seriously use an upstream kernel in any product with
> only simplefb as a framebuffer. I've said before that this is a hack to
> get you working display. And that's all it is. If you want to do it
> properly go and write a DRM/KMS driver.

Well, for product probably not.  But in terms of the runtime of a kernel
I'd not be so sure - people do dogfood and we should be allowing that.
I've used unaccelerated displays with reasonable success for a large
part of my work in the past.

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKYDkAAoJECTWi3JdVIfQAucH/0fbMV9vHaQwQ9SYmmr6ebLT
Fu1lP1xxQ+S1GasSph++G0JAjefy2yEk5zaqm5JLlgYBrJV7Vji/tcC1PLGRgYED
zAtcP/6JmZs+VIr1122ITnpII1bpRTzfWdzmwePiByHVFDh8uVJ3NYLFO4oAfeIU
7Hf9ePBxOBQ5R/piu94M2LEdhe6wUa/9UAPO+4M3UACuuFR5+e1FYJC3W41wn2qm
3xG/aDJKQx6J2P47qbm6JfhMbVxIA60uT5b7uCH/nifjJ3xuzMYgyxIM7bSkClQd
V4+5wiwMO3T/KqzGKhcCZp3Lv3+/9Sm84FMlIxJ2LJid4vpKWV/wwh0hv4VthB4=
=Bi1k
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--
