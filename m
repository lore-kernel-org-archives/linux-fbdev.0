From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 06 Feb 2018 19:52:13 +0000
Subject: [PATCH v2] Documentation/ABI: add sysfs interface for s6e63m0 lcd driver
Message-Id: <20180206194013.GA25380@mordor.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, InKi Dae <inki.dae@samsung.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Document sysfs attributes of s6e63m0 lcd panel driver by looking through
git logs and reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Update contact information

 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0

diff --git a/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
new file mode 100644
index 000000000000..ae0a2d3dcc07
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
@@ -0,0 +1,27 @@
+sysfs interface for the S6E63M0 AMOLED LCD panel driver
+-------------------------------------------------------
+
+What:		/sys/class/lcd/<lcd>/gamma_mode
+Date:		May, 2010
+KernelVersion:	v2.6.35
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(RW) Read or write the gamma mode. Following three modes are
+		supported:
+		0 - gamma value 2.2,
+		1 - gamma value 1.9 and
+		2 - gamma value 1.7.
+
+
+What:		/sys/class/lcd/<lcd>/gamma_table
+Date:		May, 2010
+KernelVersion:	v2.6.35
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(RO) Displays the size of the gamma table i.e. the number of
+		gamma modes available.
+
+This is a backlight lcd driver. These interfaces are an extension to the API
+documented in Documentation/ABI/testing/sysfs-class-lcd and in
+Documentation/ABI/stable/sysfs-class-backlight (under
+/sys/class/backlight/<backlight>/).
-- 
2.16.1

