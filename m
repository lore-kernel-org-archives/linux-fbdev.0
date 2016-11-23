From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 08:03:12 +0000
Subject: [RFC PATCH 2/3] staging: remove sm750fb
Message-Id: <1479888193-23908-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

Since the fbdev framework is in maintenance mode and all new display
drivers should be made with the DRM framework, remove sm750fb from
staging.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 MAINTAINERS                              |    8 -
 drivers/staging/Kconfig                  |    2 -
 drivers/staging/Makefile                 |    1 -
 drivers/staging/sm750fb/Kconfig          |   14 -
 drivers/staging/sm750fb/Makefile         |    4 -
 drivers/staging/sm750fb/TODO             |   16 -
 drivers/staging/sm750fb/ddk750.h         |   24 -
 drivers/staging/sm750fb/ddk750_chip.c    |  403 ---------
 drivers/staging/sm750fb/ddk750_chip.h    |   79 --
 drivers/staging/sm750fb/ddk750_display.c |  186 ----
 drivers/staging/sm750fb/ddk750_display.h |  102 ---
 drivers/staging/sm750fb/ddk750_dvi.c     |   60 --
 drivers/staging/sm750fb/ddk750_dvi.h     |   59 --
 drivers/staging/sm750fb/ddk750_help.c    |   17 -
 drivers/staging/sm750fb/ddk750_help.h    |   21 -
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  254 ------
 drivers/staging/sm750fb/ddk750_hwi2c.h   |   11 -
 drivers/staging/sm750fb/ddk750_mode.c    |  220 -----
 drivers/staging/sm750fb/ddk750_mode.h    |   41 -
 drivers/staging/sm750fb/ddk750_power.c   |  165 ----
 drivers/staging/sm750fb/ddk750_power.h   |   50 -
 drivers/staging/sm750fb/ddk750_reg.h     | 1458 ------------------------------
 drivers/staging/sm750fb/ddk750_sii164.c  |  410 ---------
 drivers/staging/sm750fb/ddk750_sii164.h  |  174 ----
 drivers/staging/sm750fb/ddk750_swi2c.c   |  516 -----------
 drivers/staging/sm750fb/ddk750_swi2c.h   |   71 --
 drivers/staging/sm750fb/readme           |   38 -
 drivers/staging/sm750fb/sm750.c          | 1248 -------------------------
 drivers/staging/sm750fb/sm750.h          |  202 -----
 drivers/staging/sm750fb/sm750_accel.c    |  388 --------
 drivers/staging/sm750fb/sm750_accel.h    |  225 -----
 drivers/staging/sm750fb/sm750_cursor.c   |  183 ----
 drivers/staging/sm750fb/sm750_cursor.h   |   17 -
 drivers/staging/sm750fb/sm750_hw.c       |  557 ------------
 34 files changed, 7224 deletions(-)
 delete mode 100644 drivers/staging/sm750fb/Kconfig
 delete mode 100644 drivers/staging/sm750fb/Makefile
 delete mode 100644 drivers/staging/sm750fb/TODO
 delete mode 100644 drivers/staging/sm750fb/ddk750.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_chip.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_chip.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_display.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_display.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_help.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_help.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_mode.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_mode.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_power.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_power.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_reg.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_swi2c.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_swi2c.h
 delete mode 100644 drivers/staging/sm750fb/readme
 delete mode 100644 drivers/staging/sm750fb/sm750.c
 delete mode 100644 drivers/staging/sm750fb/sm750.h
 delete mode 100644 drivers/staging/sm750fb/sm750_accel.c
 delete mode 100644 drivers/staging/sm750fb/sm750_accel.h
 delete mode 100644 drivers/staging/sm750fb/sm750_cursor.c
 delete mode 100644 drivers/staging/sm750fb/sm750_cursor.h
 delete mode 100644 drivers/staging/sm750fb/sm750_hw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b97f18d2e93d..772330b38212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11528,14 +11528,6 @@ M:	Florian Schilhabel <florian.c.schilhabel@googlemail.com>.
 S:	Odd Fixes
 F:	drivers/staging/rtl8712/
 
-STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER
-M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
-M:	Teddy Wang <teddy.wang@siliconmotion.com>
-M:	Sudip Mukherjee <sudip@vectorindia.org>
-L:	linux-fbdev@vger.kernel.org
-S:	Maintained
-F:	drivers/staging/sm750fb/
-
 STAGING - SLICOSS
 M:	Lior Dotan <liodot@gmail.com>
 M:	Christopher Harrer <charrer@alacritech.com>
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 2afd7466cfde..fcfe8fcea441 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -52,8 +52,6 @@ source "drivers/staging/vt6656/Kconfig"
 
 source "drivers/staging/iio/Kconfig"
 
-source "drivers/staging/sm750fb/Kconfig"
-
 source "drivers/staging/emxx_udc/Kconfig"
 
 source "drivers/staging/speakup/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 31c1054ace20..585eb34020a1 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IIO)		+= iio/
-obj-$(CONFIG_FB_SM750)		+= sm750fb/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
 obj-$(CONFIG_SPEAKUP)		+= speakup/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
deleted file mode 100644
index ccebc25c2ec1..000000000000
diff --git a/drivers/staging/sm750fb/Makefile b/drivers/staging/sm750fb/Makefile
deleted file mode 100644
index dcce3f487ed5..000000000000
diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
deleted file mode 100644
index a3a877d90066..000000000000
diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
deleted file mode 100644
index 2c10a08ed964..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
deleted file mode 100644
index 839d6730bde9..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
deleted file mode 100644
index 14357fd1cc6b..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
deleted file mode 100644
index 4023c476b9e4..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
deleted file mode 100644
index e3fde428c52b..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
deleted file mode 100644
index 8252f771ef9e..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
deleted file mode 100644
index 677939cb5130..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
deleted file mode 100644
index 9637dd30d037..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_help.h b/drivers/staging/sm750fb/ddk750_help.h
deleted file mode 100644
index 009db9213a73..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
deleted file mode 100644
index d391c127ead7..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.h b/drivers/staging/sm750fb/ddk750_hwi2c.h
deleted file mode 100644
index 46e22dce2570..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
deleted file mode 100644
index 05b83646c2d5..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
deleted file mode 100644
index e846dc2c3d5c..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
deleted file mode 100644
index 7cc6169f884e..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
deleted file mode 100644
index 5963691f9a68..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
deleted file mode 100644
index 4ed6d8d7712a..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
deleted file mode 100644
index 99a8683e6383..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
deleted file mode 100644
index 664ad089f753..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
deleted file mode 100644
index 72a42330e7a1..000000000000
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h b/drivers/staging/sm750fb/ddk750_swi2c.h
deleted file mode 100644
index b53629cda095..000000000000
diff --git a/drivers/staging/sm750fb/readme b/drivers/staging/sm750fb/readme
deleted file mode 100644
index cfa45958b9d2..000000000000
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
deleted file mode 100644
index 7d90e250142c..000000000000
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
deleted file mode 100644
index ff31c5c9cc6f..000000000000
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
deleted file mode 100644
index 38adae6b5d83..000000000000
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
deleted file mode 100644
index d59d005e0add..000000000000
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
deleted file mode 100644
index d622d65b6cee..000000000000
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
deleted file mode 100644
index 6c4fc9b73489..000000000000
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
deleted file mode 100644
index 7dd208caa5eb..000000000000
-- 
2.7.4

