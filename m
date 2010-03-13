From: James Simmons <jsimmons@infradead.org>
Date: Sat, 13 Mar 2010 14:40:10 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003131421360.12031@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-1112399426-1268491210=:12031"
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
	<alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
	<21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
In-Reply-To: <21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-1112399426-1268491210=:12031
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> >> Can't it print the oops on whatever is currently displayed?
> >>
> >> It need not be a dedicated buffer as long as there is always some buff=
er.
> >>
> >> But perhaps this is more complex than that.
> >
> > =A0 =A0 =A0 =A0Yes it is very complex. Reading the code and drm specs y=
ou come to
> > realize buffer handling is done with GEM, TTM, or for older drivers drm=
_maps.
> > Drivers often handle a combine of those, meaning no real wrapper from o=
ne
> > api to another :-( From the code it appears GEM is the main userland in=
terface
> > when using KMS. Some how TTM is also usable from userland but I never f=
ound a
> > clear example of how that is done. So to the average userland app write=
r it is
> > a mystery. As for hardware that has a static front buffer I can see how=
 to
> > use drm_maps or TTM but I don't see a easy way to map it to the GEM api.
> > Also their exist ioctl for gem but it appears no one actually uses them
> > but instead write their own :-( So you can see the confusion here.
>=20
> Userspace buffer management interfaces are pre-driver, the only requireme=
nt
> if that they have a 32-bit handle to identify buffers uniquely. Pre-KMS d=
rivers
> don't exist for the purposes of fb interaction, so drm_maps are ignorable=
 from
> that pov.

=20
> > =A0 =A0 =A0 =A0Outside of what I described above the drm_framebuffer ha=
ndling is
> > a mess. From what I can see with the code you can only create a
> > drm_framebuffer with the GEM api. With this case the two most important
> > functions to provide are
>=20
> This isn't correct. You get a drm_file and a handle, the driver then uses
> these to do whatever it wants to do. This means lookup a GEM object or
> whatever but there is no reliance on GEM or any other memory manager
> outside the driver. Again a handle a file priv are in no way GEM specific.

Searching the TTM code I couldn't find the handle code so easily. I see=20
that the vmwgfx driver provides a example of using ttm.
=20
> > =A0 =A0 =A0 =A0This gets me to point of where to go from here. We have =
two choices.
> > The first being we could just make the drm_framebuffer code totally gem
> > dependent thus we could cleanup the drivers code up by moving gem code
> > there. The second option is to make the drm_framebuffer code agnostic t=
o the gem
> > layer. So I have been pondering on how to make the second option work.
> > There is one thing that all these layers do share in common. That is th=
ey
> > have some sort of drm_hash with a object lookup. Still pondering how th=
at
> > would be done.
>=20
> I'm not sure either of these makes sense, can you clearly state the
> goal and maybe we can work out what you need.

Sorry I should of stated what I was planing to do. I like to see drmfb=20
have the ablitiy to change the resolution via fbset. To do that we need to =

be able to create and destory the framebuffer memory if the memory doesn't =

fit the size of the new resolution. Plus it gives us the bonus of being=20
able to unpin the memory when the VT is in KD_GRAPHICS mode. The problem=20
is that the functions like fb_create are tied to a handle which is not=20
present for the internal framebuffer used by fbdev. Sorry for the junk=20
above. It just took me awhile to figure out the code. Their is steep=20
learning curve. I have patches that should address this coming soon.


--1985284609-1112399426-1268491210=:12031
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--1985284609-1112399426-1268491210=:12031
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--1985284609-1112399426-1268491210=:12031--
