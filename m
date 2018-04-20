From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Fri, 20 Apr 2018 17:42:46 +0000
Subject: [PATCH 0/7] Enable most media drivers to build on ARM
Message-Id: <cover.1524245455.git.mchehab@s-opensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Mans Rullgard <mans@mansr.com>, Sean Young <sean@mess.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Yong Zhi <yong.zhi@intel.com>, linux-arch@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jacob Chen <jacob-chen@iotwrt.com>, Hans Verkuil <hans.verkuil@cisco.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, mjpeg-users@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Devin Heitmueller <dheitmueller@kernellabs.com>, Stephe

Right now, all media drivers build successfully with COMPILE_TEST on x86,
on both i386 and x86_64. Yet, several drivers there don't build on other
archs.

I don't need myself to build all drivers outside x86, but others could
find it useful. It also relps spreading COMPILE_TEST builds, with sounds
a good idea, as more developers may be seeing issues and submiting 
us patches.

So, this patch series makes most of them to be built elsewhere (tested
only with ARM with allyesconfig). The only two media drivers that don't build 
on such conditions are:

1) media/staging/atomisp: it uses several ACPI bits that no other media
driver requires (including Intel IPU3);

2) radio-miropcm20: This device depnds on ISA_DMA_API, with is available only
for a few non-Intel architectures.

In other words, the following symbols aren't enabled with allyesconfig:

	INTEL_ATOMISP VIDEO_ATOMISP
	VIDEO_ATOMISP_MSRLIST_HELPER VIDEO_ATOMISP_MT9M114
	VIDEO_ATOMISP_GC0310  VIDEO_ATOMISP_GC2235 
	VIDEO_ATOMISP_OV2722 VIDEO_ATOMISP_OV5693
	VIDEO_ATOMISP_OV2680 VIDEO_ATOMISP_LM3554
	RADIO_MIROPCM20

All patches in this series are available at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=compile_test_v7

Mauro Carvalho Chehab (7):
  asm-generic, media: allow COMPILE_TEST with virt_to_bus
  media: meye: allow building it with COMPILE_TEST on non-x86
  media: rc: allow build pnp-dependent drivers with COMPILE_TEST
  media: ipu3: allow building it with COMPILE_TEST on non-x86 archs
  omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP
  media: omap2: allow building it with COMPILE_TEST && DRM_OMAP
  media: via-camera: allow build on non-x86 archs with COMPILE_TEST

 drivers/media/pci/intel/ipu3/Kconfig |  3 +-
 drivers/media/pci/meye/Kconfig       |  3 +-
 drivers/media/pci/sta2x11/Kconfig    |  4 +--
 drivers/media/pci/zoran/Kconfig      |  3 +-
 drivers/media/platform/Kconfig       |  2 +-
 drivers/media/platform/omap/Kconfig  |  3 +-
 drivers/media/platform/via-camera.c  | 10 ++++++-
 drivers/media/rc/Kconfig             | 10 +++----
 include/asm-generic/io.h             |  2 +-
 include/linux/sony-laptop.h          |  4 +++
 include/linux/via-core.h             | 17 ++++++++++++
 include/linux/via-gpio.h             |  4 +++
 include/linux/via_i2c.h              |  5 ++++
 include/video/omapfb_dss.h           | 54 ++++++++++++++++++++++++++++++++++--
 14 files changed, 107 insertions(+), 17 deletions(-)

-- 
2.14.3


