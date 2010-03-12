From: James Simmons <jsimmons@infradead.org>
Date: Fri, 12 Mar 2010 14:52:28 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-99332911-1268400807=:10546"
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
In-Reply-To: <a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Alex Deucher <alexdeucher@gmail.com>, =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-99332911-1268400807=:10546
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.LFD.2.00.1003121333391.10546@casper.infradead.org>


On Thu, 11 Mar 2010, Michal Suchanek wrote:

> On 11 March 2010 16:17, James Simmons <jsimmons@infradead.org> wrote:
> >
> >> >> It would be nice to find a way to reclaim the console memory for X,
> >> >> but I'm not sure that can be done and still provide a good way to
> >> >> provide oops support.
> >> >
> >> > What do you think the average user will care about more?
> >> >
> >> > =A0 =A0 =A0* Seeing kernel oops/panic output about once in a lifetim=
e.
> >> > =A0 =A0 =A0* Being able to start/use X in the first place and enabli=
ng it to
> >> > =A0 =A0 =A0 =A0use all of VRAM.
> >> >
> >> > Personally, I've never even seen any kernel oops/panic output despite
> >> > numerous opportunities for that in the couple of months I've been us=
ing
> >> > KMS. But I have spent considerable time and effort trying to get rid=
 of
> >> > the pinned fbcon BO. If the oops/panic output is the only thing
> >> > preventing that, maybe that should only be enabled via some module
> >> > option for developers.
> >>
> >> I'm all for it!
> >
> > I'm looking into the details for this. It will require some changes to
> > internal apis to make it to work.
> >
>=20
> Can't it print the oops on whatever is currently displayed?
>=20
> It need not be a dedicated buffer as long as there is always some buffer.
>=20
> But perhaps this is more complex than that.

	Yes it is very complex. Reading the code and drm specs you come to
realize buffer handling is done with GEM, TTM, or for older drivers drm_map=
s.
Drivers often handle a combine of those, meaning no real wrapper from one=20
api to another :-( From the code it appears GEM is the main userland interf=
ace
when using KMS. Some how TTM is also usable from userland but I never found=
 a
clear example of how that is done. So to the average userland app writer it=
 is
a mystery. As for hardware that has a static front buffer I can see how to =

use drm_maps or TTM but I don't see a easy way to map it to the GEM api.=20
Also their exist ioctl for gem but it appears no one actually uses them=20
but instead write their own :-( So you can see the confusion here.=20
	Outside of what I described above the drm_framebuffer handling is=20
a mess. From what I can see with the code you can only create a=20
drm_framebuffer with the GEM api. With this case the two most important=20
functions to provide are

dev->mode_config.funcs->fb_create(dev, file_priv, r)

and

fb->funcs->create_handle(fb, file_priv, &r->handle);

As you can see if the functions they depend on a handle and a drm_file. To =

make it possible to create a framebuffer internally using a common code we =

would remove those requirements.=20
	This gets me to point of where to go from here. We have two choices.
The first being we could just make the drm_framebuffer code totally gem=20
dependent thus we could cleanup the drivers code up by moving gem code=20
there. The second option is to make the drm_framebuffer code agnostic to th=
e gem=20
layer. So I have been pondering on how to make the second option work.=20
There is one thing that all these layers do share in common. That is they=20
have some sort of drm_hash with a object lookup. Still pondering how that=20
would be done.
--1985284609-99332911-1268400807=:10546
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
--1985284609-99332911-1268400807=:10546
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--1985284609-99332911-1268400807=:10546--
