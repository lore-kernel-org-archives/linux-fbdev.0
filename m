From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 29 Sep 2014 09:23:01 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929092301.GC4388@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
In-Reply-To: <20140929080637.GB12506@ulmo>
To: linux-arm-kernel@lists.infradead.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 10:06:39AM +0200, Thierry Reding wrote:
> On Sat, Sep 27, 2014 at 04:56:01PM -0700, Mike Turquette wrote:
> > Quoting Maxime Ripard (2014-09-02 02:25:08)
> > > On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
> > > > On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
> > > > > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> > > > > > I would think the memory should still be reserved anyway to mak=
e sure
> > > > > > nothing else is writing over it. And it's in the device tree an=
yway
> > > > > > because the driver needs to know where to put framebuffer conte=
nt. So
> > > > > > the point I was trying to make is that we can't treat the memor=
y in the
> > > > > > same way as clocks because it needs to be explicitly managed. W=
hereas
> > > > > > clocks don't. The driver is simply too generic to know what to =
do with
> > > > > > the clocks.
> > > > >=20
> > > > > You agreed on the fact that the only thing we need to do with the
> > > > > clocks is claim them. Really, I don't find what's complicated the=
re
> > > > > (or not generic).
> > > >=20
> > > > That's not what I agreed on. What I said is that the only thing we =
need
> > > > to do with the clocks is nothing. They are already in the state that
> > > > they need to be.
> > >=20
> > > Claim was probably a poor choice of words, but still. We have to keep
> > > the clock running, and both the solution you've been giving and this
> > > patch do so in a generic way.
> > >=20
> > > > > > It doesn't know what frequency they should be running at
> > > > >=20
> > > > > We don't care about that. Just like we don't care about which
> > > > > frequency is the memory bus running at. It will just run at whate=
ver
> > > > > frequency is appropriate.
> > > >=20
> > > > Exactly. And you shouldn't have to care about them at all. Firmware=
 has
> > > > already configured the clocks to run at the correct frequencies, an=
d it
> > > > has made sure that they are enabled.
> > > >=20
> > > > > > or what they're used for
> > > > >=20
> > > > > And we don't care about that either. You're not interested in what
> > > > > output the framebuffer is setup to use, which is pretty much the =
same
> > > > > here, this is the same thing here.
> > > >=20
> > > > That's precisely what I've been saying. The only thing that simplefb
> > > > cares about is the memory it should be using and the format of the
> > > > pixels (and how many of them) it writes into that memory. Everything
> > > > else is assumed to have been set up.
> > > >=20
> > > > Including clocks.
> > >=20
> > > We're really discussing in circles here.
> > >=20
> > > Mike?
> > >=20
> >=20
> > -EHIGHLATENCYRESPONSE
> >=20
> > I forgot about this thread. Sorry.
> >=20
> > In an attempt to provide the least helpful answer possible, I will stay
> > clear of all of the stuff relating to "how simple should simplefb be"
> > and the related reserved memory discussion.
> >=20
> > A few times in this thread it is stated that we can't prevent unused
> > clocks from being disabled. That is only partially true.
> >=20
> > The clock framework DOES provide a flag to prevent UNUSED clocks from
> > being disabled at late_initcall-time by a clock "garbage collector"
> > mechanism. Maxime and others familiar with the clock framework are aware
> > of this.
> >=20
> > What the framework doesn't do is to allow for a magic flag in DT, in
> > platform_data or elsewhere that says, "don't let me get turned off until
> > the right driver claims me". That would be an external or alternative
> > method for preventing a clock from being disabled. We have a method for
> > preventing clocks from being disabled. It is as follows:
> >=20
> > struct clk *my_clk =3D clk_get(...);
> > clk_prepare_enable(my_clk);
> >=20
> > That is how it should be done. Period.
> >=20
> > With that said I think that Luc's approach is very sensible. I'm not
> > sure what purpose in the universe DT is supposed to serve if not for
> > _this_exact_case_. We have a nice abstracted driver, usable by many
> > people. The hardware details of how it is hooked up at the board level
> > can all be hidden behind stable DT bindings that everyone already uses.
>=20
> simplefb doesn't deal at all with hardware details. It simply uses what
> firmware has set up, which is the only reason why it will work for many
> people. What is passed in via its device tree node is the minimum amount
> of information needed to draw something into the framebuffer. Also note
> that the simplefb device tree node is not statically added to a DTS file
> but needs to be dynamically generated by firmware at runtime.

Which makes the whole even simpler, since the firmware already knows
all about which clocks it had to enable.

> If we start extending the binding with board-level details we end up
> duplicating the device tree node for the proper video device. Also note
> that it won't stop at clocks. Other setups will require regulators to be
> listed in this device tree node as well so that they don't get disabled
> at late_initcall. And the regulator bindings don't provide a method to
> list an arbitrary number of clocks in a single property in the way that
> the clocks property works.
>=20
> There may be also resets involved. Fortunately the reset framework is
> minimalistic enough not to care about asserting all unused resets at
> late_initcall. And other things like power domains may also need to be
> kept on.
>=20
> Passing in clock information via the device tree already requires a non-
> trivial amount of code in the firmware. A similar amount of code would
> be necessary for each type of resource that needs to be kept enabled. In
> addition to the above some devices may also require resources that have
> no generic bindings. That just doesn't scale.
>=20
> The only reasonable thing for simplefb to do is not deal with any kind
> of resource at all (except perhaps area that contains the framebuffer
> memory).

You should really read that thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/284726=
=2Ehtml

It's quite interesting, because you'll see that:
A) Your approach, even on the platform you're working on, doesn't
   work. Or at least, isn't reliable.
B) Other maintainers, precisely like Mark, came to the same conclusion
   than Mike.

> So how about instead of requiring resources to be explicitly claimed we
> introduce something like the below patch? The intention being to give
> "firmware device" drivers a way of signalling to the clock framework
> that they need rely on clocks set up by firmware and when they no longer
> need them. This implements essentially what Mark (CC'ing again on this
> subthread) suggested earlier in this thread. Basically, it will allow
> drivers to determine the time when unused clocks are really unused. It
> will of course only work when used correctly by drivers. For the case of
> simplefb I'd expect its .probe() implementation to call the new
> clk_ignore_unused() function and once it has handed over control of the
> display hardware to the real driver it can call clk_unignore_unused() to
> signal that all unused clocks that it cares about have now been claimed.
> This is "reference counted" and can therefore be used by more than a
> single driver if necessary. Similar functionality could be added for
> other resource subsystems as needed.

So, just to be clear, instead of doing a generic clk_get and
clk_prepare_enable, you're willing to do a just as much generic
clk_ignore_unused call?

How is that less generic? You know that you are going to call that for
regulator, reset, power domains, just as you would have needed to with
the proper API, unless that with this kind of solution, you would have
to modify *every* framework that might interact with any resource
involved in getting simplefb running?

Plus, speaking more specifically about the clocks, that won't prevent
your clock to be shut down as a side effect of a later clk_disable
call from another driver.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKST1AAoJEBx+YmzsjxAgMFMP/3nGvHxVhGhE0BDdgGB4pB2h
u8kmIy4pJSarVpq4Vsb7V/dZzXczLOdmyLGGks+EnwlCWg1PRHnC5nurK9LJ6kLV
T77WI6E4BfGt6L4CaQ9HrkjkMjNPYojmanserOrunWQqRvLBY7qEeOGt64GY3wEG
aYv4OG9Nd9+4Efvd+vYELJrtNam8sGrVr6maP9xLSpmoYCytgSrkfILQ1LnMCDWn
4Az2BFVpudJFgx8UOQcwBebYvXuuJqsp/SVsz5XIBHr2D0aJiifr/4Nm7XBqRDtY
E5tw6CyTAC9xOTUFdGhTmZaoXVWQ5zhgaBBIaGUQiTxt0nRRL0hsJaOrs+s570f5
gapLCt0mknWd+zDVGWiuiwbGeoXD8szUyFaRB0saiuGvS1qpubDiPnrpIeLj9fHu
HP31ibIAU2Y5/Gd3JtzTdb4bkgmtZdXdrQwGkSjXWxAtB1V39Cs+5sDWhJKi67kO
PlkOCC7m+kFk5V7QfDzgowe3egIozyXmV9VVc/ilAi7rzOEiLC3vugaVVEQwwfuh
RSFc9zXS26YMOPjIvsOYo/fqaJz2Mi9UFAfjQr3FRVykMrAB8P+v/AY3i0zuMeH/
3ERfmpTFHNeIIx5p9SfdYK0MjVask/onnHNCUE3uHwnv8jHWsMwSNU2FEm45FXOV
BG7zIqkWGlERYeexJu8I
=l1Fl
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
