From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 21 Nov 2011 17:43:34 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from
Message-Id: <20111121184334.6424c478@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, 21 November 2011 Timur Tabi wrote:
> Bruno Pr=C3=A9mont wrote:
>=20
> > Wouldn't it even make sense to move some more of the initialization of =
fb_info
> > out of fb registration into this new init funtion? (I'm thinking about =
initializing
> > mutexes and the like)
>=20
> I was thinking the opposite.  See my reply to Florian's message.

Well, in there you don't mention a reason to put it in
register_framebuffer() rather than collect initialization into
a new function for exactly that task.

> > This way fb_info could be used before being registered. Registration wo=
uld then
> > be reduced to makeing the framebuffer visible to userspace and listed in
> > registered_fb[].
> >=20
> > This way framebuffer_alloc() would be no more that kzalloc(), framebuff=
er_init()
> > would setup all "non-zero" fields of fb_info (including setup of all mu=
texes, one
> > of which is currently being done by framebuffer_alloc() and the rest by
> > do_register_framebuffer()!).
>=20
> I think the problem is that it's unclear what the difference is between
> framebuffer_alloc() and register_framebuffer().  The problem is that
> register_framebuffer() also initializes the fb_info structure.  So some
> initialization is done in framebuffer_alloc(), some is done in register_f=
ramebuffer(),
> and some is done by the driver.  Not only that, but drivers that don't ca=
ll
> framebuffer_alloc() can't really know what needs to be initialized before
> calling register_framebuffer().
>=20
> Why is fb_info->lock initialized in register_framebuffer(), but
> fb_info->bl_curve_mutex is initialized in framebuffer_alloc()?
>  They're both mutexes.

Exactly, thats why I would prefer to see all that initialization moved
out of registrer_framebuffer() into a init_framebuffer().

For simplicity any driver that uses framebuffer_alloc() should not need
to additionally call init_framebuffer() - framebuffer_alloc() should
call it just before returning.
All those drivers that don't call framebuffer_alloc() would then have to
call init_framebuffer().

I think register_framebuffer() is a bit too late to do the initialisation
of mutexes and other class state because driver cannot use the same code
for HW setup before registration and after registration as at least the lock
is in undefined state.


In pseudo-code my though would be:


// driver using their own memory allocation

struct driver_data {
   ...
   struct fb_info fb;
   ...
}

int driver_init() {
   struct driver_data *data;
   ...
   memset(&data->fb, 0, sizeof(data->fb));
   init_framebuffer(&data->fb);
   // fill in driver's settings for fb
   ...
   register_framebuffer(&data->fb);
   ...
}

// driver using alloc_framebuffer()

struct driver_data {
   ...
   struct fb_info *fb;
   ...
}

int driver_init() {
   struct driver_data *data;
   ...
   data->fb =3D alloc_framebuffer(0); // this implicitly calls init_framebu=
ffer();
   // fill in driver's settings for fb
   ...
   register_framebuffer(&data->fb);
   ...
}




Bruno
