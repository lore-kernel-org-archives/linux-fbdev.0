From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 18 Nov 2014 15:28:47 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <20141118152847.GG6414@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5CFHAhYDCN3kIKuu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather>
 <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
 <20141118101911.GA15769@ulmo> <546B26F4.50302@redhat.com>
 <20141118112123.GA3873@ulmo> <546B31A7.9020804@redhat.com>
 <546B3F3C.6050202@redhat.com> <20141118151603.GA19426@ulmo>
In-Reply-To: <20141118151603.GA19426@ulmo>
To: linux-arm-kernel@lists.infradead.org


--5CFHAhYDCN3kIKuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 04:16:04PM +0100, Thierry Reding wrote:
> On Tue, Nov 18, 2014 at 01:44:44PM +0100, Hans de Goede wrote:
> > Hi,
> >=20
> > On 11/18/2014 12:46 PM, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > On 11/18/2014 12:21 PM, Thierry Reding wrote:
> > >> On Tue, Nov 18, 2014 at 12:01:08PM +0100, Hans de Goede wrote:
> > >>> Hi,
> > >>>
> > >>> On 11/18/2014 11:19 AM, Thierry Reding wrote:
> > >>>> On Thu, Nov 13, 2014 at 09:58:41AM +0100, Geert Uytterhoeven wrote:
> > >>>>> Hi Maxime,
> > >>>>>
> > >>>>> On Thu, Nov 13, 2014 at 9:52 AM, Maxime Ripard
> > >>>>> <maxime.ripard@free-electrons.com> wrote:
> > >>>>>>> -module_init(simplefb_init);
> > >>>>>>> +/*
> > >>>>>>> + * While this can be a module, if builtin it's most likely the=
 console
> > >>>>>>> + * So let's leave module_exit but move module_init to an earli=
er place
> > >>>>>>> + */
> > >>>>>>
> > >>>>>> Not really related to this patch itself, but do we want to suppo=
rt
> > >>>>>> simplefb as a module? It seems like it's going to be most of the=
 time
> > >>>>>> broken.
> > >>>>>
> > >>>>> If it depends on clocks, it won't work as a module, as CCF will h=
ave disabled
> > >>>>> all unused clocks at that point.
> > >>>>
> > >>>> If it does depend on anything beyond clocks it won't work at all. =
Clocks
> > >>>> are special because they get set up very early at boot time. If it=
 turns
> > >>>> out that a simplefb ever needs a regulator to remain on, and that'=
s even
> > >>>> quite likely to happen eventually, it's going to fail miserably, b=
ecause
> > >>>> those regulators will typically be provided by a PMIC on an I2C bu=
s. The
> > >>>> regulator won't be registered until very late into the boot proces=
s and
> > >>>> a regulator_get() call will almost certainly cause the simplefb dr=
iver
> > >>>> to defer probing.
> > >>>
> > >>> Right, this has been discussed already and the plan is to have simp=
lefb
> > >>> continue its probe function and return success from it if it encoun=
ters
> > >>> any -eprobe_defer errors, while tracking which resources it misses.
> > >>>
> > >>> And then have a late_initcall which will claim any resources which =
failed
> > >>> with -eprobe beforehand.
> > >>
> > >> How do you ensure that the late_initcall gets run before any of the
> > >> other late_initcalls that disable the resources?
> > >=20
> > >> Also my recollection is
> > >> that deferred probing will first be triggered the first time from a
> > >> late_initcall, so chances aren't very high that all resources have s=
hown
> > >> up by that time.
> > >=20
> > > So I just looked up the relevant code, and your right, this means that
> > > the whole model of "disable unused resources once probing is done" wh=
ich
> > > we use for e.g. clocks, is already somewhat broken since there is
> > > no guarantee probing is really done when the cleanup code runs.
> > >=20
> > >>>> Now deferring probing is a real showstopper for simplefb, because =
not
> > >>>> only does it make the framebuffer useless as early boot console, o=
nce
> > >>>> probing is attempted again the clocks that it would have needed to
> > >>>> acquire to keep going will already have been switched off, too.
> > >>>
> > >>> That is not true, even with the current implementation, if all nece=
ssary
> > >>> drivers are built in, then simplefb will come up later, but it will=
 still
> > >>> come up before the late_initcall which disables the clocks.
> > >>
> > >> Yes, in the current implementation because clocks typically are
> > >> registered very early and thus you don't hit the deferred probe. The
> > >> same is not true for other types of resources where it's actually qu=
ite
> > >> common to hit deferred probing (regulators is a very notorious one).
> > >>
> > >> It doesn't matter whether a driver is built-in or not, once you hit
> > >> deferred probing you lose.
> > >>
> > >>> Once we do the split probing described above (which is something wh=
ich
> > >>> we plan to do when it becomes necessary), then simplefb will still =
come
> > >>> up early.
> > >>
> > >> It will come up early but won't have acquired all the resources that=
 it
> > >> needs, so unless you somehow manage to order late_initcalls in exact=
ly
> > >> the way that you need them, the frameworks will still turn off what =
you
> > >> haven't managed to claim yet.
> > >=20
> > > If it is a resource which only shows up as a result of deferred probi=
ng,
> > > then it may very well not have been probed & registered yet, when the
> > > framework cleanup functions runs, and thus will not get turned off...
> > >=20
> > > So yes you're right that deferred probing may cause issues, but it se=
ems
> > > that this is not something simplefb specific, but rather a generic pr=
oblem
> > > with deferred-probing vs subsys cleanup functions.
> > >=20
> > > My view on this is simple, lets worry about this when we actually have
> > > a board which hits these issues, and then we'll see from there.
> >=20
> > So thinking more about this, I think this is not that hard to fix.
> >=20
> > First lets fix the generic conflict between eprobedefer and subsys clea=
nup
> > functions. This can be done by:
> >=20
> > 1) Having a linked list of subsys cleanup functions
> > to call in drivers/base/dd.c
> >=20
> > 2) Have subsystems register their cleanup function rather then using
> > late_initcall to get it called
> >=20
> > 3) Have deferred_probe_work_func iterate over the list and call the cle=
anup
> > functions once deferred_probe_active_list goes empty. It should also re=
move
> > them once called, so that they only get called the first time
> > deferred_probe_active_list goes empty (iow when the deferred probing of'
> > build-in drivers is done).
> >=20
> > This way cleanup functions actually get run when all probing of (buildi=
n)
> > drivers is done.
>=20
> That sounds like a reasonable solution to me.
>=20
> > Then when we move simplefb to a 2 fase probe, we can simply register the
> > framebuffer at the first probe call, and claim any resources we get, but
> > return -eprobe_defer if some resources returned that themselves.
> >=20
> > Then when simplefb_probe gets re-called, it can first check if it did n=
ot
> > already register a fb, and if it did, it can use that and see which
> > resources are missing, and only try to claim those. If some resources
> > still return probe_defer, return eprobe_defer again, otherwise success.
>=20
> I'm not sure you can check that the fb was already registered. When the
> driver probe fails the driver core will pretty much remove any trace of
> the driver, so checking for an already-reagistered framebuffer isn't
> going to be easy.
>=20
> But if you can manage to make that work it should give us a pretty good
> solution that should be easy to make use of by other drivers as well.

What about handling priorities in the suggested cleanup mechanism, and
just add the second phase as the highest priority cleanup callback?

That way, we would be guaranteed to be run just before any cleanup
function.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5CFHAhYDCN3kIKuu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2WvAAoJEBx+YmzsjxAg7qsP/jjPfadrmddYvBsZelnogqnA
g1LDCW7/ArBVDvlk8Yk0WRxzP7pWw0oHSyGJ6USbWYzeldkytfN3hN+or7IqFPOL
DR/hzG3PQD75IwBPhjargt71V+//bku6dKLzaudyzhe5qCEHHZ283cMcwOH7CtPl
Rs7GBF/PvtAUqMvQrRAMSD60w1t8+WRKDgcHNxeFOE0R3/6adrYBrph1MbCOExwx
HW3dVoo+LamnpgNxv8VJAeDLPIfoPBPOkkM5UKKVWvA1CfZQ/L8dcS7/e62AARZH
us0G56Nqdo3yfrVo2kp/Xa+O2YzPLUhthXdiHtVw6sCRH31XM0sLp79YfggKdxj+
A07aDCYwNYJy+/0LBoo2pjWAEBwBMVf+Z0ElD0FgVTLjpkugEoHFCouBjgIhZIFd
GBqWkKBExBEnMXo/ZjIxWUQVeXnPrv4df0cEudmmZI/uoUMKmGBDGE+TFPrR/+XO
VIEDGF3nmbvKr7MUEvVvTNwieGYjkxde1XF67EnV3w+xP360FP/y+zryqyCqnFWr
eLmWL13tp9OH578iWGsaihsSc+NA7kD80LEdz05y67U7Kv1wYQQybf91+e42dnQn
u3lQgad3gP+lGWEoyeCTK4LUvxpNEXeG+5rkf2LjDoEM4yBhLpmf5/yGwwKXYWZS
H2eES3Oj8Xo1OVRP/2iq
=tgQy
-----END PGP SIGNATURE-----

--5CFHAhYDCN3kIKuu--
