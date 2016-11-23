From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 08:03:11 +0000
Subject: [RFC PATCH 1/3] staging: remove xgifb
Message-Id: <1479888193-23908-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

Since the fbdev framework is in maintenance mode and all new display
drivers should be made with the DRM framework, remove xgifb from
staging. Especially as xgifb has been in staging for 6 years...

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 MAINTAINERS                         |    5 -
 drivers/staging/Kconfig             |    2 -
 drivers/staging/Makefile            |    1 -
 drivers/staging/xgifb/Kconfig       |   11 -
 drivers/staging/xgifb/Makefile      |    4 -
 drivers/staging/xgifb/TODO          |   13 -
 drivers/staging/xgifb/XGI_main.h    |  377 ---
 drivers/staging/xgifb/XGI_main_26.c | 2100 -------------
 drivers/staging/xgifb/XGIfb.h       |  108 -
 drivers/staging/xgifb/vb_def.h      |  256 --
 drivers/staging/xgifb/vb_init.c     | 1363 ---------
 drivers/staging/xgifb/vb_init.h     |    6 -
 drivers/staging/xgifb/vb_setmode.c  | 5529 -----------------------------------
 drivers/staging/xgifb/vb_setmode.h  |   23 -
 drivers/staging/xgifb/vb_struct.h   |  164 --
 drivers/staging/xgifb/vb_table.h    | 2511 ----------------
 drivers/staging/xgifb/vb_util.h     |   45 -
 drivers/staging/xgifb/vgatypes.h    |   50 -
 18 files changed, 12568 deletions(-)
 delete mode 100644 drivers/staging/xgifb/Kconfig
 delete mode 100644 drivers/staging/xgifb/Makefile
 delete mode 100644 drivers/staging/xgifb/TODO
 delete mode 100644 drivers/staging/xgifb/XGI_main.h
 delete mode 100644 drivers/staging/xgifb/XGI_main_26.c
 delete mode 100644 drivers/staging/xgifb/XGIfb.h
 delete mode 100644 drivers/staging/xgifb/vb_def.h
 delete mode 100644 drivers/staging/xgifb/vb_init.c
 delete mode 100644 drivers/staging/xgifb/vb_init.h
 delete mode 100644 drivers/staging/xgifb/vb_setmode.c
 delete mode 100644 drivers/staging/xgifb/vb_setmode.h
 delete mode 100644 drivers/staging/xgifb/vb_struct.h
 delete mode 100644 drivers/staging/xgifb/vb_table.h
 delete mode 100644 drivers/staging/xgifb/vb_util.h
 delete mode 100644 drivers/staging/xgifb/vgatypes.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 851b89b9edcb..b97f18d2e93d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11564,11 +11564,6 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/staging/wilc1000/
 
-STAGING - XGI Z7,Z9,Z11 PCI DISPLAY DRIVER
-M:	Arnaud Patard <arnaud.patard@rtp-net.org>
-S:	Odd Fixes
-F:	drivers/staging/xgifb/
-
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 58a7b3504b82..2afd7466cfde 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -54,8 +54,6 @@ source "drivers/staging/iio/Kconfig"
 
 source "drivers/staging/sm750fb/Kconfig"
 
-source "drivers/staging/xgifb/Kconfig"
-
 source "drivers/staging/emxx_udc/Kconfig"
 
 source "drivers/staging/speakup/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2fa9745db614..31c1054ace20 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
-obj-$(CONFIG_FB_XGI)		+= xgifb/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
 obj-$(CONFIG_SPEAKUP)		+= speakup/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
diff --git a/drivers/staging/xgifb/Kconfig b/drivers/staging/xgifb/Kconfig
deleted file mode 100644
index bb0ca5974ea0..000000000000
diff --git a/drivers/staging/xgifb/Makefile b/drivers/staging/xgifb/Makefile
deleted file mode 100644
index 964a843c4521..000000000000
diff --git a/drivers/staging/xgifb/TODO b/drivers/staging/xgifb/TODO
deleted file mode 100644
index 7eb99140a399..000000000000
diff --git a/drivers/staging/xgifb/XGI_main.h b/drivers/staging/xgifb/XGI_main.h
deleted file mode 100644
index 85079fea7152..000000000000
diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
deleted file mode 100644
index 0c78491ff5a1..000000000000
diff --git a/drivers/staging/xgifb/XGIfb.h b/drivers/staging/xgifb/XGIfb.h
deleted file mode 100644
index af50362395d5..000000000000
diff --git a/drivers/staging/xgifb/vb_def.h b/drivers/staging/xgifb/vb_def.h
deleted file mode 100644
index 94e2e3c7c264..000000000000
diff --git a/drivers/staging/xgifb/vb_init.c b/drivers/staging/xgifb/vb_init.c
deleted file mode 100644
index 062ece22ed84..000000000000
diff --git a/drivers/staging/xgifb/vb_init.h b/drivers/staging/xgifb/vb_init.h
deleted file mode 100644
index 500cabe41a3c..000000000000
diff --git a/drivers/staging/xgifb/vb_setmode.c b/drivers/staging/xgifb/vb_setmode.c
deleted file mode 100644
index d8010c5c1a70..000000000000
diff --git a/drivers/staging/xgifb/vb_setmode.h b/drivers/staging/xgifb/vb_setmode.h
deleted file mode 100644
index 6f082a7a5a4a..000000000000
diff --git a/drivers/staging/xgifb/vb_struct.h b/drivers/staging/xgifb/vb_struct.h
deleted file mode 100644
index 2fd1a5935e1d..000000000000
diff --git a/drivers/staging/xgifb/vb_table.h b/drivers/staging/xgifb/vb_table.h
deleted file mode 100644
index c801deb142f6..000000000000
diff --git a/drivers/staging/xgifb/vb_util.h b/drivers/staging/xgifb/vb_util.h
deleted file mode 100644
index 08db58b396b2..000000000000
diff --git a/drivers/staging/xgifb/vgatypes.h b/drivers/staging/xgifb/vgatypes.h
deleted file mode 100644
index de80e5c108dc..000000000000
-- 
2.7.4

