From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 10:00:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804220951380.14102@anakin>
References: <1208827046.9640.73.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoDQS-0008N8-F7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 01:00:28 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoDQQ-0003D2-Si
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 01:00:28 -0700
In-Reply-To: <1208827046.9640.73.camel@pasglop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, 22 Apr 2008, Benjamin Herrenschmidt wrote:
> We currently have a problem with those two members of struct
> fb_fix_screeninfo. The struct contains an "unsigned long" which means
> that:
> 
> - 64 bits kernels with 32 bits userspace can't pass a complete address
> - 32 bits machines with 64 bits resource_size_t can't pass a complete
> address
> - The structure isn't even properly padded to be 32/64 bits neutral in
> the first place.
> 
> We could define new versions of the struct with new get/set ioctls,
> or we could try to just deprecate those fields. What do you guys think ?

As userspace doesn't really need those fields[1], we can easily deprecate them.

> If we do the later, we need another way to convey the informations.
> 
> For smem, I'm not sure it's very useful, we should just be able to mmap
> the fbdev. The problem is more with mmio_start.
> 
> Thus the idea that we could do something to allow mmap'ing mmio via
> mmap of /dev/fb via some specific offset... what do you think ?

That's exactly what drivers/video/fbmem.c:fb_mmap() does[2].

But fb_mmap() does need the correct (resource_size_t) information.
That can be done by changing the offending fields in the kernel variant of
fb_fix_screeninfo to resource_size_t.

The user variant of fb_fix_screeninfo would stay the same, and only the
FBIOGET_FSCREENINFO case in drivers/video/fbmem.c:fb_ioctl() has to be
changed to convert from the kernel to the user variant.

> Or we can just do a fb_fix_screeninfo2, with proper padding and u64
> addresses, replace the kernel one with that, have translators for the
> old ioctl's, and new ioctl's.

I don't think the new ioctls are needed.

[1] Except when it wants to mmap /dev/mem using this info, but that can
    be done using [2].

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
