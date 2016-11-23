From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 08:03:10 +0000
Subject: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

Hi,

Since the fbdev framework is in maintenance mode and all new display drivers
should be made with the DRM framework, remove the fbdev drivers from staging.

Note: the patches are created with git format-patch -D, so they can't be
applied. Only for review.

 Tomi

Tomi Valkeinen (3):
  staging: remove xgifb
  staging: remove sm750fb
  staging: remove fbtft

 MAINTAINERS                              |   19 -
 drivers/staging/Kconfig                  |    6 -
 drivers/staging/Makefile                 |    3 -
 drivers/staging/fbtft/Kconfig            |  210 --
 drivers/staging/fbtft/Makefile           |   40 -
 drivers/staging/fbtft/README             |   32 -
 drivers/staging/fbtft/fb_agm1264k-fl.c   |  456 ---
 drivers/staging/fbtft/fb_bd663474.c      |  184 -
 drivers/staging/fbtft/fb_hx8340bn.c      |  234 --
 drivers/staging/fbtft/fb_hx8347d.c       |  169 -
 drivers/staging/fbtft/fb_hx8353d.c       |  157 -
 drivers/staging/fbtft/fb_hx8357d.c       |  210 --
 drivers/staging/fbtft/fb_hx8357d.h       |   70 -
 drivers/staging/fbtft/fb_ili9163.c       |  273 --
 drivers/staging/fbtft/fb_ili9320.c       |  278 --
 drivers/staging/fbtft/fb_ili9325.c       |  277 --
 drivers/staging/fbtft/fb_ili9340.c       |  149 -
 drivers/staging/fbtft/fb_ili9341.c       |  166 -
 drivers/staging/fbtft/fb_ili9481.c       |  112 -
 drivers/staging/fbtft/fb_ili9486.c       |  112 -
 drivers/staging/fbtft/fb_pcd8544.c       |  176 -
 drivers/staging/fbtft/fb_ra8875.c        |  318 --
 drivers/staging/fbtft/fb_s6d02a1.c       |  166 -
 drivers/staging/fbtft/fb_s6d1121.c       |  194 --
 drivers/staging/fbtft/fb_ssd1289.c       |  191 --
 drivers/staging/fbtft/fb_ssd1305.c       |  216 --
 drivers/staging/fbtft/fb_ssd1306.c       |  217 --
 drivers/staging/fbtft/fb_ssd1325.c       |  205 --
 drivers/staging/fbtft/fb_ssd1331.c       |  196 --
 drivers/staging/fbtft/fb_ssd1351.c       |  238 --
 drivers/staging/fbtft/fb_st7735r.c       |  190 -
 drivers/staging/fbtft/fb_st7789v.c       |  265 --
 drivers/staging/fbtft/fb_tinylcd.c       |  112 -
 drivers/staging/fbtft/fb_tls8204.c       |  169 -
 drivers/staging/fbtft/fb_uc1611.c        |  340 --
 drivers/staging/fbtft/fb_uc1701.c        |  179 -
 drivers/staging/fbtft/fb_upd161704.c     |  197 --
 drivers/staging/fbtft/fb_watterott.c     |  302 --
 drivers/staging/fbtft/fbtft-bus.c        |  252 --
 drivers/staging/fbtft/fbtft-core.c       | 1467 --------
 drivers/staging/fbtft/fbtft-io.c         |  238 --
 drivers/staging/fbtft/fbtft-sysfs.c      |  219 --
 drivers/staging/fbtft/fbtft.h            |  421 ---
 drivers/staging/fbtft/fbtft_device.c     | 1597 ---------
 drivers/staging/fbtft/flexfb.c           |  619 ----
 drivers/staging/fbtft/internal.h         |   25 -
 drivers/staging/sm750fb/Kconfig          |   14 -
 drivers/staging/sm750fb/Makefile         |    4 -
 drivers/staging/sm750fb/TODO             |   16 -
 drivers/staging/sm750fb/ddk750.h         |   24 -
 drivers/staging/sm750fb/ddk750_chip.c    |  403 ---
 drivers/staging/sm750fb/ddk750_chip.h    |   79 -
 drivers/staging/sm750fb/ddk750_display.c |  186 -
 drivers/staging/sm750fb/ddk750_display.h |  102 -
 drivers/staging/sm750fb/ddk750_dvi.c     |   60 -
 drivers/staging/sm750fb/ddk750_dvi.h     |   59 -
 drivers/staging/sm750fb/ddk750_help.c    |   17 -
 drivers/staging/sm750fb/ddk750_help.h    |   21 -
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  254 --
 drivers/staging/sm750fb/ddk750_hwi2c.h   |   11 -
 drivers/staging/sm750fb/ddk750_mode.c    |  220 --
 drivers/staging/sm750fb/ddk750_mode.h    |   41 -
 drivers/staging/sm750fb/ddk750_power.c   |  165 -
 drivers/staging/sm750fb/ddk750_power.h   |   50 -
 drivers/staging/sm750fb/ddk750_reg.h     | 1458 --------
 drivers/staging/sm750fb/ddk750_sii164.c  |  410 ---
 drivers/staging/sm750fb/ddk750_sii164.h  |  174 -
 drivers/staging/sm750fb/ddk750_swi2c.c   |  516 ---
 drivers/staging/sm750fb/ddk750_swi2c.h   |   71 -
 drivers/staging/sm750fb/readme           |   38 -
 drivers/staging/sm750fb/sm750.c          | 1248 -------
 drivers/staging/sm750fb/sm750.h          |  202 --
 drivers/staging/sm750fb/sm750_accel.c    |  388 ---
 drivers/staging/sm750fb/sm750_accel.h    |  225 --
 drivers/staging/sm750fb/sm750_cursor.c   |  183 -
 drivers/staging/sm750fb/sm750_cursor.h   |   17 -
 drivers/staging/sm750fb/sm750_hw.c       |  557 ---
 drivers/staging/xgifb/Kconfig            |   11 -
 drivers/staging/xgifb/Makefile           |    4 -
 drivers/staging/xgifb/TODO               |   13 -
 drivers/staging/xgifb/XGI_main.h         |  377 --
 drivers/staging/xgifb/XGI_main_26.c      | 2100 ------------
 drivers/staging/xgifb/XGIfb.h            |  108 -
 drivers/staging/xgifb/vb_def.h           |  256 --
 drivers/staging/xgifb/vb_init.c          | 1363 --------
 drivers/staging/xgifb/vb_init.h          |    6 -
 drivers/staging/xgifb/vb_setmode.c       | 5529 ------------------------------
 drivers/staging/xgifb/vb_setmode.h       |   23 -
 drivers/staging/xgifb/vb_struct.h        |  164 -
 drivers/staging/xgifb/vb_table.h         | 2511 --------------
 drivers/staging/xgifb/vb_util.h          |   45 -
 drivers/staging/xgifb/vgatypes.h         |   50 -
 92 files changed, 31639 deletions(-)
 delete mode 100644 drivers/staging/fbtft/Kconfig
 delete mode 100644 drivers/staging/fbtft/Makefile
 delete mode 100644 drivers/staging/fbtft/README
 delete mode 100644 drivers/staging/fbtft/fb_agm1264k-fl.c
 delete mode 100644 drivers/staging/fbtft/fb_bd663474.c
 delete mode 100644 drivers/staging/fbtft/fb_hx8340bn.c
 delete mode 100644 drivers/staging/fbtft/fb_hx8347d.c
 delete mode 100644 drivers/staging/fbtft/fb_hx8353d.c
 delete mode 100644 drivers/staging/fbtft/fb_hx8357d.c
 delete mode 100644 drivers/staging/fbtft/fb_hx8357d.h
 delete mode 100644 drivers/staging/fbtft/fb_ili9163.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9320.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9325.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9340.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9341.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9481.c
 delete mode 100644 drivers/staging/fbtft/fb_ili9486.c
 delete mode 100644 drivers/staging/fbtft/fb_pcd8544.c
 delete mode 100644 drivers/staging/fbtft/fb_ra8875.c
 delete mode 100644 drivers/staging/fbtft/fb_s6d02a1.c
 delete mode 100644 drivers/staging/fbtft/fb_s6d1121.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1289.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1305.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1306.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1325.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1331.c
 delete mode 100644 drivers/staging/fbtft/fb_ssd1351.c
 delete mode 100644 drivers/staging/fbtft/fb_st7735r.c
 delete mode 100644 drivers/staging/fbtft/fb_st7789v.c
 delete mode 100644 drivers/staging/fbtft/fb_tinylcd.c
 delete mode 100644 drivers/staging/fbtft/fb_tls8204.c
 delete mode 100644 drivers/staging/fbtft/fb_uc1611.c
 delete mode 100644 drivers/staging/fbtft/fb_uc1701.c
 delete mode 100644 drivers/staging/fbtft/fb_upd161704.c
 delete mode 100644 drivers/staging/fbtft/fb_watterott.c
 delete mode 100644 drivers/staging/fbtft/fbtft-bus.c
 delete mode 100644 drivers/staging/fbtft/fbtft-core.c
 delete mode 100644 drivers/staging/fbtft/fbtft-io.c
 delete mode 100644 drivers/staging/fbtft/fbtft-sysfs.c
 delete mode 100644 drivers/staging/fbtft/fbtft.h
 delete mode 100644 drivers/staging/fbtft/fbtft_device.c
 delete mode 100644 drivers/staging/fbtft/flexfb.c
 delete mode 100644 drivers/staging/fbtft/internal.h
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

-- 
2.7.4

