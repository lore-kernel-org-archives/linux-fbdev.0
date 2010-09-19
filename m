From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 19 Sep 2010 17:02:40 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <20100919190240.65762511@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
In-Reply-To: <4C963E99.9080207@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

Hi Florian,

On Sun, 19 September 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.=
de> wrote:
> Hi,
>=20
> Bruno Pr=C3=A9mont schrieb:
> > For USB-attached (or other hot-(un)pluggable) framebuffers the current
> > fbdev infrastructure is not very helpful. Each such driver currently
> > needs to perform the ref-counting on its own in .fbops.fb_open and
> > .fbops.fb_release callbacks.
>=20
> I agree. This is a great idea even for non-hot-(un)pluggable framebuffers.

Yes, things like drmfb and drivers of multi-head capable framebuffer
drivers would certainly appreciate as well, but they will probably also
want to care about users (of fb_info.screen_base).

> > This patch moves the ref-counting in fbdev infrastructure.
> > (drivers have not been adjusted, all those releasing fb_info in
> >  .fbops.fb_destroy will not work -- patch for those will follow
> >  later on, all the others will continue to work fine)
> >=20
> > API-wise the following changes are done:
> > - num_registered_fb and registered_fb variables are no more exported.
> >   New functions fb_get_registered() and fb_is_registered() replace
> >   them.
> >   The only know user of those was fbcon, thus the large diff on fbcon.c
> >=20
> >   Note: the accesses to registered_fb and num_registered_fb look racy
> >   as there was not protection at all around them, potentially letting
> >   register_framebuffer() register two framebuffers on the same minor
> >   concurrently, fbcon access should have been safe by combination of
> >   its use of console_semaphore and reaction to events.
> >   In this patch I combined most of fbcon's accesses to registered_fb
> >   and num_registered_fb into fb_is_registered(), though I'm not sure
> >   if the num-check optimization is worth to keep or its check should
> >   be put into a separate function.
> >=20
> > - framebuffer_release() is mapped to fb_put() but will go away
> >   when converting drivers
> >=20
> > Reference count for fb_info can be increased with fb_get(fb_info) and
> > later released with fb_put(fb_info).
> >=20
> >=20
> > If you have concerns regarding the API changes, please let me know.
>=20
> Uhm, I'm not really happy with what we count. With the old method you men=
tioned=20
> we ref-counted framebuffer users, after your patch it's more counting use=
rs +=20
> uses. This might be okay as we usually are interested whether the ref_cou=
nt is 0=20
> or not but it doesn't look right if we modify the refcount during nearly =
every=20
> framebuffer operation. Wouldn't it be sufficient to do the refcounting in=
=20
> fb_open & fb_release operation + in fbcon where open&release are done?

Well I'm more for counting the uses, (especially as the aim is to not
force the driver to look exactly when it can free the fb_info struct).
If the driver needs to know about active users (e.g. for handling memory
reorganization on mode change or the like) that would remain driver's job.

Though this reminds me to double-check the driver module ref-counting versus
fb_info refcounting as otherwise there is a race-window between late fb_rel=
ease
and end of fb_destroy while.

> > diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> > index 0a08f13..be5f342 100644
> > --- a/drivers/video/fbsysfs.c
> > +++ b/drivers/video/fbsysfs.c
> > @@ -58,6 +58,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct=
 device *dev)
> >  		info->par =3D p + fb_info_size;
> > =20
> >  	info->device =3D dev;
> > +	kref_init(&info->refcount);
>=20
> As far as I know there exist framebuffer drivers which do not call=20
> framebuffer_alloc but contain their own fb_info. I guess these would be b=
roken=20
> as well.

For those it would be better to switch them to be using framebuffer_alloc.
I'm even wondering why the mutexes of fb_info are setup in register_framebu=
ffer
instead of in framebuffer_alloc (probably exactly because some drivers don't
use framebuffer_alloc()) -- isn't there a comment somewhere in the code abo=
ut
moving drivers to use framebuffer_alloc()?

Thanks,
Bruno

> Thanks,
>=20
> Florian Tobias Schandinat
