From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move
 arch-specific bits to their respective subdirectories
Date: Thu, 17 May 2007 11:43:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705171140230.20754@anakin>
References: <464B78BC.4080900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HocWK-0007tn-Vz for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 02:43:41 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HocWK-0007TG-AA
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 May 2007 02:43:40 -0700
In-Reply-To: <464B78BC.4080900@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, uClinux list <uclinux-dev@uclinux.org>

On Thu, 16 May 2007, Antonino A. Daplas wrote:
> diff --git a/include/asm-m68k/fb.h b/include/asm-m68k/fb.h
> new file mode 100644
> index 0000000..7d4a28f
> --- /dev/null
> +++ b/include/asm-m68k/fb.h
> @@ -0,0 +1,28 @@
> +#ifndef _ASM_FB_H_
> +#define _ASM_FB_H_
> +
> +#include <linux/fs.h>
> +#include <asm/page.h>
> +#include <asm/setup.h>
> +
> +#ifdef CONFIG_SUN3
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma)
> +{
> +	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
> +}
> +#elif defined(CONFIG_MMU)
   ^^^^^^^^^^^^^^^^^^^^^^^^^
This can be a plain `#else', as m68knommu hasn't been merged with m68k
(yet :-)

> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma)
> +	if (CPU_IS_020_OR_030)
> +		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
> +	if (CPU_IS_040_OR_060) {
> +		pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
> +		/* Use no-cache mode, serialized */
> +		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
> +	}
> +}
> +#else
   ^^^^^
So this branch can go away

> +#warning What do we have to do here??
> +#define fb_pgprotect(...) do {} while (0)
> +#endif /* CONFIG_SUN3 */
> +
> +#endif /* _ASM_FB_H_ */
> diff --git a/include/asm-m68knommu/fb.h b/include/asm-m68knommu/fb.h
> new file mode 100644
> index 0000000..dc9d1be
> --- /dev/null
> +++ b/include/asm-m68knommu/fb.h
> @@ -0,0 +1,7 @@
> +#ifndef _ASM_FB_H_
> +#define _ASM_FB_H_
> +
> +#warning What do we have to do here??
> +#define fb_pgprotect(...) do {} while (0)
> +
> +#endif /* _ASM_FB_H_ */

If the m68knommu case in fb_mmap() was empty before, it should be empty here
too, so I guess the warning can go away.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
