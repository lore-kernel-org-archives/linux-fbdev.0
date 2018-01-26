From: Aishwarya Pant <aishpant@gmail.com>
Date: Fri, 26 Jan 2018 14:55:42 +0000
Subject: [PATCH 5/5] backlight: adp8860: document sysfs attributes
Message-Id: <c7c9c2b13698320b590b52b7bf5796a87df49bd5.1516978005.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
In-Reply-To: <cover.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Add documentation for sysfs interface of adp8860 series backlight
devices by reading through code and git commits.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++=
++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860

diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp8860 b/Docu=
mentation/ABI/testing/sysfs-class-backlight-adp8860
new file mode 100644
index 000000000000..54d61c788b1b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
@@ -0,0 +1,54 @@
+sysfs interface for analog devices adp8860 backlight driver
+-----------------------------------------------------------
+
+The backlight brightness control operates at three different levels for the
+adp8860, adp8861 and adp8863 devices: daylight (level 1), office (level 2)=
 and
+dark (level 3). By default the brightness operates at the daylight brightn=
ess
+level.
+
+What:		/sys/class/backlight/<backlight>/ambient_light_level
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RO) 13-bit conversion value for the first light sensor=E2=80=94high
+		byte (Bit 12 to Bit 8). The value is updated every 80 ms (when
+		the light sensor is enabled).
+
+
+What:		/sys/class/backlight/<backlight>/ambient_light_zone
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Read or write the specific level at which the backlight
+		operates. Value "0" enables automatic ambient light sensing, and
+		values "1", "2" or "3" set the control to daylight, office or
+		dark respectively.
+
+
+What:		/sys/class/backlight/<backlight>/l1_daylight_max
+What:		/sys/class/backlight/<backlight>/l2_office_max
+What:		/sys/class/backlight/<backlight>/l3_dark_max
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Maximum current setting for the backlight when brightness
+		is at one of the three levels (daylight, office or dark). This
+		is an input code between 0 and 127, which is transformed to a
+		value between 0 mA and 30 mA using linear or non-linear
+		algorithms.
+
+
+What:		/sys/class/backlight/<backlight>/l1_daylight_dim
+What:		/sys/class/backlight/<backlight>/l2_office_dim
+What:		/sys/class/backlight/<backlight>/l3_dark_dim
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RW) Dim current setting for the backlight when brightness is at
+		one of the three levels (daylight, office or dark). This is an
+		input code between 0 and 127, which is transformed to a value
+		between 0 mA and 30 mA using linear or non-linear algorithms.
--=20
2.16.1

