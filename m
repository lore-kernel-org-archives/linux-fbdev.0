From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 04 Jul 2019 08:46:06 +0000
Subject: [PATCH 00/11] Platform drivers, provide a way to add sysfs groups easily
Message-Id: <20190704084617.3602-1-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Mans Rullgard <mans@mansr.com>, "H. Peter Anvin" <hpa@zytor.com>, Romain Izard <romain.izard.pro@gmail.com>, Richard Gong <richard.gong@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, x86@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ingo Molnar <mingo@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-input@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitr>

If a platform driver wants to add a sysfs group, it has to do so in a
racy way, adding it after the driver is bound.  To resolve this issue,
have the platform driver core do this for the driver, making the
individual drivers logic smaller and simpler, and solving the race at
the same time.

All of these patches depend on the first patch.  I'll take the first one
through my driver-core tree, and any subsystem maintainer can either ack
their individul patch and I will be glad to also merge it, or they can
wait until after 5.3-rc1 when the core patch hits Linus's tree and then
take it, it's up to them.

Thank to Richard Gong for the idea and the testing of the platform
driver patch.

Greg Kroah-Hartman (11):
  Platform: add a dev_groups pointer to struct platform_driver
  uio: uio_fsl_elbc_gpcm: convert platform driver to use dev_groups
  serial: sh-sci: use driver core functions, not sysfs ones.
  firmware: arm_scpi: convert platform driver to use dev_groups
  olpc: x01: convert platform driver to use dev_groups
  platform: x86: hp-wmi: convert platform driver to use dev_groups
  video: fbdev: wm8505fb: convert platform driver to use dev_groups
  video: fbdev: w100fb: convert platform driver to use dev_groups
  video: fbdev: sm501fb: convert platform driver to use dev_groups
  input: keyboard: gpio_keys: convert platform driver to use dev_groups
  input: axp20x-pek: convert platform driver to use dev_groups

 arch/x86/platform/olpc/olpc-xo1-sci.c | 17 ++++------
 drivers/base/platform.c               | 40 +++++++++++++++--------
 drivers/firmware/arm_scpi.c           |  5 +--
 drivers/input/keyboard/gpio_keys.c    | 13 ++------
 drivers/input/misc/axp20x-pek.c       | 15 ++-------
 drivers/platform/x86/hp-wmi.c         | 47 +++++++--------------------
 drivers/tty/serial/sh-sci.c           | 22 +++++--------
 drivers/uio/uio_fsl_elbc_gpcm.c       | 23 +++++--------
 drivers/video/fbdev/sm501fb.c         | 37 +++++----------------
 drivers/video/fbdev/w100fb.c          | 23 ++++++-------
 drivers/video/fbdev/wm8505fb.c        | 13 ++++----
 include/linux/platform_device.h       |  1 +
 12 files changed, 94 insertions(+), 162 deletions(-)

-- 
2.22.0
