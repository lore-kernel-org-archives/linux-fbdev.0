From: Scot Doyle <lkml14@scotdoyle.com>
Date: Thu, 19 May 2016 04:21:53 +0000
Subject: [PATCH] fbcon: use default if cursor blink interval is not valid
Message-Id: <alpine.DEB.2.10.1605182252230.12118@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com> <20160517204912.GA29719@amd> <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com> <alpine.DEB.2.10.1605181519540.8967@laptop>
 <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
In-Reply-To: <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: David Daney <david.daney@cavium.com>, Ming Lei <ming.lei@canonical.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, ddaney.cavm@gmail.com, lkml14@scotdoyle.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Two current [1] and three previous [2] systems locked during boot
because the cursor flash timer was set using an ops->cur_blink_jiffies
value of 0. Previous patches attempted to solve the problem by moving
variable initialization earlier in the setup sequence [2].

Use the normal cursor blink default interval of 200 ms if
ops->cur_blink_jiffies is not in the range specified in commit
bd63364caa8d. Since invalid values are not used, specific system
initialization timings should not cause lockups.

[1] https://bugs.launchpad.net/bugs/1574814
[2] see commits: 2a17d7e80f1d, f235f664a8af, a1e533ec07d5

Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
Cc: <stable@vger.kernel.org> [v4.2]
---
 drivers/video/console/fbcon.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6e92917..da61d87 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -396,13 +396,23 @@ static void fb_flashcursor(struct work_struct *work)
 	console_unlock();
 }
 
+static int cursor_blink_jiffies(int candidate)
+{
+	if (candidate >= msecs_to_jiffies(50) &&
+	    candidate <= msecs_to_jiffies(USHRT_MAX))
+		return candidate;
+	else
+		return HZ / 5;
+}
+
 static void cursor_timer_handler(unsigned long dev_addr)
 {
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	queue_work(system_power_efficient_wq, &info->queue);
-	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
+	mod_timer(&ops->cursor_timer, jiffies +
+	    cursor_blink_jiffies(ops->cur_blink_jiffies));
 }
 
 static void fbcon_add_cursor_timer(struct fb_info *info)
@@ -417,7 +427,8 @@ static void fbcon_add_cursor_timer(struct fb_info *info)
 
 		init_timer(&ops->cursor_timer);
 		ops->cursor_timer.function = cursor_timer_handler;
-		ops->cursor_timer.expires = jiffies + ops->cur_blink_jiffies;
+		ops->cursor_timer.expires = jiffies +
+		    cursor_blink_jiffies(ops->cur_blink_jiffies);
 		ops->cursor_timer.data = (unsigned long ) info;
 		add_timer(&ops->cursor_timer);
 		ops->flags |= FBCON_FLAGS_CURSOR_TIMER;
@@ -709,7 +720,6 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 	}
 
 	if (!err) {
-		ops->cur_blink_jiffies = HZ / 5;
 		info->fbcon_par = ops;
 
 		if (vc)
@@ -957,7 +967,6 @@ static const char *fbcon_startup(void)
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
-	ops->cur_blink_jiffies = HZ / 5;
 	info->fbcon_par = ops;
 	p->con_rotate = initial_rotation;
 	set_blitting_type(vc, info);
-- 
2.1.4

