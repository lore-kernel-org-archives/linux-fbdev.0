From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 14:38:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804221433120.30966@anakin>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
	<1208854136.9640.104.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoHlZ-0001qe-VN for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 05:38:36 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoHlW-0006ih-Mn
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 05:38:33 -0700
In-Reply-To: <1208854136.9640.104.camel@pasglop>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Josh Boyer <jwboyer@linux.vnet.ibm.com>, "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, 22 Apr 2008, Benjamin Herrenschmidt wrote:
> > > We could define new versions of the struct with new get/set ioctls,
> > > or we could try to just deprecate those fields. What do you guys think ?
> > 
> > As userspace doesn't really need those fields[1], we can easily deprecate them.
> 
> Well... yes and no. At least some X drivers use the mmio_start field to
> map registers via /dev/mem no ?

Perhaps some do. But they're supposed to map mmio by mapping /dev/fb beyond
smem_len.

> > > If we do the later, we need another way to convey the informations.
> > > 
> > > For smem, I'm not sure it's very useful, we should just be able to mmap
> > > the fbdev. The problem is more with mmio_start.
> > > 
> > > Thus the idea that we could do something to allow mmap'ing mmio via
> > > mmap of /dev/fb via some specific offset... what do you think ?
> > 
> > That's exactly what drivers/video/fbmem.c:fb_mmap() does[2].
> 
> Ok, I had a look at it does indeed make MMIO appear after the fb. The
> funny thing here is that it does use fix for that which means it's
> broken on those platforms.

Yes, that's true.

> > But fb_mmap() does need the correct (resource_size_t) information.
> > That can be done by changing the offending fields in the kernel variant of
> > fb_fix_screeninfo to resource_size_t.
> 
> Yup, and we need to add some conversion to the "user" variant.
> 
> > The user variant of fb_fix_screeninfo would stay the same, and only the
> > FBIOGET_FSCREENINFO case in drivers/video/fbmem.c:fb_ioctl() has to be
> > changed to convert from the kernel to the user variant.
> 
> Yup. I could always set smem_start to 0 and mmio_stat to smem_len in
> there while at it. This will break the day we have 4G of video RAM

What does this solve? If userspace uses this to map /dev/mem, it will
map physical address 0?

Won't hurt on all platforms, but it will definitely hurt x86, as they
have system RAM at 0 ;-)

> though. Which is why I wonder if we should -also- make the new kernel
> structure user-visible with a new ioctl, so that user space can migrate
> and the day we have such monsters, we aren't totally broken ?

Hmm, that definitely means a new fb_fix_screeninfo, as smem_len is
currently u32, even on 64-bit.

> > [1] Except when it wants to mmap /dev/mem using this info, but that can
> >     be done using [2].
> 
> Yes, but there are existing broken programs. I'm pretty sure there used
> to be at least...
> 
> One option here is we can test if the values are > 32 bits, when
> converting from the in-kernel 64 bits structure.
> 
> If that's not the case, we copy them as usual, thus we stay compatible
> for cases that work today (such as a 64 bits G5 with 32 bits userspace
> as all MMIO on the G5 is below 4G).

Sounds OK to me.

> If they are >4G, we do something like putting 0xffffffff in smem_start
> and mmio_start, which should make mmap attempts via /dev/mem to fail and
> keep smem_len and mmio_len to the right values.

Sounds OK, too.

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
