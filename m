From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Linux 2.4.29-pre1 (was: Re: [PATCH] vga16fb: Fix frame buffer bad
 memory mapping)
Date: Sat, 27 Nov 2004 16:54:12 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411271640560.13674@waterleaf.sonytel.be>
References: <200411252301.iAPN1mo4023046@hera.kernel.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261230AbUK0Pyp@vger.kernel.org>
In-Reply-To: <200411252301.iAPN1mo4023046@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vince@arm.linux.org.uk, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 25 Nov 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.1543, 2004/11/25 13:16:49-02:00, vince@arm.linux.org.uk
> 
> 	[PATCH] vga16fb: Fix frame buffer bad memory mapping
> 	
> 	The vga16fb driver uses a direct ioremap on 0xa00000 to gain access to
> 	the vga card. This is wrong on architectures other than x86, every
> 	other driver uses VGA_MAP_MEM macro from vga.h to ensure the correct
> 	memory mapping.
> 	
> 	All this patch does is add the mapping macro this has been tested and
> 	works on ARM systems The driver no longer maps parts of kernel
> 	workspace and modifies it.

This fix is not correct!

> diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
> --- a/drivers/video/vga16fb.c	2004-11-25 15:01:51 -08:00
> +++ b/drivers/video/vga16fb.c	2004-11-25 15:01:51 -08:00
> @@ -142,7 +142,7 @@
>  	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
>  	strcpy(fix->id,"VGA16 VGA");
>  
> -	fix->smem_start = VGA_FB_PHYS;
> +	fix->smem_start = VGA_MAP_MEM(VGA_FB_PHYS);
>  	fix->smem_len = VGA_FB_PHYS_LEN;
>  	fix->type = FB_TYPE_VGA_PLANES;
>  	fix->visual = FB_VISUAL_PSEUDOCOLOR;

fix->smem_start: Although I agree VGA_FB_PHYS is not the correct value on
machines other than PC, VGA_MAP_MEM(VGA_FB_PHYS) is not appropriate either,
because fix->smem_start is supposed to be a CPU _physical_ address, not a
virtual address.

However, this value isn't really used, except by (very rare) userspace that
wants to mmap the frame buffer through /dev/mem instead of /dev/fb*, so an
incorrect value doesn't really harm.

> @@ -896,7 +896,7 @@
>  
>  	/* XXX share VGA_FB_PHYS region with vgacon */
>  
> -        vga16fb.video_vbase = ioremap(VGA_FB_PHYS, VGA_FB_PHYS_LEN);
> +        vga16fb.video_vbase = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
>  	if (!vga16fb.video_vbase) {
>  		printk(KERN_ERR "vga16fb: unable to map device\n");
>  		return -ENOMEM;

ioremap(): VGA_MAP_MEM() already a _virtual_ address:

| include/asm-alpha/vga.h:#define VGA_MAP_MEM(x)   ((unsigned long) ioremap((x), 0))
| include/asm-arm/vga.h:#define VGA_MAP_MEM(x)     (PCIMEM_BASE + (x))
| include/asm-i386/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
| include/asm-ia64/vga.h:#define VGA_MAP_MEM(x)    ((unsigned long) ioremap((x), 0))
| include/asm-mips/vga.h:#define VGA_MAP_MEM(x) ((unsigned long)0xb0000000 + (unsigned long)(x))
| include/asm-ppc/vga.h:#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
| include/asm-ppc64/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
| include/asm-sparc64/vga.h:#define VGA_MAP_MEM(x) (x)
| include/asm-x86_64/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)

Doing a double ioremap(), or ioremap(phys_to_virt()) will break for sure...

BTW, on (PReP/CHRP) PPC ioremap() on ISA memory space `just works' because
__ioremap() adds _ISA_MEM_BASE to the passed pointer if it's smaller than
16*1024*1024. And yes, vga16fb used to work fine on my CHRP LongTrail
(before the machine itself died :-(.

Yes, ISA memory space is a mess to do right in a portable way...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
