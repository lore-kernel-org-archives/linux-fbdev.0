From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/17] console: Fix compile error
Date: Tue, 18 Oct 2005 17:23:11 +0800
Message-ID: <4354BEFF.9070400@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyJW-0000fZ-B6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:44:02 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyJW-0000dG-95
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:44:02 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:44:02 -0700 (PDT)
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

Fix following compile error (From Kernel Bugzilla Bug 5427):

include/linux/console_struct.h:53: error: field `vt_mode' has incomplete type

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 console_struct.h |    2 ++
 1 files changed, 2 insertions(+)


diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -9,6 +9,8 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+#include <linux/vt.h>
+
 struct vt_struct;
 
 #define NPAR 16




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
