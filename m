From: Scot Doyle <lkml14@scotdoyle.com>
Date: Fri, 09 Oct 2015 15:08:10 +0000
Subject: [PATCH] fbcon: initialize blink interval before calling fb_set_par
Message-Id: <alpine.DEB.2.11.1510091500100.1816@local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2505354.BllTl4uaOg@new-mexico> <alpine.DEB.2.11.1510030350110.20774@local> <3998353.WdEhcyQWSK@new-mexico>
In-Reply-To: <3998353.WdEhcyQWSK@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alistair Popple <alistair@popple.id.au>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, airlied@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Since commit 27a4c827c34ac4256a190cc9d24607f953c1c459
    fbcon: use the cursor blink interval provided by vt

a PPC64LE kernel fails to boot when fbcon_add_cursor_timer uses an
uninitialized ops->cur_blink_jiffies. Prevent by initializing
in fbcon_init before the call to info->fbops->fb_set_par.

Reported-and-tested-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
 drivers/video/console/fbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1aaf893..92f3949 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1093,6 +1093,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 		con_copy_unimap(vc, svc);
 
 	ops = info->fbcon_par;
+	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 	p->con_rotate = initial_rotation;
 	set_blitting_type(vc, info);
 
-- 
2.1.4

