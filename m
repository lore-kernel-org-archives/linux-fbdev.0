From: Andrew Morton <akpm@osdl.org>
Subject: Re: vga16fb broke
Date: Tue, 18 May 2004 17:16:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040518171612.516ad43c.akpm@osdl.org>
References: <20040514145559.55202998.akpm@osdl.org>
	<Pine.LNX.4.44.0405142314060.25927-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S263563AbUESAOF@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405142314060.25927-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: VANDROVE@vc.cvut.cz, vince@kyllikki.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> 
> > Guys, can you help with http://bugme.osdl.org/show_bug.cgi?id=2711 ?
> > 
> > The recent change broke it on x86 becuase we're now doing ioremap()
> > of a kernel-virtual address, but the oriiginal version doesn't work on ARM.
> > 
> > Should it just be:
> > 
> > 	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);
> 
> I went looking at the various platforms to see what exactly was going on.
> We have:
> 
> Useage
> 
> ./drivers/video/console/mdacon.c: mda_vram_base = VGA_MAP_MEM(0xb0000);
> ./drivers/video/console/vgacon.c: vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> ./drivers/video/console/vgacon.c: vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> ./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(colourmap);
> ./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(blackwmap);
> ./drivers/video/hgafb.c:	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
> ./drivers/video/vga16fb.c:	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
> ./drivers/video/vga16fb.c:	vga16fb.fix.smem_start	= VGA_MAP_MEM(vga16fb.fix.smem_start);
> 
> ioremap happy
> 
> ./include/asm-alpha/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
> ./include/asm-ia64/vga.h:#define VGA_MAP_MEM(x)	((unsigned long) ioremap((x), 0))
> ./include/asm-ppc64/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
> 
> can be ioremap happy because ioremap in io.h matches below definetions. 
> 
> ./include/asm-i386/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
> ./include/asm-sparc64/vga.h:#define VGA_MAP_MEM(x) (x)
> ./include/asm-x86_64/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
> 
> Not happy.
> 
> ./include/asm-arm/vga.h:#define VGA_MAP_MEM(x)	(PCIMEM_BASE + (x))
> ./include/asm-mips/vga.h:#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
> ./include/asm-ppc/vga.h:#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
> 
> 
> So you can see that VGA_MAP_MEM is already ioremapping which is causing 
> the problem. Personally I like to see the lose ends fixed on ARM, MIPS, 
> and PPC so we can use just ioremap.

I have pondered your email at length and have failed to understand it.

I _think_ you're saying that we need to do this, which will fix x86:

--- 25/drivers/video/vga16fb.c~vga16fb-fix	Tue May 18 17:10:14 2004
+++ 25-akpm/drivers/video/vga16fb.c	Tue May 18 17:10:39 2004
@@ -1347,7 +1347,7 @@ int __init vga16fb_init(void)
 
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
 
-	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
+	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);
 	if (!vga16fb.screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");
 		ret = -ENOMEM;

_

and that ARM and others need to teach their VGA_MAP_MEM() to do an internal
ioremap().

Or do you mean something else?  Please be more clear?
