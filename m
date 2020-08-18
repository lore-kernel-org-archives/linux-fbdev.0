From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 18 Aug 2020 08:56:49 +0000
Subject: [PATCH 2/8] newport_con: fix no return statement in newport_show_logo
Message-Id: <20200818085655.12071-2-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200818085655.12071-1-jslaby@suse.cz>
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

When CONFIG_LOGO_SGI_CLUT224 is unset, newport_show_logo contains no
return, despite it should return a pointer. Add one returning NULL to
fix a compiler warning:
   drivers/video/console/newport_con.c: In function 'newport_show_logo':
   drivers/video/console/newport_con.c:132:1: warning: no return statement in function returning non-void

Note that the caller expects NULL from the function already.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-mips@vger.kernel.org
---
 drivers/video/console/newport_con.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 72f146d047d9..4d9110393479 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -131,6 +131,8 @@ static const struct linux_logo *newport_show_logo(void)
 		npregs->go.hostrw0 = *data++ << 24;
 
 	return logo;
+#else
+	return NULL;
 #endif /* CONFIG_LOGO_SGI_CLUT224 */
 }
 
-- 
2.28.0
