From: James Simmons <jsimmons@infradead.org>
Subject: Re: vga16fb broke
Date: Tue, 18 May 2004 23:36:39 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405142314060.25927-100000@phoenix.infradead.org>
References: <20040514145559.55202998.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQDCY-0007aZ-Sl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 15:36:46 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BQDCY-0001Hf-3M
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 15:36:46 -0700
In-Reply-To: <20040514145559.55202998.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: VANDROVE@vc.cvut.cz, Vincent Sanders <vince@kyllikki.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Guys, can you help with http://bugme.osdl.org/show_bug.cgi?id=2711 ?
> 
> The recent change broke it on x86 becuase we're now doing ioremap()
> of a kernel-virtual address, but the oriiginal version doesn't work on ARM.
> 
> Should it just be:
> 
> 	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);

I went looking at the various platforms to see what exactly was going on.
We have:

Useage

./drivers/video/console/mdacon.c: mda_vram_base = VGA_MAP_MEM(0xb0000);
./drivers/video/console/vgacon.c: vga_vram_base = VGA_MAP_MEM(vga_vram_base);
./drivers/video/console/vgacon.c: vga_vram_end = VGA_MAP_MEM(vga_vram_end);
./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(colourmap);
./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(blackwmap);
./drivers/video/hgafb.c:	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
./drivers/video/vga16fb.c:	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
./drivers/video/vga16fb.c:	vga16fb.fix.smem_start	= VGA_MAP_MEM(vga16fb.fix.smem_start);

ioremap happy

./include/asm-alpha/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
./include/asm-ia64/vga.h:#define VGA_MAP_MEM(x)	((unsigned long) ioremap((x), 0))
./include/asm-ppc64/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))

can be ioremap happy because ioremap in io.h matches below definetions. 

./include/asm-i386/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
./include/asm-sparc64/vga.h:#define VGA_MAP_MEM(x) (x)
./include/asm-x86_64/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)

Not happy.

./include/asm-arm/vga.h:#define VGA_MAP_MEM(x)	(PCIMEM_BASE + (x))
./include/asm-mips/vga.h:#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
./include/asm-ppc/vga.h:#define VGA_MAP_MEM(x) (x + vgacon_remap_base)


So you can see that VGA_MAP_MEM is already ioremapping which is causing 
the problem. Personally I like to see the lose ends fixed on ARM, MIPS, 
and PPC so we can use just ioremap.





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
