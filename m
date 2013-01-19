From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 19 Jan 2013 10:30:17 +0000
Subject: [PATCH 0/3] pwm-backlight: add subdrivers & Tegra support
Message-Id: <1358591420-7790-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

This series introduces a way to use pwm-backlight hooks with platforms
that use the device tree through a subdriver system. It also adds support
for the Tegra-based Ventana board, adding the last missing block to enable
its panel. Support for other Tegra board can thus be easily added.

I have something else in mind to properly support this (power
sequences), but this work relies on the GPIO subsystem redesign which will
take some time. The pwm-backlight subdrivers can do the job by the meantime.

There are a few design points that might need to be discussed:
1) Link order is important: subdrivers register themselves in their
module_init function, which must be called before pwm-backlight's probe.
This forbids linking subdrivers as separate modules from pwm-backlight.
2) The subdriver's data is temporarily passed through the backlight
device's driver data. This should not hurt, but maybe there is a better way
to do this.
3) Subdrivers must add themselves into pwm-backlight's own of_device_id
table. It would be cleaner to not have to list subdrivers into
pwm-backlight's main file, but I cannot think of a way to do otherwise.

Suggestions for the 3 points listed above are very welcome - in any case,
I hope to make this converge into something mergeable quickly.

Note that these patches are the last missing block to get a functional
panel on Tegra boards. Using 3.8rc4 and these patches, the internal panel
on Ventana is usable out-of-the-box. Yay.

Alexandre Courbot (3):
  pwm-backlight: add subdriver mechanism
  tegra: pwm-backlight: add tegra pwm-bl driver
  tegra: ventana: of: add host1x device to DT

 arch/arm/boot/dts/tegra20-ventana.dts  |  29 +++++-
 arch/arm/configs/tegra_defconfig       |   1 +
 drivers/video/backlight/Kconfig        |   7 ++
 drivers/video/backlight/Makefile       |   4 +
 drivers/video/backlight/pwm_bl.c       |  70 ++++++++++++++-
 drivers/video/backlight/pwm_bl_tegra.c | 159 +++++++++++++++++++++++++++++++++
 include/linux/pwm_backlight.h          |  15 ++++
 7 files changed, 281 insertions(+), 4 deletions(-)
 create mode 100644 drivers/video/backlight/pwm_bl_tegra.c

-- 
1.8.1.1

