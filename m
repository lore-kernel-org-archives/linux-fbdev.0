From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 23 Oct 2015 01:31:56 +0000
Subject: [PATCH v3 0/2] simplefb: Add regulator handling support
Message-Id: <1445563918-1050-1-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi everyone,

This is v3 of the simplefb regulator support series. This series adds
regulator claiming and enabling support for simplefb.

Changes since v3:
  - Dropped extra "if" which is always true, leftover from v1.
  - Updated commit message of patch 1

Sometimes the simplefb display output path consits of external conversion
chips and/or LCD drivers and backlights. These devices normally have
GPIOs to turn them on and/or bring them out of reset, and regulators
supplying power to them.

While the kernel does not touch unclaimed GPIOs, the regulator core
happily disables unused regulators. Thus we need simplefb to claim
and enable the regulators used throughout the display pipeline.

The binding supports any named regulator supplies under its device
node. The driver will look through its properties, and claim any
regulators by matching "*-supply", as Mark suggested.

I've not done a generic helper in the regulator core yet, instead doing
the regulator property handling in the simplefb code for now.


Patch 1 adds the regulator properties to the DT binding.

Patch 2 adds code to the simplefb driver to claim and enable regulators.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: simplefb: Support regulator supply properties
  simplefb: Claim and enable regulators

 .../bindings/video/simple-framebuffer.txt          |  13 ++-
 drivers/video/fbdev/simplefb.c                     | 120 ++++++++++++++++++++-
 2 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.6.1

