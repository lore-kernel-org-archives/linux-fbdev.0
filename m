From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 15:01:00 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825150034.GD14763@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AbQceqfdZEv+FvjW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
In-Reply-To: <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 10:23:26AM -0400, jonsmirl@gmail.com wrote:
> On Mon, Aug 25, 2014 at 10:16 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> >> On 08/25/2014 03:39 PM, Thierry Reding wrote:
> >> > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >> >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >> >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >> >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >> >>> [...]
> >> >>>>> If not, perhaps the clock driver should force the clock to be
> >> >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >> >>>>
> >> >>>> I'm sorry, but I'm not going to take any code that will do that i=
n our
> >> >>>> clock driver.
> >> >>>>
> >> >>>> I'm not going to have a huge list of ifdef depending on configura=
tion
> >> >>>> options to know which clock to enable, especially when clk_get sh=
ould
> >> >>>> have the consumer device as an argument.
> >> >>>
> >> >>> Are you saying is that you want to solve a platform-specific probl=
em by
> >> >>> pushing code into simple, generic drivers so that your platform co=
de can
> >> >>> stay "clean"?
> >> >>
> >> >> Are you saying that this driver would become "dirty" with such a pa=
tch?
> >> >
> >> > Yes. Others have said the same and even provided alternative solutio=
ns
> >> > on how to solve what's seemingly a platform-specific problem in a
> >> > platform-specific way.
> >>
> >> This is not platform specific, any platform with a complete clock driv=
er
> >> will suffer from the same problem (the clock driver disabling unclaimed
> >> ahb gates, and thus killing the video output) if it wants to use simpl=
efb
> >> for early console support.
> >
> > It is platform specific in that your platform may require certain clocks
> > to remain on. The next platform may require power domains to remain on
> > during boot and yet another one may rely on regulators to stay on during
> > boot. By your argument simplefb will need to be taught to handle pretty
> > much every type of resource that the kernel has.
>=20
> Why can't simplefb be a driver library that is called from a device
> specific device driver that only claims the clocks (or regulators)?
> Then build all of these device specific drivers into the generic ARM
> kernel. They will be quite small since all they do is claim the clocks
> (or regulator).  Maybe we can even figure out some protocol for
> removing the unused ones from memory later.
>=20
> Later during the boot process the device specific driver can load its
> KMS code which has also been implemented as a driver library. Maybe
> use E_PROBE_DEFER to do this. Match on the device ID, claim the
> clocks, defer until the full KMS library can be loaded.

That sounds like the most scalable solution so far. On the other hand,
as I understand it, the simplefb driver was designed to take over the
framebuffer set up by firmware, so it's somewhat odd that the driver
would have to deal with resources in the first place. If we push the
resource problem into the respective subsystems we keep the simplefb
driver completely hardware agnostic.

And we'll also be solving this problem for other types of drivers at the
same time. Firmware may after all initialize clocks and other resources
for other types of devices too. Handling resources in the drivers would
therefore imply that every driver needs to cope with this.

Thierry

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+0+SAAoJEN0jrNd/PrOhE70P/ijoUjI/V8eqSXtHDAjcNXr7
earbOFgoekuiZ23jJDXymxK93QzlDyANWb9jOJDs2W0uZy3lWQwisLoV7qeav3qj
81quJYVWGiac7BdO5AbPH0b1XjqCx8bBN5vMw9aT9KKzNAM0oCe0Dois3uo07h4J
wUX8leF8bw8lwlnlHu+43LlbPx979yZBqgnDACdTzdWYicurURfc6n4Y3OmsFISy
JinSA6pBrZ9x4z6A3b/xJp4adBy4Hxdo7irvgchiZC6/Iy/2tj3LJdqKCICh3BEq
1Ip89V0Buk5YVdt9Yv7jE43Heak1zgPMG+oLIi57XujwIa4L0Kmv2MUdqpQTlPuV
jlznqpJrPDBaf9QPXBD5JD2wOB2zpyGhRLkrbNkpM9OCs3BicvIlIkR+atI+GGzM
v/A3j+9YpdyAQMml1+XK78Hg+Lzg7sz1dtnsfs8oahTu7I8dZwDxWqLXZeHE9RxT
FChvGAzZgns3CBvU41ROz0FpgNvhU5FPLsZKKIk6n0G+tjHDTKqlVHBWC3r6ovDa
pPyDdfU0pbcqMmmVu8qqivmVV/SStU3DGELgHhOoski/G8hOB7uVLvTp2Cpz5x3S
QINnDYoudRliChoBAZ5D03mFe76ZNJLo+/Sorq49T9hnc/TLqN7jDt/WJQKgDiqL
z/MUikikjFPGjzaEHRqc
=y/ct
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
