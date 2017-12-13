From: Max Staudt <mstaudt@suse.de>
Date: Wed, 13 Dec 2017 19:47:53 +0000
Subject: [RFC PATCH v2 11/13] bootsplash: sysfs entries to load and unload files
Message-Id: <20171213194755.3409-12-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
In-Reply-To: <20171213194755.3409-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, mstaudt@suse.de, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

Users can use this to replace their splash screen at runtime by writing
a path and filename to /sys/devices/platform/bootsplash.0/load_file and
making sure the splash is enabled.

Notes:
  - The path has to be a path in /lib/firmware since request_firmware()
    is used to fetch the data.
  - When setting the splash from the shell, echo -n has to be used as
    any trailing '\n' newline will be interpreted as part of the path.

Writes to /sys/devices/platform/bootsplash.0/drop_splash will cause the
current splash theme to be freed and the console to switch to text mode,

Signed-off-by: Max Staudt <mstaudt@suse.de>
---
 .../ABI/testing/sysfs-platform-bootsplash          | 32 +++++++++++++
 Documentation/bootsplash.rst                       |  8 ++++
 drivers/video/fbdev/core/bootsplash.c              | 54 ++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-bootsplash b/Documentation/ABI/testing/sysfs-platform-bootsplash
index 742c7b035ded..f8f4b259220e 100644
--- a/Documentation/ABI/testing/sysfs-platform-bootsplash
+++ b/Documentation/ABI/testing/sysfs-platform-bootsplash
@@ -9,3 +9,35 @@ Description:
 		1: Splash is shown whenever fbcon would show a text console
 		   (i.e. no graphical application is running), and a splash
 		   file is loaded.
+
+What:		/sys/devices/platform/bootsplash.0/drop_splash
+Date:		Oct 2017
+KernelVersion:	4.14
+Contact:	Max Staudt <mstaudt@suse.de>
+Description:
+		Can only be set.
+
+		Any value written will cause the current splash theme file
+		to be unloaded and the text console to be redrawn.
+
+What:		/sys/devices/platform/bootsplash.0/load_file
+Date:		Oct 2017
+KernelVersion:	4.14
+Contact:	Max Staudt <mstaudt@suse.de>
+Description:
+		Can only be set.
+
+		Any value written will cause the splash to be disabled and
+		internal memory structures to be freed.
+
+		A firmware path written will cause a new theme file to be
+		loaded and the current bootsplash to be replaced.
+		The current enabled/disabled status is not touched.
+		If the splash is already active, it will be redrawn.
+
+		The path has to be a path in /lib/firmware since
+		request_firmware() is used to fetch the data.
+
+		When setting the splash from the shell, echo -n has to be
+		used as any trailing '\n' newline will be interpreted as
+		part of the path.
diff --git a/Documentation/bootsplash.rst b/Documentation/bootsplash.rst
index 8bd6805af6bf..d793612ebf2e 100644
--- a/Documentation/bootsplash.rst
+++ b/Documentation/bootsplash.rst
@@ -58,6 +58,14 @@ sysfs run-time configuration
   a splash theme file is also loaded.
 
 
+``/sys/devices/platform/bootsplash.0/drop_splash``
+  Unload splash data and free memory.
+
+``/sys/devices/platform/bootsplash.0/load_file``
+  Load a splash file from ``/lib/firmware/``.
+  Note that trailing newlines will be interpreted as part of the file name.
+
+
 
 Kconfig
 ===diff --git a/drivers/video/fbdev/core/bootsplash.c b/drivers/video/fbdev/core/bootsplash.c
index 13fcaabbc2ca..16cb0493629d 100644
--- a/drivers/video/fbdev/core/bootsplash.c
+++ b/drivers/video/fbdev/core/bootsplash.c
@@ -251,11 +251,65 @@ static ssize_t splash_store_enabled(struct device *device,
 	return count;
 }
 
+static ssize_t splash_store_drop_splash(struct device *device,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct splash_file_priv *fp;
+
+	if (!buf || !count || !splash_state.file)
+		return count;
+
+	mutex_lock(&splash_state.data_lock);
+	fp = splash_state.file;
+	splash_state.file = NULL;
+	mutex_unlock(&splash_state.data_lock);
+
+	/* Redraw the text console */
+	schedule_work(&splash_state.work_redraw_vc);
+
+	bootsplash_free_file(fp);
+
+	return count;
+}
+
+static ssize_t splash_store_load_file(struct device *device,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct splash_file_priv *fp, *fp_old;
+
+	if (!count)
+		return 0;
+
+	fp = bootsplash_load_firmware(&splash_state.splash_device->dev,
+				      buf);
+
+	if (!fp)
+		return -ENXIO;
+
+	mutex_lock(&splash_state.data_lock);
+	fp_old = splash_state.file;
+	splash_state.splash_fb = NULL;
+	splash_state.file = fp;
+	mutex_unlock(&splash_state.data_lock);
+
+	/* Update the splash or text console */
+	schedule_work(&splash_state.work_redraw_vc);
+
+	bootsplash_free_file(fp_old);
+	return count;
+}
+
 static DEVICE_ATTR(enabled, 0644, splash_show_enabled, splash_store_enabled);
+static DEVICE_ATTR(drop_splash, 0200, NULL, splash_store_drop_splash);
+static DEVICE_ATTR(load_file, 0200, NULL, splash_store_load_file);
 
 
 static struct attribute *splash_dev_attrs[] = {
 	&dev_attr_enabled.attr,
+	&dev_attr_drop_splash.attr,
+	&dev_attr_load_file.attr,
 	NULL
 };
 
-- 
2.12.3

