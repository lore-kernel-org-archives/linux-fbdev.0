From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] VT binding: Make sticon support
	binding
Date: Sun, 18 Jun 2006 23:37:14 +0800
Message-ID: <4495732A.3000407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrzVx-0001vZ-4k for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:41 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzVv-0000XY-Rx
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:41 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:39 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Deller <deller@gmx.de>, Greg KH <gregkh@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Do not mark sticon_startup() as __init

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/sticon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index fd5940f..45c4f22 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -75,7 +75,7 @@ static inline void cursor_undrawn(void)
     cursor_drawn = 0;
 }
 
-static const char *__init sticon_startup(void)
+static const char *sticon_startup(void)
 {
     return "STI console";
 }
