From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Thu, 24 Sep 2020 15:30:35 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200924153035.GA879703@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <20200924140937.GA749208@kroah.com>
 <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
In-Reply-To: <394733ab6fae47488d078cb22f22a85b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@ACULAB.COM>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

Hi!

On Thu, Sep 24, 2020 at 02:42:18PM +0000, David Laight wrote:
> > On Thu, Sep 24, 2020 at 09:38:22AM -0400, Peilin Ye wrote:
> > > Hi all,
> > >
> > > syzbot has reported [1] a global out-of-bounds read issue in
> > > fbcon_get_font(). A malicious user may resize `vc_font.height` to a large
> > > value in vt_ioctl(), causing fbcon_get_font() to overflow our built-in
> > > font data buffers, declared in lib/fonts/font_*.c:
> ...
> > > (drivers/video/fbdev/core/fbcon.c)
> > >  	if (font->width <= 8) {
> > >  		j = vc->vc_font.height;
> > > +		if (font->charcount * j > FNTSIZE(fontdata))
> > > +			return -EINVAL;
> 
> Can that still go wrong because the multiply wraps?

Thank you for bringing this up!

The resizing of `vc_font.height` happened in vt_resizex():

(drivers/tty/vt/vt_ioctl.c)
	if (v.v_clin > 32)
		return -EINVAL;
	[...]
	for (i = 0; i < MAX_NR_CONSOLES; i++) {
			[...]
			if (v.v_clin)
				vcp->vc_font.height = v.v_clin;
				     ^^^^^^^^^^^^^^

It does check if `v.v_clin` is greater than 32. And, currently, all
built-in fonts have a `charcount` of 256.

Therefore, for built-in fonts and resizing happened in vt_resizex(), it
cannot cause an interger overflow.

However I am not very sure about user-provided fonts, and if there are
other functions that can resize `height` or even `charcount` to a really
huge value, but I will do more investigation and think about it.

Thank you,
Peilin Ye
