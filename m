From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/2] Blackfin Video Driver: fix bug when
	opening/reading/mmaping BF54x and BF52x framebuffer simultaneously
Date: Wed, 26 Mar 2008 18:19:35 -0700
Message-ID: <1206580775-23929-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeSjJ-0003Lz-Gb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 03:19:37 -0700
Received: from nwd2mail11.analog.com ([137.71.25.57])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JeSjI-0001dm-3e
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 03:19:37 -0700
In-Reply-To: <>
References: <>
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
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Bryan Wu <cooloney@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3974

opening/reading/mmaping BF54x and BF52x framebuffer simultaneously
triggers BUG: failure at mm/nommu.c:470/add_nommu_vma()
Add VM_SHARED to the default vm_flags

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/video/bf54x-lq043fb.c    |    2 +-
 drivers/video/bfin-t350mcqb-fb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 986a550..eefba3d 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -384,7 +384,7 @@ static int bfin_bf54x_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	 *   Other flags can be set, and are documented in
 	 *   include/linux/mm.h
 	 */
-	vma->vm_flags |= VM_MAYSHARE;
+	vma->vm_flags |=  VM_MAYSHARE | VM_SHARED;
 
 	return 0;
 }
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 68d5857..c92d457 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -302,7 +302,7 @@ static int bfin_t350mcqb_fb_mmap(struct fb_info *info, struct vm_area_struct *vm
 	 *   Other flags can be set, and are documented in
 	 *   include/linux/mm.h
 	 */
-	vma->vm_flags |= VM_MAYSHARE;
+	vma->vm_flags |= VM_MAYSHARE | VM_SHARED;
 
 	return 0;
 }
-- 
1.5.4.3

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
