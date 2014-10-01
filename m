From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 01 Oct 2014 08:14:44 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001081443.GC18463@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Md/poaVZ8hnGTzuv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
In-Reply-To: <20140930180036.GI4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 07:00:36PM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 08:03:14AM +0200, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 05:11:01PM +0100, Mark Brown wrote:
>=20
> > > Not really thought this through fully yet but would having phandles to
> > > the relevant devices do the job?  Kind of lines up with Grant's idea =
of
> > > having dummy drivers.
>=20
> > One of the arguments that came up during the discussion of the sunxi
> > patches is that simplefb is going to be used precisely because there is
> > no real driver for the display part of the SoC yet and nobody knows what
> > the binding will look like. So there's nothing to point at currently and
> > for the same reason having a dummy driver won't work. There's simply no
> > definition of what resources are needed.
>=20
> You may well need to extend the binding in future for an actual driver
> but from the point of view of what's going into the block it really
> should just be a case of reading the datasheet and mechanically typing
> that in.  If we can work out how to say where the framebuffer is we
> really ought to be able to work this stuff out.

I agree from a technical point of view. However given the dynamically
generated nature of the node the problem is more of a logistical nature.
As we've seen U-Boot is being enabled to add clocks to the simplefb node
but I'm fairly certain that there's a regulator somewhere that needs to
be enabled too, be it for powering the display controller, the panel or
the backlight. I wouldn't even be surprised if there were one for each
of those. If so simplefb on this board will break when the regulators
are described in the kernel's DTS.

If we don't consider this a problem then the whole DT ABI stability
business is a farce.

> > > > There may be also resets involved. Fortunately the reset framework =
is
> > > > minimalistic enough not to care about asserting all unused resets at
> > > > late_initcall. And other things like power domains may also need to=
 be
> > > > kept on.
>=20
> > > We might want to do that in the future, though it's not always the ca=
se
> > > that reset is the lowest power state.
>=20
> > That proves my point. If we ever decide to assert resets by default
> > we'll have yet another subsystem that can potentially break existing
> > DTs.
>=20
> OTOH given the level of breakage that's like to introduce we might just
> decide not to do that...

It might be the sensible thing to do in most cases. I think there's a
legitimate reason not to trust firmware. However in case of simplefb we
already do, so I think having a sort of flag to signal that we do trust
firmware would allow us to cope with these situation much better.

> > In the end it brings us back to the very fundamental principles of DT
> > that's been causing so much pain. For things to work properly and in a
> > stable way you have to get the bindings right and complete from the
> > start. That is, it needs to describe every aspect of the hardware block
> > and all links to other components.
>=20
> Or we ned to introduce things in a conservative fashion which does cope
> with backwards compatibility; it's definitely more work but it is
> doable.

Is it? I thought the only way to keep backwards compatibility was by
making any new properties optional. But if those properties add vital
information for the device to work you have to come up with a sensible
default to keep existing setups working that lack the new properties.
Doing that is not going to scale very well. It has a chance of working
for hardware-specific drivers because we may be able to derive the
default from the SoC generation or even the machine compatible. But I
don't see how it could work for something that's supposed to be generic
like simplefb.

I'm hoping that there's a better way that I don't know about, because it
would certainly make a lot of things much easier.

> > > One thing that makes me a bit nervous about this approach in the cont=
ext
> > > of the regulator API is the frequency with which one finds shared
> > > supplies.  I'm not sure if it's actually a big problem in practice but
> > > it makes me worry a bit.  We could probably just do something like ma=
ke
> > > refcounting down to zero not actually disable anything for standard
> > > regulators to deal with it which might be an idea anyway in the conte=
xt
> > > of this sort of dodge.
>=20
> > Yes, that's sort of how I expected clk_ignore_unused to work. The way I
> > understood it, it would cause all unused clocks to be ignored (that is
> > stay enabled if they are).
>=20
> > Of course as Geert pointed out in another subthread, taking this all the
> > way means that we have to disable all power management because the
> > firmware device may be sharing resources with other devices and which
> > therefore are not unused. That's a pretty strong argument and I don't
> > have a solution for that. It is only really a problem for cases where
> > the firmware virtual device isn't taken over by a proper driver at some
> > point, though.
>=20
> Indeed, and we also run into trouble for things where we actually need
> to really turn off the resource for some reason (MMC has some needs here
> for example).

So if disabling power management wholesale isn't going to be an option,
what's the alternative? I originally proposed that the clock drivers
could be modified to not disable clocks that are known to be problematic
with simplefb. People objected to that because they thought it would be
impractical to determine which clocks are involved with display across
various boards.

Handling this in the clock driver has worked remarkably well for us on
Tegra, but perhaps that's just because Tegra is an unusually sane design
to begin with.

On the other hand you cannot do that for regulators in the drivers
because they can be used on a wide variety of boards. But at least for
regulators there's a way to handle that kind of thing in DT by marking
the regulators always-on. That allows this to become a board-integration
issue and we can actually stage things in piece by piece. For example as
long as the board doesn't support a proper display driver with all the
needed resources hooked up the regulators would be marked always-on and
allow display to keep running as set up by firmware. But once they are
properly hooked up with the real driver the always-on property can be
removed and things will keep working.

What the above doesn't handle well is seamless transition from simplefb
to a real driver, which I think is going to be a useful feature to have
and it will need to keep working for much longer than the other use-case
where simplefb is the primary framebuffer.

Thierry

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUK7fzAAoJEN0jrNd/PrOhGHwP/0oHVmgM+s8VJwC/lR5SH9D+
YQmaFkG//5gmGFJICIYU2GhBVQ4rGEX7OrdokEpt/M385UacKZ8FyP9nIhAaSHbH
JeUswCwJz6PtloXQXzT4EyQWwIZqBJJuPGBjeE0Tj6fx9SZglCgCuumfXyKD6Qjq
W/BNSbIRDdM2vhDGPvuOlt69HE2wWzhhvhceWAD0tgxUntJvlbHye1qwHAuCmwAx
XaAEZKq8Hqp83hBBmxSYfbSUAVr674IzzbqkSi5Tlrs02GX2+Ad0c6M4u9VViZYX
nYTFSOM4ibjfqI+KtQv6GuASZLqp9OqnzIM9yLVPUtwyE/VTGn27u8f6GaUT3+pg
ItqpmZBd+4tsNSWu10eSDcqN9SUCZGCqsz8M7XTtqt3KCZF48uxebJCz7PFk5IYr
xkuWCRqukCmFBp1zfl0/BgwR5CoQoUlfPQwWz/9UcTLSNG9UyogOtgtOuKa9yUI6
xzXKG1KKVaFhcY59c1sL6fHMEuSNtWXfkNfB128VwxWF1wOKNCSBE95r5QdZmcUx
o5lmJGTgDdmsw54TkLylIhnO0sPWIZjYDFLV6FcH7vRFRB6P0lil/WrkLl+S/WcS
vZGMvM0C3UMnYAi8j/W1w7/qYnjxNCRWy5CutAsCkM3NXUCOylHSBRVzkhOSJM0W
mYT8W6T3J7TcGwIhQ11R
=i11p
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
