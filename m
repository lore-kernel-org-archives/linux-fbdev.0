From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 25 Oct 2013 14:10:30 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131025141029.GD1551@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sgneBHv3152wZ8jf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <526999DA.7080409@wwwdotorg.org>
 <20131025081314.GC19622@ulmo.nvidia.com>
 <1394972.QJSGNM8CJk@avalon>
In-Reply-To: <1394972.QJSGNM8CJk@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 03:47:21PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Friday 25 October 2013 10:13:15 Thierry Reding wrote:
> > On Thu, Oct 24, 2013 at 11:06:18PM +0100, Stephen Warren wrote:
> > > On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > > > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> > > >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> > > >> ...
> > > >>=20
> > > >>>> As I said, anything that really needs a CDF binding to work
> > > >>>> likely isn't "simple" anymore, therefore a separate driver can
> > > >>>> easily be justified.
> > > >>>=20
> > > >>> The system as a whole would be more complex, but the panel could =
be
> > > >>> the same. We can't have two drivers for the same piece of hardware
> > > >>> in the DT world, as there will be a single compatible string and =
no
> > > >>> way to choose between the drivers (unlike the board code world th=
at
> > > >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> > > >>> and live happily with that ever after).
> > > >>=20
> > > >> That's not true. We can certainly define two different compatible
> > > >> values for a piece of HW if we have to. We can easily control whet=
her
> > > >> they are handled by the same or different drivers in the OS.
> > > >=20
> > > > From an implementation point of view, sure. But from a conceptual p=
oint
> > > > of view, that would make the DT bindings pretty Linux-specific, wit=
h a
> > > > description of what the operating system should do instead of a
> > > > description of what the hardware looks like. My understanding is th=
at
> > > > we've tried pretty hard in the past not to open that Pandora's box.
> > > >=20
> > > > The case I'm mostly concerned about would be two different compatib=
ility
> > > > strings to select whether the device should be handled by a KMS or =
V4L
> > > > driver. I don't think that's a good idea.
> > >=20
> > > I wouldn't think of the two compatible values as selecting different
> > > specific Linux drivers, but rather they simply describe the HW in
> > > different levels of detail. The fact that if we know a certain level =
of
> > > detail about the HW means that Linux can and does create a KMS driver
> > > rather than a V4L2 driver seems like a detail that's completely hidden
> > > inside the OS.
> >=20
> > I've had a somewhat similar idea the other day but couldn't really put
> > it into words. Interestingly someone else mentioned a similar concept in
> > a different thread which I think describes what I had in mind as well.
> >=20
> > I was wondering if we couldn't use two compatible values to denote two
> > interfaces that the device implements. Something along the lines of:
> >=20
> > 	compatible =3D "vendor,block-name", "encoder";
> >=20
> > So a driver could primarily match on "vendor,block-name", but at the
> > same time it could use the additional information of being required to
> > implement "encoder" to expose an additonal interface.
>=20
> Let's take the hardware architecture described in
> http://www.ideasonboard.org/media/meetings/20131024-elce.pdf#39 (page 39)=
 as=20
> an example. The green blocks are part of the capture pipeline and handled=
 by=20
> the V4L subsystem. The blue blocks are part of the display pipeline and=
=20
> handled by the KMS subsystem. One ADV7511 HDMI transmitter instance need =
to be=20
> controlled by a KMS driver and the second one by a V4L driver.=20
>=20
> The two instances are identical, so their DT nodes will show no differenc=
e if=20
> we stick to a hardware description only. There would then be no way to bi=
nd to=20
> different drivers.

I don't quite see why some of the green parts couldn't be part of the
display (KMS) pipeline. I thought I remember you say something about
implementing deep pipelining support in one of the more recent talks.
This sounds exactly like a case where this would be useful.

Obviously as long as that work isn't finished that won't help you, but I
think that providing a way to pass a video stream object from V4L2 to
DRM/KMS would be a more proper solution to this problem.

> > I suppose that perhaps something like a device_type property could be
> > used for that as well, and that might even be the more correct thing to
> > do.
> >=20
> > We already do something similar to make GPIO controllers expose an
> > interrupt chip by adding an interrupt-controller property. We also use
> > the gpio-controller property to mark a device node as exposing the GPIO
> > interface for that matter.
> >
> > So if a HW block can actually implement two different interfaces, each
> > of them being optional, then there should be ways to represent that in
> > DT as well. We already do that for "simpler" HW blocks, so there's no
> > reason we shouldn't be able to do the same with multimedia components.
> >=20
> > If it's really an encoder, though, the problem might be different,
> > though, since the interface (at a hardware or functional level if you
> > will) remains the same. But I think in that case it's something that
> > needs to be figured out internally by the OS. In my opinion, if we are
> > in a situation where we have two different drivers in two subsystems for
> > the same device, then we're doing something wrong and it should be fixed
> > at that level, not by quirking the DT into making a decision for us.
>=20
> I tend to agree, and I'd like to be able to share drivers between V4L and=
 KMS.=20
> This is way down the road though.

My point is that I don't see a need for sharing the drivers if we can
make both V4L2 and DRM/KMS interoperate well enough to cover such use
cases.

Why share the drivers if we can make it work by sharing the data?

Thierry

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSanvVAAoJEN0jrNd/PrOhrSIP/2cjfk2Q242ogFvdRFNf+wYV
ua4RGkfLrWlF5V0dqJDg0fiEVIzaL/vIaZ9e9jsogzyKp+4MK+BH/WijbczAVXad
9KrtgVzHS1JupFpaCWjmptYqfmqvuEJIUm+YrtqkxSXOQS/gYKouEn5GXQo6KV9v
/WOLgn16hjUOIA91N00SU3pAk1OuxaRM3SH4sGVhscp9T+7EJbDwuOesUrAv8nta
ewWrJmn8YG1T+V8tmZNNcLDIJJRHbAUCfpIrpLNYSgW8uompTXpddGQDOX8vLVug
h5aluvribvrR+Syo5jq0N4Dj8/6Icb4ozkDbZ+a4sLerDI4s3l1h3P6IbXJNe6E1
WyeNEAhkoBf/zotKiUZm/cHE1Yea8WvdCHQQ/SK9boSkdCSpqH+JzEAfqbvV6e3g
rJFJ9bY08lUrjKIUEzOXNTTIdWd2XE5OXrbDzAO1JnT+pHAK6bzfDT93yLKcbX00
R6A3EJskctKs/1nozBa0+kYe32Z60aQBD6yrHb9DaA2MwByhXaBfZat3AuKSiuPZ
zTqCn8on7PtWQLiERXmi6ukcZ1cjX4l9CpbVijh9+WqwLubOlkUjIgl5z/Y3ob2x
qOzpLDXYPQGKDGWV9Y+Z9dnyLNcm9/WxG6aZsXKKBlSt9okdhfCS6IyieKEPUIxq
io5SpxgrljQdgTP/eQ41
=2Bcq
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
