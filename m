From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Virtual framebuffer driver - mmap problem
Date: Thu, 9 Sep 2004 10:31:16 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409091029190.10508@waterleaf.sonytel.be>
References: <77e82a3f0409080651732d891e@mail.gmail.com>
 <200409090831.21966.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5KL5-0006BL-NH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 01:31:31 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5KL2-0003SK-FP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 01:31:31 -0700
In-Reply-To: <200409090831.21966.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Shivappa Kushtagi <kushtagi@gmail.com>

On Thu, 9 Sep 2004, Antonino A. Daplas wrote:
> On Wednesday 08 September 2004 21:51, Shivappa Kushtagi wrote:
> > == You cannot mmap() the video memory of vfb.
> >
> > ==  Why don"t you use vesafb?
> >
> > As I had mentioned in my earlier post, I wanted to use virtual
> > framebuffer to simulate the display of my target device (say some PDA
> > with size 320*480 ).  With vesafb, I will not be able to change the
> > resolution ( fbset fails telling,  invalid argument )
> >
> >
> > Is there any other framebuffer based methods to simulate a display ?
> >
>
> There are 2 problems with vfb.c that makes mmap fail:
>
> 1. uses vmalloc to allocate framebuffer memory
> 2. has its own fb_mmap hook which always return -EINVAL
>
> If you want to really use vfb.c, you can try to modify vfb.c so it behaves
> like a normal, mmappable framebuffer.
>
> A. First you need to change the framebuffer allocation method: Do not use
> vmalloc, since it doesn't give you linear memory.  Instead use
> __get_free_pages.
>
> videomemorysize = PAGE_SIZE << order;
>
> So if PAGE_SIZE is 4096, to allocate 8192 bytes, use order = 1. Note that
> there is an upper limit to order, so keep videomemorysize small.

And the upper limit is 128 kiB on most platforms. Hence even 640x480 in 8 bpp
won't fit...

Probably you can make a fb_mmap() hook that's compatible with the vmalloc()'ed
frame buffer and thus doesn't suffer from this limitation, but it will require
more code and more knowledge of memory management internals.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
