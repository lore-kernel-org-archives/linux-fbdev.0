From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 11:31:47 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930113144.GA19694@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929162814.GE4081@lukather>
 <20140930052110.GC29874@ulmo> <20140930075258.GH4081@lukather>
 <20140930085429.GB4059@ulmo>
 <CAOMqctRM1YZBR+p=0R39BSX_GT6XagPcb4HBG1BqW1OqyB48zw@mail.gmail.com>
In-Reply-To: <CAOMqctRM1YZBR+p=0R39BSX_GT6XagPcb4HBG1BqW1OqyB48zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 11:38:50AM +0200, Michal Suchanek wrote:
> On 30 September 2014 10:54, Thierry Reding <thierry.reding@gmail.com> wro=
te:
> > On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
> >> On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
> >> > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
> >> > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
> > [...]
> >> > > > What happened in the Snow example is that regulators that were
> >> > > > previously on would all of a sudden be automatically disabled on=
 boot
> >> > > > because there was now a driver that registered them with a gener=
ic
> >> > > > framework.
> >> > > >
> >> > > > The same thing is going to happen with simplefb for your device.=
 If you
> >> > > > later realize that you need a regulator to keep the panel going,=
 you'll
> >> > > > have to add code to your firmware to populate the corresponding
> >> > > > properties, otherwise the regulator will end up unused and will =
be
> >> > > > automatically disabled. At the same time you're going to break u=
pstream
> >> > > > for all users of your old firmware because it doesn't add that p=
roperty
> >> > > > yet.
> >> > > >
> >> > > > And the same will continue to happen for every new type of resou=
rce
> >> > > > you're going to add.
> >> > >
> >> > > Sure, we can add any resources we will need. Regulators, reset lin=
es,
> >> > > pm domains, allocated memory, but I'm not really sure this is what=
 you
> >> > > want, right?
> >> >
> >> > No it's not what I want. *You* want to add resource management to th=
is
> >> > driver. What I'm saying is that if we start adding clocks then we ca=
n no
> >> > longer say no to resets or regulators or power domains either.
> >>
> >> Yes, because resource management can be more than just "keep the thing
> >> enabled". It might also be about not modifying anything, just like we
> >> saw for the clocks, but that might also apply to regulators voltage.
> >
> > We've already determined that simplefb can't do anything meaningful with
> > the resources other than keep them in the status quo. It simply doesn't
> > have enough knowledge to do so. It doesn't know the exact pixel clock or
> > what voltage the attached panel needs.
> >
> >> And the only way I can think of to deal with that properly is to have
> >> resources management in the driver.
> >
> > My point is that if we had a proper way to tell the kernel not to do
> > anything with resources owned by firmware, then the driver wouldn't
> > have to do anything with the resources.
>=20
> The firmware on sunxi does not own any resources whatsoever. It ceases
> running once it executes the kernel. This is different from ACPI and
> UEFI where you have pieces of the firmware lingering indefinitely and
> potentially getting invoked by user pressing some button or some other
> hardware event. It is also different from rpi where the Linux kernel
> effectively runs in a virtual environment created by the firmware
> hypervisor.

You know all that because you of course wrote every single firmware
implementation that does and will ever exist for sunxi. There's nothing
keeping anyone from running UEFI on a sunxi SoC.

> So on sunxi and many other ARM machines the Linux kernel is the sole
> owner of any resources that might happen to be available on the
> machine. There is no firmware owning them when the Linux kernel is
> running, ever.

Of course this is part of the abstraction. The idea is that the device
is a virtual one created by firmware. Therefore firmware owns the
resources until the virtual device has been handed over to the kernel.

If you're into splitting hairs, then the simplefb device shouldn't exist
in the first place.

> And we do have a proper way to tell to the kernel what these resources
> are used for - inserting description of them into the simplefb DT
> node. Sure the simplefb cannot manage the resources in any way and but
> it does own them. When it is running they are in use, when it stops
> they are free to be reclaimed by the platform driver.

Yes. And again I'm not saying anything different. What I'm saying is
that we shouldn't need to know about the resources and instead hide that
within the firmware, for the same reason that we're already hiding the
register programming in hardware, namely to create an abstraction that
works irrespective of the underlying hardware.

> But you refuse to marge the kernel change for this proper management
> to happen.

I have no authority to merge these changes nor have I any way of vetoing
them. All I'm saying is that I think it's a bad idea. If nobody else
thinks it is then it will eventually get merged irrespective of what I'm
saying. And when that happens I'll shut up and live happily ever after.
But it doesn't magically convince me that it's a good idea.

> The alternate proposal to stop the kernel from managing resources
> while simplefb is running and refernce count drivers that cannot
> manage resources is indeed a workable, general alternative.
>=20
> It does however switch the kernel into special mode when resources are
> not managed and will needlessly hinder eg. development and testing of
> powermanagement and hotplug for drivers unrelated to kms in parallel
> to kms.
>=20
> But let's look at this special mode closer.
>=20
> Under normal boot sequence when the built-in drivers are initialized
> or around that time the kernel does a pass in which it disables unused
> clocks and possibly reclaims other resources.
>=20
> The boot has finished for the kernel and now it hands over to
> userspace and it is up to the userspace to load any more drivers (such
> as kms) or not. If at that point a driver like simplefb exists it
> should have called that stop_managing_resources() which should replace
> clk_ignore_unused() so that other resources are properly handled
> without the driver ever having to know about them.
>=20
> For clocks this should be simple. At least on sunxi the clock driver
> can tell if the clock is gated and can potentially be in use. It can
> even mark clocks that are used at this point to know not to ever
> disable them. Also it should refuse to ever change a clock frequency
> on these clocks since if one of them was used for simplefb it should
> break. It does not matter it's a mmc bus clock completely unrelated to
> display. If you assume no knowledge you cannot change the mmc clock
> when a different card is inserted or when a card is inserted into an
> empty slot. If the firmware probed the slot the clock might be running
> anyway.
>=20
> Other resources might be more difficult to tackle. Is it possible to
> change voltage regulators? Even the fact that it is set to 0 does not
> necessarily mean that it is unused and then other driver claiming it
> later can change the voltage. So no changing the regulators, ever.
>=20
> And there goes gpio. You cannot assume that you can change any pin
> muxing or any pin level whatsoever. The pin might be connected to the
> display. So no loading of drivers that need any pin assignment
> changes.

The original patches don't tackle any of these problems. And in addition
to what's been mentioned elsewhere you're adding two new types of
resources that need to be potentially claimed here. Fortunately for GPIO
and pinmux the default is to not touch them at all unless explicitly
claimed and controlled. At least as far as I know.

> I guess by now it's clear that if this mode that assumes no knowledge
> of the underlying hardware and requires the kernel to not manage
> resources in order to keep dumb drivers running  completely paralyzes
> the kernel and will among other things prevent loading of the proper
> kms driver.

Yes, Geert already made that argument and I admit that it exposes a flaw
in the solution that I proposed.

> >> > > I really start to consider adding a sunxi-uboot-fb, that would just
> >> > > duplicate the source code of simplefb but also taking the
> >> > > clocks. Somehow, I feel like it will be easier (and definitely les=
s of
> >> > > a hack than using the generic common clock API).
> >> >
> >> > You're not getting it are you? What makes you think sunxi-uboot-fb is
> >> > going to be any different? This isn't about a name.
> >>
> >> At least, we would get to do any binding and resource management we
> >> want. And that's a big win.
> >
> > So instead of trying to understand the concerns that I've expressed and
> > constructively contribute to finding a solution that works for everybody
> > you'd rather go and write a driver from scratch. Way to go.
>=20
> It's the constructive thing to do when the existing driver cannot be
> extended to work for everybody.

No, it isn't. If a generic driver doesn't work for everybody then it
isn't generic and we should fix it. Not duplicate it and add platform
specific quirks.

> > I've already said that I'm not saying strictly no to these patches, but
> > what I want to see happen is some constructive discussion about whether
> > we can find better ways to do it. If we can't then I'm all for merging
> > these patches. Fortunately other (sub)threads have been somewhat more
> > constructive and actually come up with alternatives that should make
> > everyone happier.
>=20
> What are those alternatives?

Sorry, you've got to do some of the work yourself. They've been
mentioned in this thread and the one that Maxime pointed to the other
day.

> > If you're going to do SoC-specific bindings and resource management you
> > are in fact implementing what Grant suggested in a subthread. You're
> > implementing a dummy driver only for resource management, which isn't
> > really a bad thing. It can serve as a placeholder for now until you add
> > the real driver. And you can also use the simplefb driver to provide
> > the framebuffer.
>=20
> Oh, so back to the proposal to make a driver that claims the required
> resources and then instantiates an unextended simplefb that is
> oblivious to the resources to be kept simple?

Pretty much, yes.

> Did I not propose that way back?

Yes, I think you did.

> Was it not already rejected?

No, I don't think it was. In fact I don't think anything was really
rejected yet, we're still in the middle of a discussion.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKpSgAAoJEN0jrNd/PrOhAKIP/3czN+ewUZIsXV4tcQP7vMU5
UmisacGzvWZi+WFJ6lZ1ncsbru63wP5dwLkMD29OioMPsSMPq2M9KI621a6TBmmO
7ogacVwcP7LZYMNlwJxTChtXwIuTV7VRiERLKWBvwg9bUJQaKvpDCa9p3W6qwWR8
FGVBVG6B9uKOnlYNN29yXncZcm5ID/tBxboSeiJivqbPi0Kosf7KMe/2Bb9xcq1q
nNue2RreIMuvu+T0m2sWiG/Ek7LnqztfWpFTuGMLSf4tfL+OCaL5IpniMudfCk4U
NZj7/D6w9bChewolllDm3i79kFrMdSzQJoe7aDFWObK0nYHTuQ47zDDtG9GxrlnO
aULCav02xyD0aSg0xQPlCEgD0npJKFRj2qGeMDs+uIDsu/fy44AK1wZfTr1TMs89
FLJzvrZqqWVOOj9AT6dcQ1JHjs4p51DoE/dPCSHBX0N7WDH6J9WRevH1VtUv6luH
hg8JDyInO9YxZDXBd/CdERD1w8BQ5+sxJf8vR/5+xtb5H/0KMACKQbBu9gTwlKAq
n3dgyA5LyEIhbXd3CsDqrUtvNXEE5Pko/3TAnbHIAlGy+lRyQeoJBjAiOqo0lYuQ
iZN1N+kB4T+cI5LmYsYocZ2OModBlLwick+niBKL+CGPN9z7obTn43dHAlICPIyE
GeNLV9xgcwMyl3If97R5
=N7bC
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
