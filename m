From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/13 v2] viafb: accel.c, accel.h
Date: Tue, 19 Aug 2008 16:23:03 -0700
Message-ID: <20080819162303.5fc89c63.akpm@linux-foundation.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698F@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVaiJ-0004Ix-BM for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 16:34:12 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVaiH-000289-C1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 16:34:10 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698F@exchtp03.taipei.via.com.tw>
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
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 8 Aug 2008 18:11:05 +0800
<JosephChan@via.com.tw> wrote:

> 2D and HW cursor stuff of viafb driver.

x86_64 allmodconfig throws a lot of warnings:

drivers/video/via/viafbdev.c: In function 'viafb_fillrect':
drivers/video/via/viafbdev.c:904: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:904: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c: In function 'viafb_copyarea':
drivers/video/via/viafbdev.c:955: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:955: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:959: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:959: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c: In function 'viafb_imageblit':
drivers/video/via/viafbdev.c:1016: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:1016: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c: In function 'via_pci_probe':
drivers/video/via/viafbdev.c:2119: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:2119: warning: cast to pointer from integer of different size
drivers/video/via/viafbdev.c:2121: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:2121: warning: cast to pointer from integer of different size
drivers/video/via/viafbdev.c:2123: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:2123: warning: cast to pointer from integer of different size
drivers/video/via/viafbdev.c:2125: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:2125: warning: cast to pointer from integer of different size
drivers/video/via/viafbdev.c:2127: warning: cast from pointer to integer of different size
drivers/video/via/viafbdev.c:2127: warning: cast to pointer from integer of different size

due to things like this:

        MMIO_OUT32(VIA_REG_DSTBASE,
                   ((u32) (info->screen_base) - (u32) viafb_FB_MM) >> 3);

now, we could just shut the warnings up by casting to (long) instead.

But I wonder what's going on in there.  ->screen_base came from
ioremap_nocache() and AFAIK there's no guarantee that this virtual
address will be less than 4G on 64-bit machines?



Also, from a stylistic point ov view, this:

#define VIA_MMIO 1

#if VIA_MMIO
#define MMIO_OUT32(reg, val) writel(val, viaparinfo->io_virt + reg)
#define MMIO_IN32(reg)      readl(viaparinfo->io_virt + reg)

#else
#define MMIO_OUT32(reg, val) outl(val, reg)
#define MMIO_IN32(reg)      inl(reg)
#endif

is quite ugly.

If the !VIA_MMIO code has no valid use then please just remove it.

The VIA_MMIO!=0 macros inplicitly reference a local variable which is
the kind of dopey programming trick which should not be performed in
new code.  It would be much better to do

static inline void via_writel(struct viafb_par *viaparinfo, int reg, u32 val)
{
	writel(val, viaparinfo->io_virt + reg);
}

and use that everywhere.

It would also be quite acceptable to simply open-code the

	writel(val, viaparinfo->io_virt + reg);

at all callsites.

Those macros may have made it easier to _write_ the code, but they make
it harder to _read_ it.  That's a wrong tradeoff.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
