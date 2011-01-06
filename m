From: Greg Kroah-Hartman <gregkh@suse.de>
Date: Thu, 06 Jan 2011 22:22:59 +0000
Subject: [PATCH 10/36] VIDEO: xen-fb, switch to for_each_console
Message-Id: <1294352605-31906-10-git-send-email-gregkh@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110106215404.GA30624@kroah.com>
In-Reply-To: <20110106215404.GA30624@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Use newly added for_each_console for iterating consoles.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
Cc: xen-devel@lists.xensource.com
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/video/xen-fbfront.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 428d273..4abb0b9 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -492,7 +492,7 @@ xenfb_make_preferred_console(void)
 		return;
 
 	acquire_console_sem();
-	for (c = console_drivers; c; c = c->next) {
+	for_each_console(c) {
 		if (!strcmp(c->name, "tty") && c->index = 0)
 			break;
 	}
-- 
1.7.3.2

