From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 25 Oct 2013 08:13:15 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131025081314.GC19622@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t0UkRYy7tHLRMCai"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <3592147.9IprvsogX6@avalon>
 <52645428.9080607@wwwdotorg.org>
 <3278905.VOXO7bPE7e@avalon>
 <526999DA.7080409@wwwdotorg.org>
In-Reply-To: <526999DA.7080409-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 11:06:18PM +0100, Stephen Warren wrote:
> On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > Hi Stephen,
> >=20
> > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> >> ...
> >>
> >>>> As I said, anything that really needs a CDF binding to work
> >>>> likely isn't "simple" anymore, therefore a separate driver can
> >>>> easily be justified.
> >>>
> >>> The system as a whole would be more complex, but the panel could be
> >>> the same. We can't have two drivers for the same piece of hardware
> >>> in the DT world, as there will be a single compatible string and no
> >>> way to choose between the drivers (unlike the board code world that
> >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> >>> and live happily with that ever after).
> >>
> >> That's not true. We can certainly define two different compatible
> >> values for a piece of HW if we have to. We can easily control whether
> >> they are handled by the same or different drivers in the OS.
> >=20
> > From an implementation point of view, sure. But from a conceptual point=
 of=20
> > view, that would make the DT bindings pretty Linux-specific, with a=20
> > description of what the operating system should do instead of a descrip=
tion of=20
> > what the hardware looks like. My understanding is that we've tried pret=
ty hard=20
> > in the past not to open that Pandora's box.
> >=20
> > The case I'm mostly concerned about would be two different compatibilit=
y=20
> > strings to select whether the device should be handled by a KMS or V4L =
driver.=20
> > I don't think that's a good idea.
>=20
> I wouldn't think of the two compatible values as selecting different
> specific Linux drivers, but rather they simply describe the HW in
> different levels of detail. The fact that if we know a certain level of
> detail about the HW means that Linux can and does create a KMS driver
> rather than a V4L2 driver seems like a detail that's completely hidden
> inside the OS.

I've had a somewhat similar idea the other day but couldn't really put
it into words. Interestingly someone else mentioned a similar concept in
a different thread which I think describes what I had in mind as well.

I was wondering if we couldn't use two compatible values to denote two
interfaces that the device implements. Something along the lines of:

	compatible =3D "vendor,block-name", "encoder";

So a driver could primarily match on "vendor,block-name", but at the
same time it could use the additional information of being required to
implement "encoder" to expose an additonal interface.

I suppose that perhaps something like a device_type property could be
used for that as well, and that might even be the more correct thing to
do.

We already do something similar to make GPIO controllers expose an
interrupt chip by adding an interrupt-controller property. We also use
the gpio-controller property to mark a device node as exposing the GPIO
interface for that matter.

So if a HW block can actually implement two different interfaces, each
of them being optional, then there should be ways to represent that in
DT as well. We already do that for "simpler" HW blocks, so there's no
reason we shouldn't be able to do the same with multimedia components.

If it's really an encoder, though, the problem might be different,
though, since the interface (at a hardware or functional level if you
will) remains the same. But I think in that case it's something that
needs to be figured out internally by the OS. In my opinion, if we are
in a situation where we have two different drivers in two subsystems for
the same device, then we're doing something wrong and it should be fixed
at that level, not by quirking the DT into making a decision for us.

Thierry

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaigaAAoJEN0jrNd/PrOhQfUP/1s0MryLuhGMkCFDYmnScFy3
2sQoTRaBvhF8v5N9IhJFAM447H/x+A/r6r39oGYgonT/6WL+eVcJ9WSrQb/TAwXQ
ytfA9FaN1XCzpPkNXEDPwWjc6Cqc5xhd1McLAhWcMeTfdiJT20ETXzDCLlSFFbia
gDOJyoYqxtNBhsZ6DXyEVAh8wkA8fEqkj+Ejpkv7bKhypXww2seA56C90sSXBwaN
R/zgl9bQkgfuNGeXgOq1MCAYcPAf/J9jM9RFfbs0Au3ujG3Nij6l1dgoRWwbPVy6
usngC2jsqS/bE2PigN2oPqpFO0ns+C6iHYSh/CGA60UYM8uaRzSRIBZipTAtoQM8
wJ7WHSNFcg6Ib870zM7RaBNIL4Gn01R+G8f4W+0I0G1XAdnugLqQOwQW75zpA11P
EVribcjXZ+ysnhHMMhUFoXNKa9Oh85TbpXFu0r5wj4tv0pwUqgPj/nmJ3EwIquJI
SncM6VlffBM+Mu1LxVvyQ+xEitddUO7LDL0B+OkEvX1L68lUWBiaqWfzAFko8rgz
J8exJs9NISqgQAdcFHmeuBhz/5zjYttonZLAq8UitE/aRc8UXM5cdlRXo9xWJfWL
8y7O1ivvfXxgsfBppoZWvpA6VJ5M6StFrfAcJa700eA76fsOb2VdjaicyGlJAnYS
zbWa22j2m9eH74GqW+ui
=Afnu
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
