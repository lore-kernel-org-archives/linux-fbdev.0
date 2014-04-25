From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:38 +0000
Subject: [PATCH RFC 00/17] Rework OMAP4+ HDMI audio support
Message-Id: <cover.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

This set of patches fixes OMAP4+ HDMI audio. The structure of the
implementatin looks a bit different than before. Instead of creating a
driver specific API for a separate ASoC component driver to connect
to, this implementation integrates an the component driver into the
HDMI driver.

The idea is to use an existing ASoC component driver API instead of
creating a new custom API for each HDMI IP and to avoid splitting the
driver to half for separate video and audio parts connected with the
API.

The new implementation also uses simple-audio-card for a machine
driver instead of having its own HW specific machine driver.

The patches are based on 3.15-rc2 merged with
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
and
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-omap5

Everything is pushed here here:
git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio

Best regards,
Jyri

Jyri Sarha (17):
  ASoC: omap-pcm: Move omap-pcm under include/sound
  OMAPDSS: hdmi-common: Add hdmi_dss_audio_from_hw_params()
  OMAPDSS: hdmi4: Integrated ASoC DAI component driver implementation
  OMAPDSS: Kconfig: Add depencies and help section to
    OMAP4_DSS_HDMI_AUDIO
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi5_core: Fix compilation with OMAP5_DSS_HDMI_AUDIO
  OMAPDSS: hdmi5: Integrated ASoC DAI component driver implementation
  OMAPDSS: Kconfig: Add depencies and help section to
    OMAP5_DSS_HDMI_AUDIO
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: Remove obsolete audio code
  ARM: omap4.dtsi: Add audio related parametes to hdmi node
  ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
  ARM: omap5.dtsi: Add audio related parameters to hdmi node
  ARM: omap5-uevm.dts: Add hdmi audio related nodes
  ARM: omap2plus_defconfig: Build DSS HDMI support for OMAP4 in kernel
  ARM: omap2plus_defconfig: Enable OMAP5 HDMI support
  ARM: omap2plus_defconfig: Enable OMAP4+ HDMI audio support

 .../devicetree/bindings/video/ti,omap4-dss.txt     |    4 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   21 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +
 arch/arm/boot/dts/omap5-uevm.dts                   |   19 +
 arch/arm/boot/dts/omap5.dtsi                       |    2 +
 arch/arm/configs/omap2plus_defconfig               |   20 +-
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 ------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |   19 +-
 drivers/video/fbdev/omap2/dss/hdmi.h               |    8 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  216 ++++++++----
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  216 ++++++++----
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |  117 ++++++-
 include/sound/omap-pcm.h                           |   30 ++
 include/video/omapdss.h                            |   31 --
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 sound/soc/omap/Kconfig                             |   13 -
 sound/soc/omap/Makefile                            |    4 -
 sound/soc/omap/omap-dmic.c                         |    2 +-
 sound/soc/omap/omap-hdmi-card.c                    |   87 -----
 sound/soc/omap/omap-hdmi.c                         |  364 --------------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 sound/soc/omap/omap-mcbsp.c                        |    2 +-
 sound/soc/omap/omap-mcpdm.c                        |    2 +-
 sound/soc/omap/omap-pcm.h                          |   30 --
 26 files changed, 536 insertions(+), 870 deletions(-)
 create mode 100644 include/sound/omap-pcm.h
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h
 delete mode 100644 sound/soc/omap/omap-pcm.h

-- 
1.7.9.5

