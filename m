From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/10] i810fb: Stop LCD displays from flickering
Date: Fri, 02 Sep 2005 05:45:27 +0800
Message-ID: <43177677.7020107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2x-0004mI-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:35 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2w-0004Tp-I8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:35 -0700
Received: by wproxy.gmail.com with SMTP id 37so418738wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:28 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Stop LCD displays from flickering during high loads.
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 i810_main.c |    2 ++
 1 files changed, 2 insertions(+)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -311,6 +311,8 @@ static void i810_hires(u8 __iomem *mmio)
 	val = i810_readb(CR_DATA_CGA, mmio);
 	i810_writeb(CR_INDEX_CGA, mmio, CR80);
 	i810_writeb(CR_DATA_CGA, mmio, val | 1);
+	/* Stop LCD displays from flickering */
+	i810_writel(MEM_MODE, mmio, i810_readl(MEM_MODE, mmio) | 4);
 }
 
 /**



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
