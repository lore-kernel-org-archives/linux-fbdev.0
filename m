From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 24 Sep 2020 14:42:18 +0000
Subject: RE: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
In-Reply-To: <20200924140937.GA749208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, Peilin Ye <yepeilin.cs@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>

> On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> > Hi all,
> >
> > syzbot has reported [1] a global out-of-bounds read issue in
> > fbcon_get_font(). A malicious user may resize `vc_font.height` to a large
> > value in vt_ioctl(), causing fbcon_get_font() to overflow our built-in
> > font data buffers, declared in lib/fonts/font_*.c:
...
> > (drivers/video/fbdev/core/fbcon.c)
> >  	if (font->width <= 8) {
> >  		j = vc->vc_font.height;
> > +		if (font->charcount * j > FNTSIZE(fontdata))
> > +			return -EINVAL;

Can that still go wrong because the multiply wraps?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
