From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Tue, 10 Jan 2017 21:28:38 +0000
Subject: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <20170110212838.16175-5-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170110212838.16175-1-manuel.schoelling@gmx.de>
In-Reply-To: <20170110212838.16175-1-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

The impact of the persistent scrollback feature on the code size is
rather small, so the config option is removed. The feature stays
disabled by default and can be enabled by using the boot command line
parameter 'vgacon.scrollback_persistent=3D1' or by setting
VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=3Dy.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/console/Kconfig  | 12 +++++++-----
 drivers/video/console/vgacon.c | 25 ++++++++++++-------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index f500e58f7636..5b71bd905a60 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -47,14 +47,16 @@ config VGACON_SOFT_SCROLLBACK_SIZE
 	  buffers of VGA consoles. Each 64KB will give you approximately
 	  16 80x25 screenfuls of scrollback buffer.
=20
-config VGACON_SOFT_SCROLLBACK_PERSISTENT
-	bool "Persistent Scrollback History for each console"
+config VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT
+	bool "Persistent Scrollback History for each console by default"
 	depends on VGACON_SOFT_SCROLLBACK
 	default n
 	help
-	  Say Y here if the scrollback history should persist when switching
-	  between consoles. Otherwise, the scrollback history will be flushed
-	  each time the console is switched.
+	  Say Y here if the scrollback history should persist by default when
+	  switching between consoles. Otherwise, the scrollback history will be
+	  flushed each time the console is switched. This feature can also be
+	  enabled using the boot command line parameter
+	  'vgacon.scrollback_persistent=3D1'.
=20
 	  This feature might break your tool of choice to flush the scrollback
 	  buffer, e.g. clear(1) will work fine but Debian's clear_console(1)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index ca23d222e029..45a76972495b 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -174,11 +174,9 @@ struct vgacon_scrollback_info {
 };
=20
 static struct vgacon_scrollback_info *vgacon_scrollback_cur;
-#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
 static struct vgacon_scrollback_info vgacon_scrollbacks[MAX_NR_CONSOLES];
-#else
-static struct vgacon_scrollback_info vgacon_scrollbacks[1];
-#endif
+static bool scrollback_persistent =3D \
+	IS_ENABLED(CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT);
=20
 static void vgacon_scrollback_reset(int vc_num, size_t reset_size)
 {
@@ -213,20 +211,19 @@ static void vgacon_scrollback_init(int vc_num)
=20
 static void vgacon_scrollback_switch(int vc_num)
 {
-#ifndef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
-	vc_num =3D 0;
-#endif
+	if (!scrollback_persistent)
+		vc_num =3D 0;
=20
 	if (!vgacon_scrollbacks[vc_num].data) {
 		vgacon_scrollback_init(vc_num);
 	} else {
-#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
-		vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
-#else
-		size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+		if (scrollback_persistent) {
+			vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
+		} else {
+			size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
=20
-		vgacon_scrollback_reset(vc_num, size);
-#endif
+			vgacon_scrollback_reset(vc_num, size);
+		}
 	}
 }
=20
@@ -1423,4 +1420,6 @@ const struct consw vga_con =3D {
 };
 EXPORT_SYMBOL(vga_con);
=20
+module_param_named(scrollback_persistent, scrollback_persistent, bool, 000=
0);
+MODULE_PARM_DESC(scrollback_persistent, "Enable persistent scrollback for =
all vga consoles");
 MODULE_LICENSE("GPL");
--=20
2.11.0

