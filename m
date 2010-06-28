From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 28 Jun 2010 21:26:54 +0000
Subject: Re: [PATCH 4/4] HID: picolcd: implement refcounting of framebuffer
Message-Id: <AANLkTinsj7LTAqAHeQLJzOngT8A4owcVE9ACp7akZSg9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100628223327.23c6006a@neptune.home>
In-Reply-To: <20100628223327.23c6006a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Jun 28, 2010 at 1:33 PM, Bruno Pr=C3=A9mont
<bonbons@linux-vserver.org> wrote:
> As our device may be hot-unplugged and framebuffer cannot handle
> this case by itself we need to keep track of usage count so as
> to release fb_info and framebuffer memory only after the last user
> has closed framebuffer.
>
> We need to do the freeing in a scheduled work as fb_release()
> is called with fb_info lock held.

The udlfb (DisplayLink) framebuffer driver just got a similar fix in
the last few days:
http://git.plugable.com/gitphp/index.php?p=3Dudlfb&a=3Dcommit&h=AE0502457e5=
4904b1a9e0d67db6719182824da7c

The need to schedule work in fb_release() because fbmem.c touches it
after release is especially unfortunate (we had to do the same).

Anyone have existing thoughts about fixing the release path more centrally?

Best wishes,
Bernie
http://plugable.com/
