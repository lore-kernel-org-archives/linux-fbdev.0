From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5 atyfb on Sparc question
Date: Fri, 18 Oct 2002 11:14:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181103380.10832-100000@maxwell.earthlink.net>
References: <20021014100438.GA2086@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182bjf-0002zX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 11:20:35 -0700
In-Reply-To: <20021014100438.GA2086@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>, linux-fbdev-devel@lists.sourceforge.net


> I thought i may as well write a little HOWTO or something such on the
> way of doing this. Since i have not much fbdev writing experience, maybe
> i am a good candidate for writing such a thing.

Wow that would be great.

> I wanted, in the first step, to do just a basic unaccelerated fbdev
> driver, without mode changes and anything fancy, and once this works,
> add things incrementally. I believe this approach will be good for
> future fbdev driver writters.

Good approach to doing this.

> Anyway, now for my question.
>
> skeletonfb says that check_var, set_par, setcolreg, pan_display and
> blank functions are optional or not required. Is that true, and in case
> i don't want to provide them, whay do i put in the fb_ops structure ?

All the functions are optional. They are needed when:

fb_open:        We need special things done when we open or close /dev/fb
fb_release:

fb_read: 	When we have a strange framebuffer that doesn't allow
fb_write:	linear writes. A good example is the Epson1385 chipset at
		16 bpp mode.

fb_check_var:   When we can change the resolution of the display.
fb_set_par:

fb_setcolreg:	Have a programable color palette.

fb_blank:	Have hardware support for power management of some kind.

fb_pan_display: Hardware scrolling

fb_cursor:	Hardware cursor.

fb_poll:	Want to use interrupts such as VLB.

fb_sync:	To sync the accel engine and framebuffer memory.

fb_ioctl:	Extra functions you want to support.

fb_mmap:	Have special memory needs when exposing to userland.

fb_rastering:	I don't know if we are going to keep this one?

The only ones require are the accel functions for drawing on the console.

> Later, in the fb_ops structure, only set_par, blank and pan_display are
> labeled as optional.

That is a mistake.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
