From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/10] nvidiafb: Fixed mirrored characters in big endian machines
Date: Fri, 02 Sep 2005 05:37:33 +0800
Message-ID: <4317749D.9000605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2Z-0004lD-LV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:11 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2Y-0004OI-1m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:11 -0700
Received: by wproxy.gmail.com with SMTP id i4so426760wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:03 -0700 (PDT)
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

    nvidiafb_imageblit converts the bitdata stream from big_endian to
    little endian.  This produces mirrored characters when machine is
    big_endian. Do not endian convert on big endian machines.
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 nv_local.h |    4 ++++
 1 files changed, 4 insertions(+)


diff --git a/drivers/video/nvidia/nv_local.h b/drivers/video/nvidia/nv_local.h
--- a/drivers/video/nvidia/nv_local.h
+++ b/drivers/video/nvidia/nv_local.h
@@ -95,6 +95,7 @@
 
 #define READ_GET(par) (NV_RD32(&(par)->FIFO[0x0011], 0) >> 2)
 
+#ifdef __LITTLE_ENDIAN
 #define reverse_order(l)        \
 do {                            \
 	u8 *a = (u8 *)(l);      \
@@ -103,5 +104,8 @@ do {                            \
 	*a = byte_rev[*a], a++; \
 	*a = byte_rev[*a];      \
 } while(0)
+#else
+#define reverse_order(l) 
+#endif                          /* __LITTLE_ENDIAN */
 
 #endif				/* __NV_LOCAL_H__ */



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
