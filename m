From: Timur Tabi <timur@freescale.com>
Date: Mon, 21 Nov 2011 18:37:48 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4ECA9A7C.5040402@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Bruno Pr=E9mont wrote:

> Exactly, thats why I would prefer to see all that initialization moved
> out of registrer_framebuffer() into a init_framebuffer().

I'm okay with that, but I'm not crazy about it.

>=20
> For simplicity any driver that uses framebuffer_alloc() should not need
> to additionally call init_framebuffer() - framebuffer_alloc() should
> call it just before returning.

My patch does that.

> All those drivers that don't call framebuffer_alloc() would then have to
> call init_framebuffer().

Well, that would then mean that it's easier to move initialization *into* r=
egister_framebuffer().

> I think register_framebuffer() is a bit too late to do the initialisation
> of mutexes and other class state because driver cannot use the same code
> for HW setup before registration and after registration as at least the l=
ock
> is in undefined state.

How many drivers actually do that?  The only thing that framebuffer_alloc()=
 initializes in fb_info is the 'device' field, which is just a parameter pa=
ssed into framebuffer_alloc(), so the driver already knows what that value =
is.  I can't find any examples of a driver doing what you're talking about.

It should be easy to modify any driver to stop using the fields of fb_info =
before register_framebuffer() is called.  In fact, I would say it's bad pro=
gramming to use the fb_info object before the framebuffer is registered.

> In pseudo-code my though would be:
>=20
>=20
> // driver using their own memory allocation
>=20
> struct driver_data {
>    ...
>    struct fb_info fb;
>    ...
> }
>=20
> int driver_init() {
>    struct driver_data *data;
>    ...
>    memset(&data->fb, 0, sizeof(data->fb));
>    init_framebuffer(&data->fb);
>    // fill in driver's settings for fb
>    ...
>    register_framebuffer(&data->fb);
>    ...
> }
>=20
> // driver using alloc_framebuffer()
>=20
> struct driver_data {
>    ...
>    struct fb_info *fb;
>    ...
> }
>=20
> int driver_init() {
>    struct driver_data *data;
>    ...
>    data->fb =3D alloc_framebuffer(0); // this implicitly calls init_frame=
buffer();
>    // fill in driver's settings for fb
>    ...
>    register_framebuffer(&data->fb);
>    ...
> }

This is pretty much what my patch does.  But the more I think about it, the=
 more I'm in favor of moving all initialization into register_framebuffer().

--=20
Timur Tabi
Linux kernel developer at Freescale

