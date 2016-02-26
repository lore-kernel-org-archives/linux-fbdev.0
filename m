From: Alan <alan@linux.intel.com>
Date: Fri, 26 Feb 2016 18:41:35 +0000
Subject: [PATCH 0/5] goldfish: bring the framebuffer in sync with upstream
Message-Id: <20160226183940.2731.42083.stgit@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The Android tree has changes to support Goldfish (Android virtual platform
emulator) improvements. Pull those into upstream as part of the goal of
making upstream run out of the box on Goldfish.

---

Christoffer Dall (1):
      Subject: goldfish_fb: Set pixclock = 0

Greg Hackmann (1):
      Subject: video: goldfishfb: add devicetree bindings

Nicolas Capens (1):
      Subject: goldfishfb: simplify framebuffer format selection.

Yu Ning (1):
      Subject: goldfish: Enable ACPI-based enumeration for goldfish framebuffer

bohu (1):
      Subject: goldfish: 32 bit framebuffer support


 .../devicetree/bindings/goldfish/audio.txt         |   17 +++
 .../devicetree/bindings/goldfish/battery.txt       |   17 +++
 .../devicetree/bindings/goldfish/events.txt        |   17 +++
 Documentation/devicetree/bindings/goldfish/fb.txt  |   17 +++
 Documentation/devicetree/bindings/goldfish/tty.txt |   17 +++
 drivers/input/keyboard/goldfish_events.c           |   15 +++
 drivers/power/goldfish_battery.c                   |   17 +++
 drivers/staging/goldfish/goldfish_audio.c          |   10 ++
 drivers/tty/goldfish.c                             |   10 ++
 drivers/video/fbdev/goldfishfb.c                   |  107 +++++++++++++++++---
 10 files changed, 223 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
 create mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 create mode 100644 Documentation/devicetree/bindings/goldfish/fb.txt
 create mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt

--
#include <witty.h>
