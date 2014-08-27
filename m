From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 09:31:24 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827093121.GA23186@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com>
In-Reply-To: <53FCE704.4030103@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Can you please fix you mail setup. You're addressing me directly in this
email, yet I'm neither in To: nor Cc: headers. That's really annoying.

On Tue, Aug 26, 2014 at 09:59:00PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/26/2014 04:35 PM, Thierry Reding wrote:
> >On Tue, Aug 26, 2014 at 03:53:41PM +0200, Maxime Ripard wrote:
> >>On Tue, Aug 26, 2014 at 10:04:33AM +0200, Thierry Reding wrote:
> >>>>>No. simplefb just wants to write to some memory that hardware has be=
en
> >>>>>set up to scan out. The platform requires that the clocks be on. Oth=
er
> >>>>>platforms may not even allow turning off the clocks.
> >>>>
> >>>>Like what? the rpi? Come on. Just because the videocore is some black
> >>>>box we know nothing about doesn't mean we should use it as an example.
> >>>
> >>>You make it sound like the Raspberry Pi is somehow less important than
> >>>sunxi.
> >>
> >>No. What I mean is that it seems like we are somehow punished, or at
> >>least blamed, for having a better and more complete kernel support.
> >
> >This isn't a competition. Nobody's punishing or blaming anyone. This is
> >about finding the best solution for the problem at hand.
> >
> >>>>Any decent enough SoC, with a decent support in the kernel will have
> >>>>clocks for this, and I really wonder how simplefb will behave once its
> >>>>clocks will be turned off...
> >>>
> >>>There are other devices besides ARM SoCs that may want to use this
> >>>driver and that don't have clock support.
> >>
> >>And in this case, with this patch, simplefb will not claim any clock,
> >>nor will fail probing.
> >>
> >>>But you're missing my point. What I'm saying is that the simplefb driv=
er
> >>>is meant to serve as a way to take over whatever framebuffer a firmware
> >>>set up. Therefore I think it makes the most sense to assume that nothi=
ng
> >>>needs to be controlled in any way since already been set up by firmwar=
e.
> >>>Eventually there should be a driver that takes over from simplefb that
> >>>knows how to properly handle the device's specifics, but that's not
> >>>simplefb.
> >>
> >>I guess such a hand over if it were to happen in the kernel would
> >>involve the second driver claiming the resources before the first one
> >>release them. How is that different in this case?
> >
> >It's different in that that driver will be hardware specific and know
> >exactly what clock and other resources are required. It will have a
> >device-specific binding.
> >
> >>>The goal of this patch series is to keep clocks from being turned off.
> >>>But that's not what it does. What it does is turn clocks on to prevent
> >>>them from being turned off. In my opinion that's a workaround for a
> >>>deficiency in the kernel (and the firmware/kernel interface) and I thi=
nk
> >>>it should be fixed at the root. So a much better solution would be to
> >>>establish a way for firmware to communicate to the kernel that a given
> >>>resource has been enabled by firmware and shouldn't be disabled. Such a
> >>>solution can be implement for all types of resources and can be reused
> >>>by all drivers since they don't have to worry about these details.
> >>
> >>Mike Turquette repeatedly said that he was against such a DT property:
> >>https://lkml.org/lkml/2014/5/12/693
> >
> >Mike says in that email that he's opposing the addition of a property
> >for clocks that is the equivalent of regulator-always-on. That's not
> >what this is about. If at all it'd be a property to mark a clock that
> >should not be disabled by default because it's essential.
> >
> >Adding Mike on this subthread too.
> >
> >Either way, Mark already suggested a different alternative in another
> >subthread, namely to add a new kind of checkpoint at which subsystems
> >can call a "disable unused" function that's called later than a late
> >initcall. This is not going to fix things for you immediately because
> >the clocks will still be switched off (only later) if you don't have
> >a real driver that's claiming the clocks. But you can work around that
> >for now by making the relevant clocks always on and remove that
> >workaround once a real driver is loaded that knows how to handle them
> >properly.
>=20
> This will simply not work, and is a ton more complicated then
> simply teaching simplefb about a clocks property, which is a really simple
> and clean patch.
>=20
> First of all let me explain why this won't work. When should those
> subsystems call this "later then a late initcall" call ? the kms driver
> may very well be a kernel module, which will be loaded by userspace,
> so we would need this to be triggered by userspace, but when ?
>=20
> When the initrd is done? What then if the kms driver is not in the initrd,
> so maybe when udev is done enumerating devices, but what then if the kern=
el
> is still enumerating hardware at this time?

Usually an initrd knows how to wait for all or a given set of devices to
be probed. udev is pretty good for that.

> Will we just put a sleep 30
> in our initscripts to make sure the kernel is done scanning all busses,
> will that be long enough? Maybe we need to re-introduce the scsi_wait_done
> kernel module which was added as an ugly hack to allow userspace to wait
> for the kernel to have finished scanning scsi (and ata / sata) busses,
> for controllers found at the time the module was load. Which never worked
> reliable, because it would be possible that the controller itself still
> needed to be discovered. We've spend years cleaning up userspace enough
> to be able to kill scsi_wait_done. We've already been down this road of
> waiting for hw enumeration to be done, and the problem is that on
> modern systems *it is never done*.

Those are mostly integration issues. If you don't load the driver from
initrd then I don't think anybody will complain when there's flicker
when it finally gets loaded. The whole point of this is to have early
access to the framebuffer and get display and graphics going as soon as
possible, so please don't pull in hypothetical scenarios where people
manually load drivers half an hour after the system has booted.

> So second of all, Thierry, what exactly is the technical argument against
> adding support for dealing with clocks to simplefb ?

I've already stated technical arguments against it. You could just go
back and read the thread again, or would you rather want me to repeat
them for your convenience?

> I've heard a lot of people in favor of it,

Of course you have, all the people in favour of it are sunxi people that
really want to see this merged because it gives them working display
after U-Boot.

> and only pretty much you against it,

At least Stephen also spoke out about it. But this quickly devolved into
the kind of thread you want to get out of as quickly as possible, so I
can't blame him for not continuing this discussion. In fact I'm very
much regretting getting into this in the first place. You clearly have
no intention to even consider any possible other solution that what was
posted, so it's pretty useless to try and convince you.

> and your argument so far seems to boil down to "I don't like it",

I'm not surprised that you think so since you seem to be very selective
in what you read (or register) and what you don't.

> is not really a technical sound argument IMHO. Moreover all the
> alternatives seem to be horribly complicated and most of them also
> seem to have several issues which will make them simply not work
> reliable.

I'm not an unreasonable person, or at least I like to think so, and if
there really isn't a better solution then I won't object to this patch
any longer. But as it stands I am not convinced that this is the best
solution, so I think we should keep the discussion going for a bit and
see if we really can't come up with something that will fix this for a
more general case rather than just your particular use-case. It's
evidently a recurring problem that others suffer from, too.

Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/aVpAAoJEN0jrNd/PrOhi1gP/AlTOye+kPFiKWNf/hfZDnx5
LwZXlGHFXm+bNbEUnK0FLKCI2ZosgO8dYkcC8whMBJPH1K8B64bcv6bioDvy0zL9
OE5J6xu7AFQczBP9eW/P/UYNfedTFBg4+eF4xQwhBYQ0eCgyHKkr9a+DawTHjfQ/
Xh8EbZ0Nrsi6D5XXyhVn99I9iq5cQWZYv/RzL+u2/mC3ta7++1R+iEDSCg/mjWVg
/Pb6NHK1unpm8Z6D8wtWVAQF1ke8nvbD/VQ+9LpA9Gl3JKy96E3bjea21Gd7hgJj
P3m9lPb3hV9VmD5NWDEu+CMUKxXvP4I79kF6V9sWpxyLgonogAMbfF5a7/OLaWp6
MUBRCtv871l60vfhbNRpjF0dzqmWuJvv6oYWbK60mYt5qqdSKoMYbIg/5QSu/6r5
NsDwvhjJCfQmLpVkXTOf9BqR11T1DibW+eQ1YcIuyRswpI0vbMMjgwRRVfVC0AQ6
xvWj3AmDgTrTjSB4NCXLe/V0c6639LojeEtssN8rNopzaEWeSc/Sq1VmzmUHZXjU
/vhTcumLE8svQVXjDRVwAfMMsCw1DxvhgMo8kvY6i95rc4LvIE+1PCVsbUmnWuPJ
78XA9U7kO7LSlBE1dp8UP8a6Bd9oKOTcmDaazko5VJVc8eONCV7aog9v4tXfwwve
W6YxT6EeoAAbLJZa36K/
=Dot8
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
