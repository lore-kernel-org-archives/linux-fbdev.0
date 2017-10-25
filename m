From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:46:00 +0000
Subject: [RFC 12/14] bootsplash: Add sysfs ABI documentation
Message-Id: <20171025124602.28292-13-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 Documentation/ABI/testing/sysfs-platform-bootsplash | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-bootsplash

diff --git a/Documentation/ABI/testing/sysfs-platform-bootsplash b/Documentation/ABI/testing/sysfs-platform-bootsplash
new file mode 100644
index 000000000000..70c70d018d59
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-bootsplash
@@ -0,0 +1,21 @@
+What:		/sys/devices/platform/bootsplash.0/enabled
+Date:		Oct 2017
+KernelVersion:	4.14
+Contact:	Max Staudt <mstaudt@suse.de>
+Description:
+		Can be set and read.
+
+		0: Splash is disabled.
+		1: Splash is shown whenever fbcon would show a text console
+		   (i.e. no graphical application is running), and a splash
+		   file is loaded.
+
+What:		/sys/devices/platform/bootsplash.0/drop_splash
+Date:		Oct 2017
+KernelVersion:	4.14
+Contact:	Max Staudt <mstaudt@suse.de>
+Description:
+		Can only be set.
+
+		Any value written will cause the splash to be disabled and
+		internal memory structures to be freed.
-- 
2.12.3

