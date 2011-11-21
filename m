From: Timur Tabi <timur@freescale.com>
Date: Mon, 21 Nov 2011 16:28:25 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4ECA7C29.8080604@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Bruno Pr=E9mont wrote:

> Wouldn't it even make sense to move some more of the initialization of fb=
_info
> out of fb registration into this new init funtion? (I'm thinking about in=
itializing
> mutexes and the like)

I was thinking the opposite.  See my reply to Florian's message.

> This way fb_info could be used before being registered. Registration woul=
d then
> be reduced to makeing the framebuffer visible to userspace and listed in
> registered_fb[].
>=20
> This way framebuffer_alloc() would be no more that kzalloc(), framebuffer=
_init()
> would setup all "non-zero" fields of fb_info (including setup of all mute=
xes, one
> of which is currently being done by framebuffer_alloc() and the rest by
> do_register_framebuffer()!).

I think the problem is that it's unclear what the difference is between fra=
mebuffer_alloc() and register_framebuffer().  The problem is that register_=
framebuffer() also initializes the fb_info structure.  So some initializati=
on is done in framebuffer_alloc(), some is done in register_framebuffer(), =
and some is done by the driver.  Not only that, but drivers that don't call=
 framebuffer_alloc() can't really know what needs to be initialized before =
calling register_framebuffer().

Why is fb_info->lock initialized in register_framebuffer(), but fb_info->bl=
_curve_mutex is initialized in framebuffer_alloc()?  They're both mutexes.

--=20
Timur Tabi
Linux kernel developer at Freescale

