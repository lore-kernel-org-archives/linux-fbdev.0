From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 12 Oct 2015 17:04:16 +0000
Subject: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <1444669458-5588-1-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi everyone,

This series adds regulator claiming and enabling support for simplefb.

Sometimes the simplefb display output path consits of external conversion
chips and/or LCD drivers and backlights. These devices normally have
GPIOs to turn them on and/or bring them out of reset, and regulators
supplying power to them.

While the kernel does not touch unclaimed GPIOs, the regulator core
happily disables unused regulators. Thus we need simplefb to claim
and enable the regulators used throughout the display pipeline.

Now the DT bindings don't support a list of regulators directly, so
I'm working around it by having a "num-supplies" property to specify
the number of supply properties to check, and name the actual supplies
as "vinN-supply".

Hans, Maxime, AXP223 support for the A23/A33 Q8 tablets will need this
to keep the LCD on. The Primo81 needs this as well.


Patch 1 adds the regulator properties to the DT binding.

Patch 2 adds code to the simplefb driver to claim and enable regulators.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: simplefb: Support a list of regulator supply properties
  simplefb: Claim and enable regulators

 .../bindings/video/simple-framebuffer.txt          |  14 ++-
 drivers/video/fbdev/simplefb.c                     | 102 ++++++++++++++++++++-
 2 files changed, 111 insertions(+), 5 deletions(-)

-- 
2.5.3

