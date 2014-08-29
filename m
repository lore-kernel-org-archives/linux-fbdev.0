From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 29 Aug 2014 08:12:42 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829081236.GA13371@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826143550.GB3027@ulmo> <53FCE704.4030103@redhat.com>
 <20140827093121.GA23186@ulmo> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <54002A7D.90402@redhat.com>
In-Reply-To: <54002A7D.90402@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 09:23:41AM +0200, Hans de Goede wrote:
> On 08/29/2014 09:01 AM, Thierry Reding wrote:
> > On Thu, Aug 28, 2014 at 02:15:40PM +0200, Hans de Goede wrote:
[...]
> >> 2) Tie these resources to simplefb so that the kernel can know when th=
ey
> >> are no longer in use, and it may e.g. re-use the memory
> >=20
> > For the memory there shouldn't be a problem because it's already in the
> > DT node anyway. It has to be there so that simplefb knows where to write
> > to.
>=20
> The memory information currently in the dt node is not complete enough to
> reclaim memory, e.g. the sunxi driver always reserves 8M, but the simplefb
> reg entry only describes the part actually used for the framebuffer.

You can easily fix that.

> >> To me the most logical and also most "correct" way of modelling this i=
s to
> >> put the resources inside the simplefb dt node.
> >=20
> > Except that simplefb isn't a real device, so there's a hard time
> > justifying its existence in DT as it is. Claiming resources from a
> > virtual device doesn't sound correct to me at all.
>=20
> Yet you want it to claim memory that does not seem consistent to me.

Because it needs to explicitly access that memory. It does not need to
explicitly access the clocks.

> >>>> The key word here is "the used resources" to me this is not about si=
mlefb
> >>>> managing resources, but marking them as used as long as it needs the=
m, like
> >>>> it will need to do for the reserved mem chunk.
> >>>
> >>> The difference between the clocks and the memory resource is that the
> >>> driver needs to directly access the memory (it needs to map it and
> >>> provide a userspace mapping for it) whereas it doesn't need to touch =
the
> >>> clocks (except to workaround a Linux-specific implementation detail).
> >>
> >> Erm, no, the need to map the memory and the memory being a resource
> >> which may be released are an orthogonal problem. E.g. a system with
> >> dedicated framebuffer memory won't need to use a reserved main-memory
> >> chunk, nor need to worry about returning that mem when simplefb is no
> >> longer in use.
> >=20
> > I would think the memory should still be reserved anyway to make sure
> > nothing else is writing over it. And it's in the device tree anyway
> > because the driver needs to know where to put framebuffer content.
>=20
> No, the address were to write framebuffer contents currently is in the
> simplefb node, not the actually backing memory info. I can fully see
> some crazy hardware where a chunk of main memory is reserved for some
> funky video engine, and then that chunk of memory gets accessed through
> io-mem addresses for framebuffer access (e.g. the hardware may need this
> to know when the fb is dirtied).

We're drifting off into the realm of hypotheses here. Of course if you
can't make the hardware work with these simple assumptions because it's
too whacky then that's just tough luck.

> > So
> > the point I was trying to make is that we can't treat the memory in the
> > same way as clocks because it needs to be explicitly managed. Whereas
> > clocks don't. The driver is simply too generic to know what to do with
> > the clocks. It doesn't know what frequency they should be running at or
> > what they're used for, so by any definition of what DT should describe
> > they're useless for this virtual device.
>=20
> I don't see why you keep insisting that the memory is so special, it is
> just another resource which we need to claim,

It's the only resource which we need to claim. Because it is the only
resource that needs to be explicitly accessed. simplefb is useless if
you don't write to that memory.

>                                               and tie to the simplefb node
> so that it can be re-used (or disabled) when simplefb is no longer used
> (it could e.g. be unbound explicitly on headless systems).

On headless systems the firmware shouldn't be setting up a framebuffer
in the first place.

> > Furthermore it's fairly likely that as your kernel support progresses
> > you'll find that the driver all of a sudden needs to manage some other
> > type of resource that you just haven't needed until now because it may
> > default to being always on. Then you'll have a hard time keeping
> > backwards-compatibility and will have to resort to the kinds of hacks
> > that you don't want to see in the kernel.
>=20
> kernel support? This is about u-boot's video code and the simplefb bindin=
gs.

And the kernel doesn't need to use the simplefb bindings? Why are we
even having this conversation, then?

> > So it really boils down to the DT needing to describe a complete device
> > with all the dependencies. And just clocks aren't the complete
> > description. But if you want the complete description then you're going
> > to need a complete driver as well and simplefb is out of the picture
> > anyway.
>=20
> Yes we eventually need a full kernel driver, with its own bindings, that
> is not what this is about.

It is to some degree. The whole point of simplefb is to provide a useful
graphical output until a full driver is in place. The way to achieve
that is by taking advantage of the firmware setting things up for you.
Which is what I've been saying all along. If the firmware has already
set things up for you, you shouldn't need to do anything special like
enabling clocks because they are already on.

Oh, and let me restate that that's not actually what the patch is doing.
It isn't enabling clocks at all. It's merely a workaround to keep them
running.

> > Once again, the current, basic form of the binding allows for a
> > completely generic implementation of the driver because it makes
> > assumptions about firmware setting things up the right way so that the
> > driver doesn't have to.
>=20
> Except that it does not work because it does not claim the necessary
> resources.

Wrong. The reason it doesn't work is because the clock framework
disables the clocks. That's a Linux-specific implementation detail and
therefore shouldn't influence the binding in any way.

> We seem to be at a point where this discussion is just going in circles,
> and since there seems to be no reasonable alternative to the proposed
> solution of adding the clocks to the simplefb node, can you please just
> stop blocking progress on this?

A couple of different solutions to the problem were proposed during the
discussion. It's just that nobody's been willing to take a step back and
look at this from a different perspective.

> Your objection to this has been duly noted,

Right. Ignored is how I would put it.

>                                             but no one is forcing you or
> other people to actually use the clocks property in your implementation
> of simplefb. So if your 101% certain that this is a bad idea, can you
> please just let us (the sunxi people) make our own mistakes and learn
> from those ?

Ugh... This isn't just about letting you make your own mistakes. This is
about solving things in a wrong way (and device specific way) and baking
something into an ABI that really doesn't need to be there. And more
specifically if we let clocks be "managed" by simplefb we can no longer
claim that it is simple and therefore can't block adding all other sorts
of device-specific hacks to it.

> As we actually plan to use the clocks property, we will be
> the ones which will have to deal with any issues.

Wrong. Everyone that potentially wants to use the driver will have to
deal with this.

Anyway, I am getting tired of this whole discussion and as you already
said we're not making any progress. You really should repost this series
to the devicetree mailing list and give people there a chance to look at
the proposed changes. If everybody else is fine with it my objections
will be overruled anyway. I'll just have to sort out/live with the mess
when I want to use simplefb for hand-off.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUADX0AAoJEN0jrNd/PrOhRv0QAIh0GE+W3SUqkucq/2BHkZpE
m5E3UhWL4HaaVdWSGLFbLo2P8/TCLIl1TUuS/uh9u2aSEysTGsXl6P2OyBBuIUy6
MjS5K3rdcAY55bPVxVE+36dbh50o9VBtJjSwkQTN/XopceDmZh7LRFEP9MN4/ZaW
liPxJVuSFwlUPORGjGNhuk0K4W579DGNrT9SR5FbhijQSij18F5MuVVQhVg9rWrI
n4pTWP8MSGdZG4Dwb0WUFJIpiqlk72pm9JybplJF3rIWRLOkaJvUQMIyVReBJLiL
9iVViEVA1u5bv0utSSmPbnHs8I/dVhcS42+fz/NM09vt45d5CBVX2bfHsXiC740C
3HGESh3iRrIW2IHrld/eWk/yx4FiDchDgwusPizsuJCO4oJWXlWqbaaxR+r33W+E
03MsUQDF7Ur70nBZFNZAGiF+6ok4FUQPeezt6VYTodTzQgX2c1zq2OcUEdh7h+r3
EyQvrYv4QxvJW8/8R48EMomxLHhpuOoNTjLykmRUGH/y7HNCDgAm69JJM0QH+Y+W
rtVUNF1zJCdprrclRgHvWgNcXH1oqL2fQqfJHEKwg9nxfKFsB1sQj+9iMYzdbMHW
3CpYEmwNwjnWwgRrWVpyUWDqyQNv60u4zM5I//LMSfoZFqFKI2QhIrMgUikiGjVk
mksGAgeUW0x8xXkz4EA6
=+PIw
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
