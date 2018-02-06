From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 06 Feb 2018 07:51:42 +0000
Subject: [PATCH v2 1/3] backlight: lm3639: document sysfs attributes
Message-Id: <aa8c36f78ba1228ac7f8d377797b2f1b11574b3b.1517902411.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1517902411.git.aishpant@gmail.com>
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interfaces of Texas Instruments lm3639
backlight + flash led driver chip by looking through git commits and
reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- Update contact information

 Documentation/ABI/testing/sysfs-class-backlight-lm3639 | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lm3639 b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
new file mode 100644
index 000000000000..f7e92a82ea25
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
@@ -0,0 +1,11 @@
+sysfs interface for Texas Instruments lm3639 backlight + flash led driver chip
+------------------------------------------------------------------------------
+
+What:		/sys/class/backlight/<backlight>/bled_mode
+Date:		Oct, 2012
+KernelVersion:	v3.10
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(WO) Write to the backlight mapping mode. The backlight current
+		can be mapped for either exponential (value "0") or linear
+		mapping modes (default).
-- 
2.16.1

