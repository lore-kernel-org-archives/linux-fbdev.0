From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux 2.4.29-pre1 (was: Re: [PATCH] vga16fb: Fix frame buffer
 bad memory mapping)
Date: Wed, 1 Dec 2004 09:48:29 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0412010946090.21508@waterleaf.sonytel.be>
References: <200411252301.iAPN1mo4023046@hera.kernel.org>
 <Pine.GSO.4.61.0411271640560.13674@waterleaf.sonytel.be>
 <20041130112947.GB3041@dmt.cyclades>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZQAb-0003vz-2H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 00:49:05 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZQAS-0003UB-Me
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Dec 2004 00:49:01 -0800
In-Reply-To: <20041130112947.GB3041@dmt.cyclades>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: vince@arm.linux.org.uk, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 30 Nov 2004, Marcelo Tosatti wrote:
> On Sat, Nov 27, 2004 at 04:54:12PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 25 Nov 2004, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1543, 2004/11/25 13:16:49-02:00, vince@arm.linux.org.uk
> > > 
> > > 	[PATCH] vga16fb: Fix frame buffer bad memory mapping
> > > 	
> > > 	The vga16fb driver uses a direct ioremap on 0xa00000 to gain access to
> > > 	the vga card. This is wrong on architectures other than x86, every
> > > 	other driver uses VGA_MAP_MEM macro from vga.h to ensure the correct
> > > 	memory mapping.
> > > 	
> > > 	All this patch does is add the mapping macro this has been tested and
> > > 	works on ARM systems The driver no longer maps parts of kernel
> > > 	workspace and modifies it.
> > 
> > This fix is not correct!
> > 
> > > diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
> > > --- a/drivers/video/vga16fb.c	2004-11-25 15:01:51 -08:00
> > > +++ b/drivers/video/vga16fb.c	2004-11-25 15:01:51 -08:00
> > > @@ -142,7 +142,7 @@
> > >  	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
> > >  	strcpy(fix->id,"VGA16 VGA");
> > >  
> > > -	fix->smem_start = VGA_FB_PHYS;
> > > +	fix->smem_start = VGA_MAP_MEM(VGA_FB_PHYS);
> > >  	fix->smem_len = VGA_FB_PHYS_LEN;
> > >  	fix->type = FB_TYPE_VGA_PLANES;
> > >  	fix->visual = FB_VISUAL_PSEUDOCOLOR;
> > 
> > fix->smem_start: Although I agree VGA_FB_PHYS is not the correct value on
> > machines other than PC, VGA_MAP_MEM(VGA_FB_PHYS) is not appropriate either,
> > because fix->smem_start is supposed to be a CPU _physical_ address, not a
> > virtual address.
> > 
> > However, this value isn't really used, except by (very rare) userspace that
> > wants to mmap the frame buffer through /dev/mem instead of /dev/fb*, so an
> > incorrect value doesn't really harm.
> > 
> > > @@ -896,7 +896,7 @@
> > >  
> > >  	/* XXX share VGA_FB_PHYS region with vgacon */
> > >  
> > > -        vga16fb.video_vbase = ioremap(VGA_FB_PHYS, VGA_FB_PHYS_LEN);
> > > +        vga16fb.video_vbase = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
> > >  	if (!vga16fb.video_vbase) {
> > >  		printk(KERN_ERR "vga16fb: unable to map device\n");
> > >  		return -ENOMEM;
> > 
> > ioremap(): VGA_MAP_MEM() already a _virtual_ address:
> > 
> > | include/asm-alpha/vga.h:#define VGA_MAP_MEM(x)   ((unsigned long) ioremap((x), 0))
> > | include/asm-arm/vga.h:#define VGA_MAP_MEM(x)     (PCIMEM_BASE + (x))
> > | include/asm-i386/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
> > | include/asm-ia64/vga.h:#define VGA_MAP_MEM(x)    ((unsigned long) ioremap((x), 0))
> > | include/asm-mips/vga.h:#define VGA_MAP_MEM(x) ((unsigned long)0xb0000000 + (unsigned long)(x))
> > | include/asm-ppc/vga.h:#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
> > | include/asm-ppc64/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
> > | include/asm-sparc64/vga.h:#define VGA_MAP_MEM(x) (x)
> > | include/asm-x86_64/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
> > 
> > Doing a double ioremap(), or ioremap(phys_to_virt()) will break for sure...
> > 
> > BTW, on (PReP/CHRP) PPC ioremap() on ISA memory space `just works' because
> > __ioremap() adds _ISA_MEM_BASE to the passed pointer if it's smaller than
> > 16*1024*1024. And yes, vga16fb used to work fine on my CHRP LongTrail
> > (before the machine itself died :-(.
> > 
> > Yes, ISA memory space is a mess to do right in a portable way...
> 
> Geert, 
> 
> I'll guest I'll just revert the whole change then... Do you have a

Yes, please.

> better suggestion? 

Replacing

    vga16fb.video_vbase = ioremap(VGA_FB_PHYS, VGA_FB_PHYS_LEN);

by

    vga16fb.video_vbase = VGA_MAP_MEM(VGA_FB_PHYS);

will probably work, since that's what vgacon does, but I'd like to see it
tested first anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
