From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Atyfb: kill assignment warnings on Atari due to __iomem changes
Date: Sun, 24 Oct 2004 20:33:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410242033.29075.adaplas@hotpop.com>
References: <Pine.LNX.4.61.0410241314550.27526@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLhSt-0008Pe-4c
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 05:27:15 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CLhSq-00040F-VB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 05:27:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E2CB6768F9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Oct 2004 12:26:46 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.61.0410241314550.27526@anakin>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sunday 24 October 2004 19:15, Geert Uytterhoeven wrote:
> Atyfb: kill assignment warnings on Atari due to __iomem changes

I pushed a big mach64 patch (coming from various authors) to Andrew, and
this will  get rejected.

Attached is an incremental patch for the big mach64 update.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

---diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-10-22 15:57:58 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-10-24 20:26:04 +08:00
@@ -3457,8 +3457,10 @@
 		 */
 		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
 		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
-		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) + 0xFC00ul;
-		info->fix.mmio_start = par->ati_regbase; /* Fake! */
+		par->ati_regbase = ioremap(phys_guiregbase[m64_num],
+					   0x10000) + 0xFC00ul;
+		info->fix.mmio_start =
+			(unsigned long)par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, par);





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
