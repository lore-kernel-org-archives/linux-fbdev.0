From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/9] VT binding: Make promcon support
	binding
Date: Sun, 18 Jun 2006 23:35:34 +0800
Message-ID: <449572C6.7010302@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrzVq-0001vS-JL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:34 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzVq-0000XY-BM
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:34 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:34 -0700 (PDT)
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
Cc: ecd@skynet.be, Jakub Jelinek <jj@ultra.linux.cz>, Greg KH <gregkh@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Do not mark promcon_startup() and promcon_init_unimap() as __init

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/promcon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/promcon.c b/drivers/video/console/promcon.c
index 04f42fc..d6e6ad5 100644
--- a/drivers/video/console/promcon.c
+++ b/drivers/video/console/promcon.c
@@ -109,7 +109,7 @@ promcon_end(struct vc_data *conp, char *
 	return b - p;
 }
 
-const char __init *promcon_startup(void)
+const char *promcon_startup(void)
 {
 	const char *display_desc = "PROM";
 	int node;
@@ -133,7 +133,7 @@ const char __init *promcon_startup(void)
 	return display_desc;
 }
 
-static void __init 
+static void
 promcon_init_unimap(struct vc_data *conp)
 {
 	mm_segment_t old_fs = get_fs();
