From: Aishwarya Pant <aishpant@gmail.com>
Date: Fri, 26 Jan 2018 14:54:06 +0000
Subject: [PATCH 3/5] backlight: lm3639: document sysfs attributes
Message-Id: <3b913654039eefb786abd6a29b99a74b8063830c.1516978005.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
In-Reply-To: <cover.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interfaces of Texas Instruments lm3639
backlight + flash led driver chip by looking through git commits and
reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-backlight-lm3639 | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lm3639 b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
new file mode 100644
index 000000000000..ec87dc8f4395
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
@@ -0,0 +1,13 @@
+sysfs interface for Texas Instruments lm3639 backlight + flash led driver chip
+------------------------------------------------------------------------------
+
+What:		/sys/class/backlight/<backlight>/bled_mode
+Date:		Oct, 2012
+KernelVersion:	v3.10
+Contact:	Lee Jones <lee.jones@linaro.org>,
+		Daniel Thompson <daniel.thompson@linaro.org>,
+		Jingoo Han <jingoohan1@gmail.com>
+Description:
+		(WO) Write to the backlight mapping mode. The backlight current
+		can be mapped for either exponential (value "0") or linear
+		mapping modes (default).
-- 
2.16.1

