From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 02 Sep 2014 09:25:08 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140902092508.GR15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="V20vVeppKF1KePC3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
In-Reply-To: <20140829143812.GC31264@ulmo>
To: linux-arm-kernel@lists.infradead.org


--V20vVeppKF1KePC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
> On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
> > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> > > I would think the memory should still be reserved anyway to make sure
> > > nothing else is writing over it. And it's in the device tree anyway
> > > because the driver needs to know where to put framebuffer content. So
> > > the point I was trying to make is that we can't treat the memory in t=
he
> > > same way as clocks because it needs to be explicitly managed. Whereas
> > > clocks don't. The driver is simply too generic to know what to do with
> > > the clocks.
> >=20
> > You agreed on the fact that the only thing we need to do with the
> > clocks is claim them. Really, I don't find what's complicated there
> > (or not generic).
>=20
> That's not what I agreed on. What I said is that the only thing we need
> to do with the clocks is nothing. They are already in the state that
> they need to be.

Claim was probably a poor choice of words, but still. We have to keep
the clock running, and both the solution you've been giving and this
patch do so in a generic way.

> > > It doesn't know what frequency they should be running at
> >=20
> > We don't care about that. Just like we don't care about which
> > frequency is the memory bus running at. It will just run at whatever
> > frequency is appropriate.
>=20
> Exactly. And you shouldn't have to care about them at all. Firmware has
> already configured the clocks to run at the correct frequencies, and it
> has made sure that they are enabled.
>=20
> > > or what they're used for
> >=20
> > And we don't care about that either. You're not interested in what
> > output the framebuffer is setup to use, which is pretty much the same
> > here, this is the same thing here.
>=20
> That's precisely what I've been saying. The only thing that simplefb
> cares about is the memory it should be using and the format of the
> pixels (and how many of them) it writes into that memory. Everything
> else is assumed to have been set up.
>=20
> Including clocks.

We're really discussing in circles here.

Mike?

Your opinion would be very valuable.

> > > so by any definition of what DT should describe they're useless for
> > > this virtual device.
> > >
> > > Furthermore it's fairly likely that as your kernel support progresses
> > > you'll find that the driver all of a sudden needs to manage some other
> > > type of resource that you just haven't needed until now because it may
> > > default to being always on. Then you'll have a hard time keeping
> > > backwards-compatibility and will have to resort to the kinds of hacks
> > > that you don't want to see in the kernel.
> >=20
> > Not such a hard time. An older DT wouldn't define the new requirements
> > anyway, so they wouldn't be used, and we would end up in pretty much
> > the current case.
>=20
> Except that you have firmware in the wild that sets up an incomplete
> simplefb node and if you don't want to break compatibility you need to
> provide fallbacks for the resources that aren't listed in the DT node.
> And given that those fallbacks are all very board specific you'll need
> to find ways to keep them enabled if you want to keep existing setups
> working.

How would an *optional* property break those users?

If you don't need any clock to be kept running (or are hiding them
under the carpet), of course you don't need such a property.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--V20vVeppKF1KePC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBYzzAAoJEBx+YmzsjxAg07gP/3vRCpMruVSAmL/t/OXkhL5V
zneIrRHflkU4vKO8ZTHo2pgBqrP/IrEFkqDEcyLM5ZNk+4LcXsGi1CFRbn6aIat2
0fM38zExl9ZPF1fHy9jwF17759K9CttJWBQcsW+bnvyMi5uFozTlZv5s+/mBQGpS
kWnByQCyDrOn7NIUhGw35Qk7Vs+cbs6PzE0v6rUEEZ+AyvvTz/YateHKRNiGNqeS
oFOuH0Ap9GLbS5YBc/weJV82mUQi8N4m3uV+uTbz8XPPJJj36KUzFxjWBPmlgZ28
ymXn28izn6bu/McME0/qJjVxxA8ekxwqtSR6fsLqWNNW1ImSgh70CEiG4xxf59Er
g5Glbzk15I92epy7OTWgaG/3DPNYjqPZDm/Y3GqXhvfmoGt1rAEbqgLLjgRRt3fH
RDpOnOpHD70+VwzMjWycpbilVbpGsdBPmW56tnh3G+LxJMzQrxhaoI+RkH2bFtbI
e887z3bUWxAIzdhV8byHay35mVZHDBPVmjrJwj4yXeYOv6E3QkoespDUa5ZThEGI
sB+1gdVzyqoWsdNrwVsoDx6eq4DIPDo3Kz0F2KG5XG55NyR1/OV/9hzzq/pbbinM
rulDRVvub4FNiR1u/dX3AoD6w+vw6w4cqZnQPN2M/xXykfqkGV+B1OEkAUZ8xD+6
tcKzCu6d3DmxBpXYh6VT
=4PCL
-----END PGP SIGNATURE-----

--V20vVeppKF1KePC3--
