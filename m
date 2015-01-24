From: Scot Doyle <lkml14@scotdoyle.com>
Date: Sat, 24 Jan 2015 17:41:50 +0000
Subject: [PATCH v2 2/2] fbcon: expose cursor blink interval via sysfs
Message-Id: <alpine.DEB.2.11.1501241739420.2516@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501240109060.3489@localhost.localdomain> <alpine.DEB.2.11.1501240117400.3639@localhost.localdomain> <CAMuHMdX2cs_JW4QEC=E=m2Z6gg=kZE5PnHBQYZ5RnFp1E9m_fQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX2cs_JW4QEC=E=m2Z6gg=kZE5PnHBQYZ5RnFp1E9m_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The fbcon cursor, when set to blink, is hardcoded to toggle display state
five times per second. Expose this setting via
/sys/class/graphics/fbcon/cursor_blink_ms

Values written to the interface set the approximate time interval in
milliseconds between cursor toggles, from 1 to 32767. Since the interval
is stored internally as a number of jiffies, the millisecond value read
from the interface may not exactly match the entered value.

An outstanding blink timer is reset after a new value is entered.

If the cursor blink is disabled, either via the 'cursor_blink' boolean
setting or some other mechanism, the 'cursor_blink_ms' setting may still
be modified. The new value will be used if the blink is reactivated.

Tested with intelfb.

Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
v2:  Use kstrtos16() instead of kstrtoul() and min_t(). Thanks Geert!

 drivers/video/console/fbcon.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 7a2030b..7b6815d 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3495,11 +3495,84 @@ err:
 	return count;
 }
 
+static ssize_t show_cursor_blink_ms(struct device *device,
+				    struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info;
+	struct fbcon_ops *ops;
+	int idx, ms = -1;
+
+	if (fbcon_has_exited)
+		return 0;
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
+	if (!ops)
+		goto err;
+
+	ms = jiffies_to_msecs(ops->blink_jiffies);
+
+err:
+	console_unlock();
+	return snprintf(buf, PAGE_SIZE, "%d\n", ms);
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
+
+	if (fbcon_has_exited)
+		return count;
+
+	console_lock();
+	idx = con2fb_map[fg_console];
+
+	if (idx = -1 || registered_fb[idx] = NULL)
+		goto err;
+
+	info = registered_fb[idx];
+
+	if (!info->fbcon_par)
+		goto err;
+
+	ops = info->fbcon_par;
+
+	if (!ops)
+		goto err;
+
+	if (!kstrtos16(buf, 0, &ms)) {
+		ops->blink_jiffies = max_t(int, msecs_to_jiffies(ms), 1);
+		if (info->queue.func = fb_flashcursor &&
+		    ops->flags & FBCON_FLAGS_CURSOR_TIMER) {
+			fbcon_del_cursor_timer(info);
+			fbcon_add_cursor_timer(info);
+		}
+	}
+
+err:
+	console_unlock();
+	return count;
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

