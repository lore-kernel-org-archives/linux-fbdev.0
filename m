From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/17] nvidiafb: Fix empty macro
Date: Tue, 18 Oct 2005 17:20:24 +0800
Message-ID: <4354BE58.2050304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIy-0000de-1G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:28 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIx-0000v6-Lu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:28 -0700
Received: by zproxy.gmail.com with SMTP id s18so1165348nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:27 -0700 (PDT)
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

Use do {} while(0) for empty reverse_order() macro.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 nv_local.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/nvidia/nv_local.h b/drivers/video/nvidia/nv_local.h
--- a/drivers/video/nvidia/nv_local.h
+++ b/drivers/video/nvidia/nv_local.h
@@ -105,7 +105,7 @@ do {                            \
 	*a = byte_rev[*a];      \
 } while(0)
 #else
-#define reverse_order(l)
+#define reverse_order(l) do { } while(0)
 #endif                          /* __LITTLE_ENDIAN */
 
 #endif				/* __NV_LOCAL_H__ */




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
