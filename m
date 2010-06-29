From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 29 Jun 2010 20:42:01 +0000
Subject: Re: [PATCH 4/4] HID: picolcd: implement refcounting of framebuffer
Message-Id: <20100629224201.54db5c2f@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100628223327.23c6006a@neptune.home>
In-Reply-To: <20100628223327.23c6006a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, 28 June 2010 Bernie Thompson <bernie@plugable.com> wrote:
> On Mon, Jun 28, 2010 at 1:33 PM, Bruno Pr=C3=A9mont
> <bonbons@linux-vserver.org> wrote:
> > As our device may be hot-unplugged and framebuffer cannot handle
> > this case by itself we need to keep track of usage count so as
> > to release fb_info and framebuffer memory only after the last user
> > has closed framebuffer.
> >
> > We need to do the freeing in a scheduled work as fb_release()
> > is called with fb_info lock held.
>=20
> The udlfb (DisplayLink) framebuffer driver just got a similar fix in
> the last few days:
> http://git.plugable.com/gitphp/index.php?p=3Dudlfb&a=3Dcommit&h=AE0502457=
e54904b1a9e0d67db6719182824da7c
>=20
> The need to schedule work in fb_release() because fbmem.c touches it
> after release is especially unfortunate (we had to do the same).
>=20
> Anyone have existing thoughts about fixing the release path more centrall=
y?

The best option IMHO would be that framebuffer_release() would free up
memory when framebuffer is not in use anymore (or last close if FB was
in use when framebuffer_release() was called).

Something like
  framebuffer_alloc()              <-- set refcount to 1
  ...
  register_framebuffer()           <-- inc refcount
  ...
  and open() of fb device would inc refcount
  and close() would decrement it

  unregister_framebuffer()         <-- dec refcount
  framebuffer_release()            <-- dec refcount

When after decrementing refcount, refcount reaches zero
close() or framebuffer_release() would free the framebuffer, calling
fbops fb_release() callback so owner can do cleanup if it has something
to do.

That way it would be easiest for drivers of removable framebuffers,
possibly also useful for kms adding/removing framebuffers for extra
monitors.

Thanks,
Bruno
