From: Aishwarya Pant <aishpant@gmail.com>
Date: Fri, 26 Jan 2018 14:53:10 +0000
Subject: [PATCH 2/5] backlight: lp855x: document sysfs attributes
Message-Id: <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
In-Reply-To: <cover.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Milo Kim <milo.kim@ti.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interface of Texas Instruments lp855x
backlight driver by reading code and looking through git commit logs.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-class-backlight-lp855x          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp855x

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp855x b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
new file mode 100644
index 000000000000..5b9d38958875
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
@@ -0,0 +1,19 @@
+sysfs interface for Texas Instruments lp855x backlight driver
+------------------------------------------------------------
+
+What:		/sys/class/backlight/<backlight>/chip_id
+Date:		Mar, 2012
+KernelVersion:	v3.10
+Contact:	Milo Kim <milo.kim@ti.com>
+Description:
+		(RO) Displays the lp8755x chip id. Possible values are:
+		lp8550, lp8551, lp8552, lp8553, lp8555, lp8556 or lp8557.
+
+
+What:		/sys/class/backlight/<backlight>/bl_ctl_mode
+Date:		Mar, 2012
+KernelVersion:	v3.10
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) Displays whether the brightness is controlled by the pwm
+		input("pwm based) or the i2c register("register based").
-- 
2.16.1

