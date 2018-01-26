From: Aishwarya Pant <aishpant@gmail.com>
Date: Fri, 26 Jan 2018 14:50:18 +0000
Subject: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-Id: <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
In-Reply-To: <cover.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Milo Kim <milo.kim@ti.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interfaces of lp8788 backlight driver by
looking through the code and the git commit history.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
new file mode 100644
index 000000000000..c0e565c8d63d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
@@ -0,0 +1,10 @@
+sysfs interface for Texas Instruments lp8788 mfd backlight driver
+-----------------------------------------------------------------
+
+What:		/sys/class/backlight/<backlight>/bl_ctl_mode
+Date:		Feb, 2013
+KernelVersion:	v3.10
+Contact:	Milo Kim <milo.kim@ti.com>
+Description:
+		(RO) Displays whether the brightness is controlled by the PWM
+		input("PWM based") or the I2C register("Register based").
-- 
2.16.1

