From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 23 Jan 2018 14:51:31 +0000
Subject: [PATCH] Documentation/ABI: add sysfs interface for s6e63m0 lcd driver
Message-Id: <20180123143931.GA9687@mordor.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>

Document sysfs attributes of s6e63m0 lcd panel driver by looking through
git logs and reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0

diff --git a/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
new file mode 100644
index 000000000000..db056bd38404
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
@@ -0,0 +1,22 @@
+sysfs interface for the S6E63M0 AMOLED LCD panel driver
+-------------------------------------------------------
+
+What:		/sys/class/lcd/<lcd>/gamma_mode
+Date:		May, 2010
+KernelVersion:	v2.6.35
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
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
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) Displays the size of the gamma table i.e. the number of
+		gamma modes available.
-- 
2.16.1

