From: Jiri Slaby <jslaby@suse.cz>
Date: Thu, 04 Nov 2010 15:20:22 +0000
Subject: [PATCH v2 3/5] VIDEO: xen-fb, switch to for_each_console
Message-Id: <1288884024-23873-3-git-send-email-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1288884024-23873-1-git-send-email-jslaby@suse.cz>
In-Reply-To: <1288884024-23873-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: werner@suse.de, alan@lxorguk.ukuu.org.uk, gregkh@suse.de, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org

Use newly added for_each_console for iterating consoles.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
Cc: xen-devel@lists.xensource.com
Cc: linux-fbdev@vger.kernel.org
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
1.7.3.1


