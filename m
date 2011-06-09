From: Wu Fengguang <fengguang.wu@intel.com>
Date: Thu, 09 Jun 2011 06:38:10 +0000
Subject: Re: [RFC] fbmem: reset file->private_data on failed fb_open()
Message-Id: <20110609063810.GA8071@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110609030628.GA10233@localhost>
 <20110609081019.145ed6d5@pluto.restena.lu>
In-Reply-To: <20110609081019.145ed6d5@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, thomas.creutz@gmx.de

[Add CC to Thomas Creutz]

On Thu, Jun 09, 2011 at 02:10:19PM +0800, Bruno Pr=C3=A9mont wrote:
> On Thu, 9 Jun 2011 11:06:28 Wu Fengguang <fengguang.wu@intel.com> wrote:
> > I wrote this when looking at NULL dereference bug
> > https://bugzilla.kernel.org/show_bug.cgi?id=18912
>=20
> The trace over there rather looks like closing of a framebuffer that
> has been replaced (and destroyed) during boot sequence.
> This action happens when switching from VESA to KMS from initrd
> or early userspace boot sequence where plymouthd had already opened
> vesafb.
>=20
> That should hopefully be fixed by refcounting FBs as done during
> 2.6.39-rc7.

That's great! Then hopefully the bug can be closed?

> > Will it help by clearing private_data? I have no idea at all, because
> > for regular files, ->release won't be called on failed ->open. Just in
> > case there are some exceptions in fbmem...
>=20
> fb devices files should be just as regular as any other device files...

Good, thanks for the confirmation.

Thanks,
Fengguang

> > ---
> >  drivers/video/fbmem.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > --- linux-next.orig/drivers/video/fbmem.c	2011-06-09 10:36:06.000000000=
 +0800
> > +++ linux-next/drivers/video/fbmem.c	2011-06-09 10:39:30.000000000 +0800
> > @@ -1424,26 +1424,28 @@ __releases(&info->lock)
> >  	file->private_data =3D info;
> >  	if (info->fbops->fb_open) {
> >  		res =3D info->fbops->fb_open(info,1);
> >  		if (res)
> >  			module_put(info->fbops->owner);
> >  	}
> >  #ifdef CONFIG_FB_DEFERRED_IO
> >  	if (info->fbdefio)
> >  		fb_deferred_io_open(info, inode, file);
> >  #endif
> >  out:
> >  	mutex_unlock(&info->lock);
> > -	if (res)
> > +	if (res) {
> > +		file->private_data =3D NULL;
> >  		put_fb_info(info);
> > +	}
> >  	return res;
> >  }
> > =20
> >  static int=20
> >  fb_release(struct inode *inode, struct file *file)
> >  __acquires(&info->lock)
> >  __releases(&info->lock)
> >  {
> >  	struct fb_info * const info =3D file->private_data;
> > =20
> >  	mutex_lock(&info->lock);
> >  	if (info->fbops->fb_release)
