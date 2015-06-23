From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Jun 2015 06:46:57 +0000
Subject: [GIT PULL] fbdev changes for 4.2
Message-Id: <558900E1.3010502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Nm2VDdQXgA1vXR78oe51GVwcHs5phd9Lo"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--Nm2VDdQXgA1vXR78oe51GVwcHs5phd9Lo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f=
3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.2

for you to fetch changes up to f778dad38a54ca5207d024b5ebe0e6d71b8bad83:

  Merge omapdss scaling fixes (2015-06-22 14:56:01 +0300)

----------------------------------------------------------------
fbdev changes for 4.2

* ssd1307fb: various fixes and improvements, SSD1305 support
* Use architecture agnostic functions instead of MTRR functions in variou=
s
  fbdev drivers
* TI DRA7xx SoC display support (arch/arm/ side)
* OMAPDSS componentization to fix probing order issues
* OMAPDSS scaling fixes
* msm_fb: remove obsoleted driver

----------------------------------------------------------------
Arnd Bergmann (1):
      video: omap/h3: fix tps65010 dependency

Dan Carpenter (1):
      fbdev: ssd1307fb: potential ERR_PTR dereference

Fabian Frederick (3):
      video: fbdev: matrox: use swap() in matroxfb_decode_var()
      video: fbdev: use swap() in ami_set_sprite()
      video/console: use swap() in newport_bmove()

Harald Geyer (1):
      framebuffer: don't link fb_devio into kernel image unconditionally

Kees Cook (1):
      fbdev: omap2: remove potential format string leak

Krzysztof Kozlowski (2):
      video: fbdev: imxfb: Constify platform_device_id
      video: fbdev: mxsfb: Constify platform_device_id

Liu Ying (1):
      video: mxsfb: Make sure axi clock is enabled when accessing registe=
rs

Luis R. Rodriguez (20):
      video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: gbefb: add missing mtrr_del() calls
      video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
      video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
      video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
      video: fbdev: vesafb: only support MTRR_TYPE_WRCOMB
      video: fbdev: vesafb: add missing mtrr_del() for added MTRR
      video: fbdev: vesafb: use arch_phys_wc_add()

Misael Lopez Cruz (5):
      OMAPDSS: HDMI4: Set correct CC for 8-channels layout
      OMAPDSS: HDMI5: Set valid sample order
      OMAPDSS: HDMI5: Fix AUDICONF3 bitfield offsets
      ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
      ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA

Stephen Boyd (1):
      msm: msm_fb: Remove dead code

Thomas Niederpr=C3=BCm (11):
      fbdev: ssd1307fb: fix memory address smem_start.
      fbdev: ssd1307fb: Allocate page aligned video memory.
      of: Add Solomon Systech vendor prefix.
      fbdev: ssd1307fb: Unify init code and obtain hw specific bits from =
DT
      ARM: mxs: fix in tree users of ssd1306
      fbdev: ssd1307fb: Add support for SSD1305
      fbdev: ssd1307fb: Add a module parameter to set the refresh rate
      fbdev: ssd1307fb: Turn off display on driver unload.
      fbdev: ssd1307fb: add backlight controls for setting the contrast
      fbdev: ssd1307fb: Add blank mode
      fbdev: ssd1307fb: fix logical error

Tomi Valkeinen (31):
      arm: dra7: add DESHDCP clock
      CLK: TI: always enable DESHDCP clock
      arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
      ARM: DRA7: hwmod: add DMM hwmod description
      ARM: DRA7: hwmod: set DSS submodule parent hwmods
      ARM: OMAP: display: change compat names to array
      ARM: OMAP2+: display: detect DRA7 DSS
      arm/dts: dra7.dtsi: add DSS support
      arm/dts: dra72-evm.dts: add HDMI
      arm/dts: am57xx-beagle-x15.dts: add HDMI
      Merge branch 'ti-dra7-dss' into 4.2/fbdev
      OMAPDSS: move 'dss_initialized' to dss driver
      OMAPDSS: refactor dss probe function
      OMAPDSS: fix dss_init_ports error handling
      OMAPDSS: remove uses of __init/__exit
      OMAPDSS: reorder uninit calls
      OMAPDSS: componentize omapdss
      OMAPDSS: simplify submodule reg/unreg code
      Merge omapdss componentization work
      OMAPDSS: DISPC: work-around for errata i631
      OMAPDSS: DISPC: fix predecimation for YUV modes
      OMAPDSS: DISPC: fix check_horiz_timing_omap3 args
      OMAPDSS: DISPC: add check for scaling limits
      OMAPDSS: DISPC: fix row_inc for OMAP3
      OMAPDSS: DISPC: fix 64 bit issue in 5-tap
      OMAPDSS: DISPC: check if scaling setup failed
      OMAPDSS: DISPC: do only y decimation on OMAP3
      OMAPDSS: DISPC: scaler debug print
      OMAPDSS: HDMI4: fix error handling
      OMAPDSS: HDMI: wait for framedone when stopping video
      Merge omapdss scaling fixes

Uwe Kleine-K=C3=B6nig (1):
      fbdev: omap2: improve usage of gpiod API

Vladimir Murzin (1):
      fbdev: propagate result of fb_videomode_from_videomode()

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/video/ssd1307fb.txt        |  23 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  81 ++
 arch/arm/boot/dts/dra7.dtsi                        |  43 ++
 arch/arm/boot/dts/dra72-evm.dts                    | 110 +++
 arch/arm/boot/dts/dra72x.dtsi                      |  11 +
 arch/arm/boot/dts/dra74x.dtsi                      |  15 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  11 +
 arch/arm/boot/dts/imx28-cfa10036.dts               |   3 +
 arch/arm/mach-omap2/display.c                      |  32 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  33 +
 drivers/clk/ti/clk-7xx.c                           |   8 +-
 drivers/video/console/newport_con.c                |   6 +-
 drivers/video/fbdev/Kconfig                        |   8 +-
 drivers/video/fbdev/Makefile                       |   1 -
 drivers/video/fbdev/amifb.c                        |   4 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |   3 +-
 drivers/video/fbdev/aty/aty128fb.c                 |  36 +-
 drivers/video/fbdev/aty/radeon_base.c              |  29 +-
 drivers/video/fbdev/aty/radeonfb.h                 |   2 +-
 drivers/video/fbdev/core/Makefile                  |   2 +-
 drivers/video/fbdev/core/fb_defio.c                |   2 -
 drivers/video/fbdev/core/fbmon.c                   |   4 +-
 drivers/video/fbdev/gbefb.c                        |  25 +-
 drivers/video/fbdev/geode/gxfb_core.c              |   3 +-
 drivers/video/fbdev/i810/i810.h                    |   3 +-
 drivers/video/fbdev/i810/i810_main.c               |  11 +-
 drivers/video/fbdev/i810/i810_main.h               |  26 -
 drivers/video/fbdev/imxfb.c                        |   2 +-
 drivers/video/fbdev/intelfb/intelfb.h              |   4 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |  38 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |  42 +-
 drivers/video/fbdev/matrox/matroxfb_base.h         |  27 +-
 drivers/video/fbdev/msm/Makefile                   |  19 -
 drivers/video/fbdev/msm/mddi.c                     | 821 ---------------=
------
 drivers/video/fbdev/msm/mddi_client_dummy.c        |  85 ---
 drivers/video/fbdev/msm/mddi_client_nt35399.c      | 252 -------
 drivers/video/fbdev/msm/mddi_client_toshiba.c      | 280 -------
 drivers/video/fbdev/msm/mddi_hw.h                  | 305 --------
 drivers/video/fbdev/msm/mdp.c                      | 520 -------------
 drivers/video/fbdev/msm/mdp_csc_table.h            | 582 ---------------=

 drivers/video/fbdev/msm/mdp_hw.h                   | 627 ---------------=
-
 drivers/video/fbdev/msm/mdp_ppp.c                  | 731 ---------------=
---
 drivers/video/fbdev/msm/mdp_scale_tables.c         | 766 ---------------=
----
 drivers/video/fbdev/msm/mdp_scale_tables.h         |  38 -
 drivers/video/fbdev/msm/msm_fb.c                   | 659 ---------------=
--
 drivers/video/fbdev/mxsfb.c                        |  70 +-
 drivers/video/fbdev/neofb.c                        |  26 +-
 drivers/video/fbdev/nvidia/nv_type.h               |   7 +-
 drivers/video/fbdev/nvidia/nvidia.c                |  37 +-
 drivers/video/fbdev/omap/Kconfig                   |   2 +-
 .../fbdev/omap2/displays-new/encoder-opa362.c      |  12 +-
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c |  13 +-
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  |   7 +-
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   |   9 +-
 drivers/video/fbdev/omap2/dss/core.c               |  80 +-
 drivers/video/fbdev/omap2/dss/dispc.c              | 156 +++-
 drivers/video/fbdev/omap2/dss/display-sysfs.c      |   2 +-
 drivers/video/fbdev/omap2/dss/dpi.c                |  36 +-
 drivers/video/fbdev/omap2/dss/dsi.c                |  27 +-
 drivers/video/fbdev/omap2/dss/dss.c                | 223 ++++--
 drivers/video/fbdev/omap2/dss/dss.h                |  32 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  30 +-
 drivers/video/fbdev/omap2/dss/hdmi4_core.c         |  12 +-
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  28 +-
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |   5 +-
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |  16 +
 drivers/video/fbdev/omap2/dss/rfbi.c               |  32 +-
 drivers/video/fbdev/omap2/dss/sdi.c                |  35 +-
 drivers/video/fbdev/omap2/dss/venc.c               |  31 +-
 drivers/video/fbdev/pm2fb.c                        |  31 +-
 drivers/video/fbdev/pm3fb.c                        |  30 +-
 drivers/video/fbdev/riva/fbdev.c                   |  39 +-
 drivers/video/fbdev/riva/rivafb.h                  |   4 +-
 drivers/video/fbdev/savage/savagefb.h              |   4 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |  17 +-
 drivers/video/fbdev/sis/sis.h                      |   2 +-
 drivers/video/fbdev/sis/sis_main.c                 |  27 +-
 drivers/video/fbdev/ssd1307fb.c                    | 289 ++++++--
 drivers/video/fbdev/tdfxfb.c                       |  41 +-
 drivers/video/fbdev/vesafb.c                       |  80 +-
 include/linux/platform_data/video-msm_fb.h         | 146 ----
 include/video/neomagic.h                           |   5 +-
 include/video/tdfx.h                               |   2 +-
 sound/soc/omap/omap-hdmi-audio.c                   |  12 +-
 85 files changed, 1311 insertions(+), 6680 deletions(-)
 delete mode 100644 drivers/video/fbdev/msm/Makefile
 delete mode 100644 drivers/video/fbdev/msm/mddi.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_dummy.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_nt35399.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_toshiba.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_hw.h
 delete mode 100644 drivers/video/fbdev/msm/mdp.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_csc_table.h
 delete mode 100644 drivers/video/fbdev/msm/mdp_hw.h
 delete mode 100644 drivers/video/fbdev/msm/mdp_ppp.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_scale_tables.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_scale_tables.h
 delete mode 100644 drivers/video/fbdev/msm/msm_fb.c
 delete mode 100644 include/linux/platform_data/video-msm_fb.h


--Nm2VDdQXgA1vXR78oe51GVwcHs5phd9Lo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViQDhAAoJEPo9qoy8lh71fXsQAKPe5bS8txd55IkjpenqSpBe
2jXb34xEZ490Y/fH6+N4XQQ8W2NV+ElUCNaR8QCkmN37RKUEWstapQyTsJ3Ck2KJ
wtQ1tUpfsnXRFVUtomARDPBmvt8Cu3sAym4uPdOgj6J44sPM6i2/fFD+F8pOOfzh
pNsmnP307oGEUMWnhOZIV90t2Jyhb95bLGm6wjts8/WxsKuj0Yg5Vq4Tv6psnpt0
5WI1h1WXfXEzJ0cGfRkD1VmFuYx/wvjYDiPcV5dL9x6Ki8tfirdfGzTpFbVz9aOk
i7S3wmvVaOT0xYOj4ojDHC3LbPFWeWrdAI6wo2HHbVzpjCjBNPyDlKFQxNfZzxbd
fYbQJefCB7sMj0seCBADubZcIqPeirPmUIkArZT1JtvSTTh/B3atNTnFhPI38E5+
ZP8+G/ygBIXXRZZ5ok9ln8IWjJEZxm1ITp4Z6AdSOx+onVsvLtyxUaSP9YKPrWkt
UGisE0BMTEwuGlue0pAETf1tn9IgQ61y5kfx6RvlgfDSXC0MQsqymgEhP2/MkPI3
AAXxwXYcvj2c05Cx0P1QnsEx3kixzrlPZlDD6eyUM3diBfNHfOy4nMlYC3mlhlUJ
hvUQKFbgYyDd9lSURJjcOxmT6ihwcM6JRYHXdpLIOnYgOAQWeWn4sul1exb7lYWq
Acz8eO533KRxoMZ7b1ZV
=z83p
-----END PGP SIGNATURE-----

--Nm2VDdQXgA1vXR78oe51GVwcHs5phd9Lo--
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
