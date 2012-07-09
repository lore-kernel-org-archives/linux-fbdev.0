From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 09 Jul 2012 06:08:22 +0000
Subject: [RFC][PATCHv2 0/3] Power sequences interpreter for pwm_backlight
Message-Id: <1341814105-20690-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This is a RFC since this patch largely drifted beyond its original goal
of supporting one GPIO and one regulator for the pwm_backlight driver.

The issue to address is that backlight power sequences, which were
implemented using board-specific callbacks so far, could not be used with
the device tree. This series of patches adds a small power sequence 
interpreter that allows to acquire and control regulators, GPIOs, and PWMs
during sequences defined in the device tree. It is easy to use,
low-footprint, and takes care of managing the resources that it acquires.

The implementation is working and should be complete, but documentation is
lacking. Also since the interpreter could be used by other drivers (which
ones?), it may make sense to have it in a better place than
drivers/video/backlight/.

The tegra device tree nodes are just here as an example usage.

Alexandre Courbot (3):
  Power sequences interpreter for device tree
  pwm-backlight: use power sequences
  tegra: add pwm backlight device tree nodes

 .../bindings/video/backlight/pwm-backlight.txt     |  28 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |  31 +++
 arch/arm/boot/dts/tegra20.dtsi                     |   2 +-
 drivers/video/backlight/Makefile                   |   2 +-
 drivers/video/backlight/power_seq.c                | 298 +++++++++++++++++++++
 drivers/video/backlight/pwm_bl.c                   | 212 +++++++++++----
 include/linux/power_seq.h                          |  96 +++++++
 include/linux/pwm_backlight.h                      |  37 ++-
 8 files changed, 645 insertions(+), 61 deletions(-)
 create mode 100644 drivers/video/backlight/power_seq.c
 create mode 100644 include/linux/power_seq.h

-- 
1.7.11.1

