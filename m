From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 09:37:55 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827093753.GB23186@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <53FD9017.40705@redhat.com>
In-Reply-To: <53FD9017.40705@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 10:00:23AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/27/2014 08:54 AM, Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> >> On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> >>>>>> Any decent enough SoC, with a decent support in the kernel will ha=
ve
> >>>>>> clocks for this, and I really wonder how simplefb will behave once=
 its
> >>>>>> clocks will be turned off...
> >>>>>
> >>>>> There are other devices besides ARM SoCs that may want to use this
> >>>>> driver and that don't have clock support.
> >>>>
> >>>> And in this case, with this patch, simplefb will not claim any clock,
> >>>> nor will fail probing.
> >>>>
> >>>>> But you're missing my point. What I'm saying is that the simplefb d=
river
> >>>>> is meant to serve as a way to take over whatever framebuffer a firm=
ware
> >>>>> set up. Therefore I think it makes the most sense to assume that no=
thing
> >>>>> needs to be controlled in any way since already been set up by firm=
ware.
> >>>>> Eventually there should be a driver that takes over from simplefb t=
hat
> >>>>> knows how to properly handle the device's specifics, but that's not
> >>>>> simplefb.
> >>>>
> >>>> I guess such a hand over if it were to happen in the kernel would
> >>>> involve the second driver claiming the resources before the first one
> >>>> release them. How is that different in this case?
> >>>
> >>> It's different in that that driver will be hardware specific and know
> >>> exactly what clock and other resources are required. It will have a
> >>> device-specific binding.
> >>
> >> Except that you made simplefb a generic driver. So we have two choices
> >> here: either we don't anything but the trivial case, and no one with a
> >> rather more advanced hardware will be able to use it, or we try to
> >> grab any resource that might be of use, which means clocks,
> >> regulators, reserved memory region, or whatever, so that we pretty
> >> much cover all cases. It really is as simple as that.
> >=20
> > No, it should be even simpler. simplefb shouldn't have to know any of
> > this. It's just taking what firmware has set up and uses that. It's a
> > stop-gap solution to provide information on the display until a real
> > driver can be loaded and initializes the display hardware properly.
> >=20
> >>>>> The goal of this patch series is to keep clocks from being turned o=
ff.
> >>>>> But that's not what it does. What it does is turn clocks on to prev=
ent
> >>>>> them from being turned off. In my opinion that's a workaround for a
> >>>>> deficiency in the kernel (and the firmware/kernel interface) and I =
think
> >>>>> it should be fixed at the root. So a much better solution would be =
to
> >>>>> establish a way for firmware to communicate to the kernel that a gi=
ven
> >>>>> resource has been enabled by firmware and shouldn't be disabled. Su=
ch a
> >>>>> solution can be implement for all types of resources and can be reu=
sed
> >>>>> by all drivers since they don't have to worry about these details.
> >>>>
> >>>> Mike Turquette repeatedly said that he was against such a DT propert=
y:
> >>>> https://lkml.org/lkml/2014/5/12/693
> >>>
> >>> Mike says in that email that he's opposing the addition of a property
> >>> for clocks that is the equivalent of regulator-always-on. That's not
> >>> what this is about. If at all it'd be a property to mark a clock that
> >>> should not be disabled by default because it's essential.
> >>
> >> It's just semantic. How is "a clock that should not be disabled by
> >> default because it's essential" not a clock that stays always on?
> >=20
> > Because a clock that should not be disabled by default can be turned off
> > when appropriate. A clock that is always on can't be turned off.
> >=20
> >> Plus, you should read the mail further. It's clearly said that
> >> consumer drivers should call clk_prepare_enable themselves, and that
> >> the only exception to that is the case where we don't have such a
> >> driver (and only valid as a temporary exception, which I guess you'll
> >> soon turn into temporary-until-a-drm-kms-driver-is-merged).
> >=20
> > Exactly. simplefb is only a temporary measure. It's not meant to be used
> > as a full-blown framebuffer driver. There are two use-cases where it is
> > an appropriate solution:
> >=20
> >   1) As a stop-gap solution for when the platform doesn't support a full
> >      display driver yet. In that case you will want simplefb to stay
> >      around forever.
> >=20
> >   2) To get early boot output before a full display driver can be loaded
> >      in which case simplefb should go away after the display driver has
> >      taken over.
> >=20
> > In case of 2) the most straightforward solution is to not disable any
> > clocks until all drivers have had a chance to claim them. When the full
> > driver has been probed it should have claimed the clocks so they would
> > no longer get disabled.
>=20
> Please read my long reply from yesterday evening why this will never
> work, as there is not a well defined moment when "all drivers have had a
> chance to claim them"
>=20
> I've been doing low level Linux development for 10 years now and I've
> worked a lot on storage (raid, iscsi, fcoe support, etc.) in the past.

Ah, so this is now officially a pissing contest, is it?

Thierry

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/abxAAoJEN0jrNd/PrOhkmkP/3F7jJzTDqQBW+LETg2AVBpl
oQcy1DexS0wZfL5O+OuxEJhoy2+tGbQiKrd7rD651M9FRBFa2/r7Y7R9zDfqoZWG
K+vFfM665Tm/ixPWtsRRXQqDrgY8tJ8J9/xN6HI8Lmm9BbfAluj8jHsGgzJjg66K
1yQFpfur1sKZQxIHLPb0ntkH3wii7PmcYlK/8O2nC62LKvZhdtRDnzvb6lzEcF0z
VpEwJ7ZjB2XTtvkre+GLuNUR1XEpw0p2ZpwrRQHwmExeIIipbtEjiS2f/9RwLyDj
RFEpNrrYggua5+reXUgkB89fl0XDt5zvdWiu5EvVKzx7EjyqYMDE4pl1ZGB0M6cG
8iBPUcpv2DwXxHTzokx9nBkS43+bcuXPGwQO6ikXdZdXfq+2RzV4cJ57zgfJjSe9
ZT0dE3Z1J8n9yE/Uxbs7XdeSReyxKkMUHlkT+Y0O21INjxbIKDALrtFIuivoGnfc
pxhmQeoqZOEbBiZOEJn3vlEpDcaBGn7H7ktkpMNoNTdB2eDfsWjEC40dz98jtX8j
jlPts7bPUYjcu5Owp8/ioXEB9ImH4z5E4rHreFeaneMfC9lcAhx4MigJkV/SJ0YB
TFk+bCMd2BKNFmaA/xUaxaCa3xx/b4d9gH76G7ysr6/TjDzq1HXeqZMLYdSgvP5a
Qb9OW78z6VSyyGNySpBC
=vtbs
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
