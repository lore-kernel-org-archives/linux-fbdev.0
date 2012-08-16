From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 16 Aug 2012 06:08:54 +0000
Subject: [PATCH v4 0/3] Runtime Interpreted Power Sequences
Message-Id: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Leela Krishna Amudala <leelakrishna.a@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>

Overdue revision of this new feature, some changes required additional thought
and rework.

The most important change is in the way power sequences are expressed in the
device tree. In order to avoid having to specify #address-cells, #size-cells and
reg properties, the @ notation in the step names is dropped, and instead a
fixed, sequential naming is adopted. The type of the resource used by a step is
decided by the presence of some recognized properties:

power-on-sequence {
	step0 {
		regulator = "power";
		enable;
	};
	step1 {
		delay = <10000>;
	};
	step2 {
		pwm = "backlight";
		enable;
	};
	...

To me this looks safe, clear and close to the platform data representation, but
needs approval from DT experts.

Resources are still referenced by name instead of having their phandles defined
directly inside the sequences, as previous discussion came to the conclusion
that doing so would require controversial changes to the regulator and PWM
frameworks, and that having the resources declared at the device level was
making sense logically speaking.

Other changes/fixes since last revision:
* Move to drivers/power/ (hope this is ok with the maintainers?)
* Use microseconds for delay
* Use devm for PWM resources and remove cleanup function as all resources are
  devm-managed
* Remove "-gpio" suffix for GPIO reference in the driver
* Remove params structure
* Make power_seq structure private
* Number of steps in a sequence is explicitly stated instead of resorting to a
  "stop" sequence step
* Delays are a step instead of being a step parameter
* Use flexible member arrays to limit number of memory allocations
* Add documentation to DT bindings

There was a lot of feedback on the previous version (thanks!) so if I forgot
to address some important point, please bring it to my attention again.

Alexandre Courbot (3):
  Runtime Interpreted Power Sequences
  pwm_backlight: use power sequences
  tegra: add pwm backlight device tree nodes

 .../devicetree/bindings/power_seq/power_seq.txt    | 101 +++++
 .../bindings/video/backlight/pwm-backlight.txt     |  62 ++-
 Documentation/power/power_seq.txt                  | 129 +++++++
 arch/arm/boot/dts/tegra20-ventana.dts              |  58 +++
 arch/arm/boot/dts/tegra20.dtsi                     |   2 +-
 drivers/power/Kconfig                              |   3 +
 drivers/power/Makefile                             |   1 +
 drivers/power/power_seq.c                          | 420 +++++++++++++++++++++
 drivers/video/backlight/Kconfig                    |   1 +
 drivers/video/backlight/pwm_bl.c                   | 192 +++++++---
 include/linux/power_seq.h                          | 142 +++++++
 include/linux/pwm_backlight.h                      |  16 +-
 12 files changed, 1071 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_seq/power_seq.txt
 create mode 100644 Documentation/power/power_seq.txt
 create mode 100644 drivers/power/power_seq.c
 create mode 100644 include/linux/power_seq.h

-- 
1.7.11.4

