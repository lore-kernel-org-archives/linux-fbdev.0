From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 12 Sep 2012 09:57:43 +0000
Subject: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

New revision of the power sequences, taking as usual the feedback that was
kindly provided about the last version.

I think now is a good time to discuss integrating this and to start looking for
a maintainer who would be willing to merge this into his/her tree (I am
especially thinking about the power framework maintainers, since this is where
the code is right now. The second patch in this series enables the pwm_backlight
driver to be used with the device tree, without relying on board-dependent
callbacks to support complex power sequences. We also plan to use power
sequences in other Tegra drivers, and other people have expressed interest in
this work during earlier reviews. See for instance

https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-August/018532.html

and

https://lkml.org/lkml/2012/9/6/270

There is probably some more details to fix and improve, but the current shape
should be enough to know if we want this and where - therefore any sign from
a maintainer would be greatly appreciated!

Changes since v5:
* Removed pointers to platform data from resource structure for better code
  clarity
* devm_power_seq_set_build() now automatically checks the DT if no platform
  data is present, making it possible to remove the explicit DT parsing function
* Lots of fixes in the documentation which should be clearer now (thanks
  Stephen!)

Alexandre Courbot (4):
  Runtime Interpreted Power Sequences
  pwm_backlight: use power sequences
  tegra: dt: add label to tegra20's PWM
  tegra: ventana: add pwm backlight DT nodes

 .../devicetree/bindings/power_seq/power_seq.txt    | 122 ++++++
 .../bindings/video/backlight/pwm-backlight.txt     |  65 ++-
 Documentation/power/power_seq.txt                  | 215 ++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts              |  59 ++-
 arch/arm/boot/dts/tegra20.dtsi                     |   2 +-
 drivers/power/Kconfig                              |   1 +
 drivers/power/Makefile                             |   1 +
 drivers/power/power_seq/Kconfig                    |   2 +
 drivers/power/power_seq/Makefile                   |   1 +
 drivers/power/power_seq/power_seq.c                | 446 +++++++++++++++++++++
 drivers/power/power_seq/power_seq_delay.c          |  51 +++
 drivers/power/power_seq/power_seq_gpio.c           |  91 +++++
 drivers/power/power_seq/power_seq_pwm.c            |  87 ++++
 drivers/power/power_seq/power_seq_regulator.c      |  87 ++++
 drivers/video/backlight/Kconfig                    |   1 +
 drivers/video/backlight/pwm_bl.c                   | 180 ++++++---
 include/linux/power_seq.h                          | 172 ++++++++
 include/linux/pwm_backlight.h                      |  15 +-
 18 files changed, 1543 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_seq/power_seq.txt
 create mode 100644 Documentation/power/power_seq.txt
 create mode 100644 drivers/power/power_seq/Kconfig
 create mode 100644 drivers/power/power_seq/Makefile
 create mode 100644 drivers/power/power_seq/power_seq.c
 create mode 100644 drivers/power/power_seq/power_seq_delay.c
 create mode 100644 drivers/power/power_seq/power_seq_gpio.c
 create mode 100644 drivers/power/power_seq/power_seq_pwm.c
 create mode 100644 drivers/power/power_seq/power_seq_regulator.c
 create mode 100644 include/linux/power_seq.h

-- 
1.7.12

