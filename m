From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 18 Nov 2014 15:16:04 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <20141118151603.GA19426@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather>
 <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
 <20141118101911.GA15769@ulmo> <546B26F4.50302@redhat.com>
 <20141118112123.GA3873@ulmo> <546B31A7.9020804@redhat.com>
 <546B3F3C.6050202@redhat.com>
In-Reply-To: <546B3F3C.6050202@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 01:44:44PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 11/18/2014 12:46 PM, Hans de Goede wrote:
> > Hi,
> >=20
> > On 11/18/2014 12:21 PM, Thierry Reding wrote:
> >> On Tue, Nov 18, 2014 at 12:01:08PM +0100, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 11/18/2014 11:19 AM, Thierry Reding wrote:
> >>>> On Thu, Nov 13, 2014 at 09:58:41AM +0100, Geert Uytterhoeven wrote:
> >>>>> Hi Maxime,
> >>>>>
> >>>>> On Thu, Nov 13, 2014 at 9:52 AM, Maxime Ripard
> >>>>> <maxime.ripard@free-electrons.com> wrote:
> >>>>>>> -module_init(simplefb_init);
> >>>>>>> +/*
> >>>>>>> + * While this can be a module, if builtin it's most likely the c=
onsole
> >>>>>>> + * So let's leave module_exit but move module_init to an earlier=
 place
> >>>>>>> + */
> >>>>>>
> >>>>>> Not really related to this patch itself, but do we want to support
> >>>>>> simplefb as a module? It seems like it's going to be most of the t=
ime
> >>>>>> broken.
> >>>>>
> >>>>> If it depends on clocks, it won't work as a module, as CCF will hav=
e disabled
> >>>>> all unused clocks at that point.
> >>>>
> >>>> If it does depend on anything beyond clocks it won't work at all. Cl=
ocks
> >>>> are special because they get set up very early at boot time. If it t=
urns
> >>>> out that a simplefb ever needs a regulator to remain on, and that's =
even
> >>>> quite likely to happen eventually, it's going to fail miserably, bec=
ause
> >>>> those regulators will typically be provided by a PMIC on an I2C bus.=
 The
> >>>> regulator won't be registered until very late into the boot process =
and
> >>>> a regulator_get() call will almost certainly cause the simplefb driv=
er
> >>>> to defer probing.
> >>>
> >>> Right, this has been discussed already and the plan is to have simple=
fb
> >>> continue its probe function and return success from it if it encounte=
rs
> >>> any -eprobe_defer errors, while tracking which resources it misses.
> >>>
> >>> And then have a late_initcall which will claim any resources which fa=
iled
> >>> with -eprobe beforehand.
> >>
> >> How do you ensure that the late_initcall gets run before any of the
> >> other late_initcalls that disable the resources?
> >=20
> >> Also my recollection is
> >> that deferred probing will first be triggered the first time from a
> >> late_initcall, so chances aren't very high that all resources have sho=
wn
> >> up by that time.
> >=20
> > So I just looked up the relevant code, and your right, this means that
> > the whole model of "disable unused resources once probing is done" which
> > we use for e.g. clocks, is already somewhat broken since there is
> > no guarantee probing is really done when the cleanup code runs.
> >=20
> >>>> Now deferring probing is a real showstopper for simplefb, because not
> >>>> only does it make the framebuffer useless as early boot console, once
> >>>> probing is attempted again the clocks that it would have needed to
> >>>> acquire to keep going will already have been switched off, too.
> >>>
> >>> That is not true, even with the current implementation, if all necess=
ary
> >>> drivers are built in, then simplefb will come up later, but it will s=
till
> >>> come up before the late_initcall which disables the clocks.
> >>
> >> Yes, in the current implementation because clocks typically are
> >> registered very early and thus you don't hit the deferred probe. The
> >> same is not true for other types of resources where it's actually quite
> >> common to hit deferred probing (regulators is a very notorious one).
> >>
> >> It doesn't matter whether a driver is built-in or not, once you hit
> >> deferred probing you lose.
> >>
> >>> Once we do the split probing described above (which is something which
> >>> we plan to do when it becomes necessary), then simplefb will still co=
me
> >>> up early.
> >>
> >> It will come up early but won't have acquired all the resources that it
> >> needs, so unless you somehow manage to order late_initcalls in exactly
> >> the way that you need them, the frameworks will still turn off what you
> >> haven't managed to claim yet.
> >=20
> > If it is a resource which only shows up as a result of deferred probing,
> > then it may very well not have been probed & registered yet, when the
> > framework cleanup functions runs, and thus will not get turned off...
> >=20
> > So yes you're right that deferred probing may cause issues, but it seems
> > that this is not something simplefb specific, but rather a generic prob=
lem
> > with deferred-probing vs subsys cleanup functions.
> >=20
> > My view on this is simple, lets worry about this when we actually have
> > a board which hits these issues, and then we'll see from there.
>=20
> So thinking more about this, I think this is not that hard to fix.
>=20
> First lets fix the generic conflict between eprobedefer and subsys cleanup
> functions. This can be done by:
>=20
> 1) Having a linked list of subsys cleanup functions
> to call in drivers/base/dd.c
>=20
> 2) Have subsystems register their cleanup function rather then using
> late_initcall to get it called
>=20
> 3) Have deferred_probe_work_func iterate over the list and call the clean=
up
> functions once deferred_probe_active_list goes empty. It should also remo=
ve
> them once called, so that they only get called the first time
> deferred_probe_active_list goes empty (iow when the deferred probing of'
> build-in drivers is done).
>=20
> This way cleanup functions actually get run when all probing of (buildin)
> drivers is done.

That sounds like a reasonable solution to me.

> Then when we move simplefb to a 2 fase probe, we can simply register the
> framebuffer at the first probe call, and claim any resources we get, but
> return -eprobe_defer if some resources returned that themselves.
>=20
> Then when simplefb_probe gets re-called, it can first check if it did not
> already register a fb, and if it did, it can use that and see which
> resources are missing, and only try to claim those. If some resources
> still return probe_defer, return eprobe_defer again, otherwise success.

I'm not sure you can check that the fb was already registered. When the
driver probe fails the driver core will pretty much remove any trace of
the driver, so checking for an already-reagistered framebuffer isn't
going to be easy.

But if you can manage to make that work it should give us a pretty good
solution that should be easy to make use of by other drivers as well.

Thierry

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUa2KzAAoJEN0jrNd/PrOhjgMP+wRrkkjDMfyoY7U8b3IHhBGv
t5znFkEo4XVN8IDzHJBj5j8p7kh10EXWzdKM74P8CScoGx36Oy6i9sY8oXJNgl0u
RXYD0pnlQe38nTfY6DA1H9HeKTsebjbf5E8OOaOmy5FCPtRmZkLW3lp6jjmT0j+z
oYS/RRvTLhg4PnLU9pm2TTTynRTUjX+uFes9sMaukylRg6pJ0DeIQwnY9TbNlOgG
fMTzkU6HeEfJplZvNVL63ueYCaqT/53f3jesk94fmkHdUyKsqS5GyA81wPhO0szw
zvfNRT91lKcjph8hokm9UwS8KTglnZlaN83A3TEfgqR4H1xjmPNzbo/s3MBnu8gh
w5hkXJLt1E50vt1b4cYTjPYCrYsN7/sFkUBSHERBVzSlsbQNnSlr5XNT2+xBifC6
j+sAd2xBfigIvhRj1mJ9cHgVk0/kByhzYmo1jxAZkkU74Zytdy/+MgiNRteep2kx
KlAgXxVS2U8uVZsvLwo7cOywrRGlO/D7IzqDCiEaa3jNpWeBzcbQAcTO5N75QRvT
3rZ2UuXyXL0Ph8xPWxv7H7oZz+s1zPKJF5Lm/nOjZYkcyE5SYfkuk8MNxZ/2Z4U7
hqvcwn6RkUCN/HsKWW52GR5uV3Uz3rIVDC91+/7BLQWHOVgKe0Dh9m1vHWRo0xVU
rKeysL47l4PdK5lMXbYz
=lLOx
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
