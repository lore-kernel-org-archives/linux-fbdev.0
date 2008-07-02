From: Ben Dooks <ben-linux@fluff.org>
Subject: SM501: Fixup allocation code to be 64bit
	resource compliant
Date: Wed, 02 Jul 2008 21:35:48 +0100
Message-ID: <20080702203548.731030150@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KE93k-0000CZ-64 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Jul 2008 13:36:12 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KE93i-0004ch-KL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Jul 2008 13:36:12 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-ressizefix-v2.patch
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>

As pointed out by Andrew Morton, we have a problem when setting
the 64bit resources option. Alter the allocation routines to
remove the need to use the start and end fields, use the
proper HEAD_PANEL/HEAD_CRT and update the comments.

Note, we also fix the bug where we failed to check the size of the
CRT memory allocation.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc8-quilt3/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.26-rc8-quilt3.orig/drivers/video/sm501fb.c	2008-07-02 10:59:59.000000000 +0100
+++ linux-2.6.26-rc8-quilt3/drivers/video/sm501fb.c	2008-07-02 12:25:01.000000000 +0100
@@ -48,10 +48,15 @@ enum sm501_controller {
 	HEAD_PANEL	= 1,
 };
 
-/* SM501 memory address */
+/* SM501 memory address. 
+ *
+ * This structure is used to track memory usage within the SM501 framebuffer
+ * allocation. The sm_addr field is stored as an offset as it is often used
+ * against both the physical and mapped addresses.
+ */
 struct sm501_mem {
 	unsigned long	 size;
-	unsigned long	 sm_addr;
+	unsigned long	 sm_addr;	/* offset from base of sm501 fb. */
 	void __iomem	*k_addr;
 };
 
@@ -142,37 +147,56 @@ static inline void sm501fb_sync_regs(str
 static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
 			   unsigned int why, size_t size)
 {
-	unsigned int ptr = 0;
-	unsigned int end;
+	struct sm501fb_par *par;
 	struct fb_info *fbi;
+	unsigned int ptr;
+	unsigned int end;
 
 	switch (why) {
 	case SM501_MEMF_CURSOR:
 		ptr = inf->fbmem_len - size;
-		inf->fbmem_len = ptr;
+		inf->fbmem_len = ptr;	/* adjust available memory. */
 		break;
 
 	case SM501_MEMF_PANEL:
 		ptr = inf->fbmem_len - size;
-		fbi = inf->fb[0];
+		fbi = inf->fb[HEAD_CRT];
 
 		if (fbi && ptr < fbi->fix.smem_len)
 			return -ENOMEM;
 
+		if (ptr < 0)
+			return -ENOMEM;
+
 		break;
 
 	case SM501_MEMF_CRT:
 		ptr = 0;
+
+		/* check to see if we have panel memory allocated
+		 * which would put an limit on available memory. */
+
+		fbi = inf->fb[HEAD_PANEL];
+		if (fbi) {
+			par = fbi->par;
+			end = par->screen.k_addr ? par->screen.sm_addr : inf->fbmem_len;
+		} else
+			end = inf->fbmem_len;
+
+		if ((ptr + size) > end)
+			return -ENOMEM;
+
 		break;
 
 	case SM501_MEMF_ACCEL:
-		fbi = inf->fb[0];
+		fbi = inf->fb[HEAD_CRT];
 		ptr = fbi ? fbi->fix.smem_len : 0;
 
-		fbi = inf->fb[1];
-		if (fbi)
-			end = (fbi->fix.smem_start - inf->fbmem_res->start);
-		else
+		fbi = inf->fb[HEAD_PANEL];
+		if (fbi) {
+			par = fbi->par;
+			end = par->screen.sm_addr;
+		} else
 			end = inf->fbmem_len;
 
 		if ((ptr + size) > end)

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
