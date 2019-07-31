From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 31 Jul 2019 12:43:39 +0000
Subject: [PATCH v2 00/10] drivers, provide a way to add sysfs groups easily
Message-Id: <20190731124349.4474-1-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Richard Gong <richard.gong@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org

This patch originally started out just as a way for platform drivers to
easily add a sysfs group in a race-free way, but thanks to Dmitry's
patch, this series now is for all drivers in the kernel (hey, a unified
driver model works!!!)

I've only converted a few platform drivers here in this series to show
how it works, but other busses can be converted after the first patch
goes into the tree.

Here's the original 00 message, for people to get an idea of what is
going on here:

If a platform driver wants to add a sysfs group, it has to do so in a
racy way, adding it after the driver is bound.  To resolve this issue,
have the platform driver core do this for the driver, making the
individual drivers logic smaller and simpler, and solving the race at
the same time.

All of these patches depend on the first patch.  I'll take the first one
through my driver-core tree, and any subsystem maintainer can either ack
their individul patch and I will be glad to also merge it, or they can
wait until after 5.4-rc1 when the core patch hits Linus's tree and then
take it, it's up to them.

Thank to Richard Gong for the idea and the testing of the platform
driver patch and to Dmitry Torokhov for rewriting the first patch to
work well for all busses.

-----

V2 - work for all busses and not just platform drivers.


Dmitry Torokhov (1):
  driver core: add dev_groups to all drivers

Greg Kroah-Hartman (9):
  uio: uio_fsl_elbc_gpcm: convert platform driver to use dev_groups
  input: keyboard: gpio_keys: convert platform driver to use dev_groups
  input: axp20x-pek: convert platform driver to use dev_groups
  firmware: arm_scpi: convert platform driver to use dev_groups
  olpc: x01: convert platform driver to use dev_groups
  platform: x86: hp-wmi: convert platform driver to use dev_groups
  video: fbdev: wm8505fb: convert platform driver to use dev_groups
  video: fbdev: w100fb: convert platform driver to use dev_groups
  video: fbdev: sm501fb: convert platform driver to use dev_groups

 arch/x86/platform/olpc/olpc-xo1-sci.c | 17 ++++------
 drivers/base/dd.c                     | 14 ++++++++
 drivers/firmware/arm_scpi.c           |  5 +--
 drivers/input/keyboard/gpio_keys.c    | 13 ++------
 drivers/input/misc/axp20x-pek.c       | 15 ++-------
 drivers/platform/x86/hp-wmi.c         | 47 +++++++--------------------
 drivers/uio/uio_fsl_elbc_gpcm.c       | 23 +++++--------
 drivers/video/fbdev/sm501fb.c         | 37 +++++----------------
 drivers/video/fbdev/w100fb.c          | 23 ++++++-------
 drivers/video/fbdev/wm8505fb.c        | 13 ++++----
 include/linux/device.h                |  3 ++
 11 files changed, 76 insertions(+), 134 deletions(-)

-- 
2.22.0
