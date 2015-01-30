From: Scot Doyle <lkml14@scotdoyle.com>
Date: Fri, 30 Jan 2015 08:44:42 +0000
Subject: [PATCH v5 2/2] fbcon: expose cursor blink interval via sysfs
Message-Id: <alpine.DEB.2.11.1501300843200.2423@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501300836140.2305@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501300836140.2305@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

fbcon toggles cursor display state every 200 milliseconds when blinking.
Since users prefer different toggle intervals, expose the interval via
/sys/class/graphics/fbcon/cursor_blink_ms so that it may be customized.

Values written to the interface set the approximate time interval in
milliseconds between cursor toggles, from 1 to 32767. Since the interval
is stored internally as a number of jiffies, the millisecond value read
from the interface may not exactly match the entered value.

An outstanding blink timer is reset after a new value is entered.

If the cursor blink is disabled, either via the 'cursor_blink' boolean
setting or some other mechanism, the 'cursor_blink_ms' setting may still
be modified. The new value will be used if the blink is reactivated.

Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
 drivers/video/console/fbcon.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 7a2030b..f026f65 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3495,11 +3495,77 @@ err:
 	return count;
 }
 
+static ssize_t show_cursor_blink_ms(struct device *device,
+				    struct device_attribute *attr, char *buf)
+{
+	struct fbcon_ops *ops;
+	int idx, ms = -1;
+
+	if (fbcon_has_exited)
+		return -ENODEV;
+
+	console_lock();
+	idx = con2fb_map[fg_console];
+
+	if (idx != -1 && registered_fb[idx] != NULL) {
+		ops = ((struct fb_info *)registered_fb[idx])->fbcon_par;
+		if (ops != NULL)
+			ms = jiffies_to_msecs(ops->blink_jiffies);
+	}
+
+	console_unlock();
+	return ms < 0 ? -ENODEV : scnprintf(buf, PAGE_SIZE, "%d\n", ms);
+}
+
+static ssize_t store_cursor_blink_ms(struct device *device,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct fb_info *info;
+	struct fbcon_ops *ops;
+	int idx;
+	short ms;
+	int r = -ENODEV;
+
+	if (fbcon_has_exited)
+		return r;
+
+	console_lock();
+	idx = con2fb_map[fg_console];
+
+	if (idx = -1 || registered_fb[idx] = NULL)
+		goto err;
+
+	info = registered_fb[idx];
+	ops = info->fbcon_par;
+
+	if (ops = NULL)
+		goto err;
+
+	if (!kstrtos16(buf, 0, &ms) && ms > 0) {
+		//ops->blink_jiffies = max_t(int, msecs_to_jiffies(ms), 1);
+		ops->blink_jiffies = msecs_to_jiffies(ms);
+		if (info->queue.func = fb_flashcursor &&
+		    ops->flags & FBCON_FLAGS_CURSOR_TIMER) {
+			fbcon_del_cursor_timer(info);
+			fbcon_add_cursor_timer(info);
+		}
+		r = count;
+	} else
+		r = -EINVAL;
+
+err:
+	console_unlock();
+	return r;
+}
+
 static struct device_attribute device_attrs[] = {
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
 	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
 	       store_cursor_blink),
+	__ATTR(cursor_blink_ms, S_IRUGO|S_IWUSR, show_cursor_blink_ms,
+	       store_cursor_blink_ms),
 };
 
 static int fbcon_init_device(void)
-- 
2.1.4

