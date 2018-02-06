From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 06 Feb 2018 07:52:26 +0000
Subject: [PATCH v2 2/3] backlight: adp5520: document sysfs attributes
Message-Id: <dfaf338847058807a8b897bd4e555b6a47efeece.1517902411.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1517902411.git.aishpant@gmail.com>
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interface of adp5520/adp5501 analog devices
backlight driver by reading code and looking through git commit logs.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../ABI/testing/sysfs-class-backlight-adp5520      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp5520 b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
new file mode 100644
index 000000000000..34b6ebafa210
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
@@ -0,0 +1,31 @@
+sysfs interface for analog devices adp5520(01) backlight driver
+---------------------------------------------------------------
+
+The backlight brightness control operates at three different levels for the
+adp5520 and adp5501 devices: daylight (level 1), office (level 2) and dark
+(level 3). By default the brightness operates at the daylight brightness level.
+
+What:		/sys/class/backlight/<backlight>/daylight_max
+What:		/sys/class/backlight/<backlight>/office_max
+What:		/sys/class/backlight/<backlight>/dark_max
+Date:		Sep, 2009
+KernelVersion:	v2.6.32
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Maximum current setting for the backlight when brightness
+		is at one of the three levels (daylight, office or dark). This
+		is an input code between 0 and 127, which is transformed to a
+		value between 0 mA and 30 mA using linear or non-linear
+		algorithms.
+
+What:		/sys/class/backlight/<backlight>/daylight_dim
+What:		/sys/class/backlight/<backlight>/office_dim
+What:		/sys/class/backlight/<backlight>/dark_dim
+Date:		Sep, 2009
+KernelVersion:	v2.6.32
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Dim current setting for the backlight when brightness is at
+		one of the three levels (daylight, office or dark). This is an
+		input code between 0 and 127, which is transformed to a value
+		between 0 mA and 30 mA using linear or non-linear algorithms.
-- 
2.16.1

