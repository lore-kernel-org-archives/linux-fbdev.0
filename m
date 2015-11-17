From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 17 Nov 2015 04:31:01 +0000
Subject: [PATCH v5 0/2] simplefb: Add regulator handling support
Message-Id: <1447734663-19189-1-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi everyone,

This is v5 of the simplefb regulator support series. This series adds
regulator claiming and enabling support for simplefb.

Hans, I dropped your Reviewed-by tag from patch 2 since v4.

Changes since v5:
  - Rebased onto v4.4-rc1
  - Dropped dts patches (merged)

Changes since v4:
  - Fixed inverted logic when testing the property name.
  - Fixed regulator supply name string copy length off by 1.
  - Added real world user, MSI Primo 81 dts patches.

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

 .../bindings/display/simple-framebuffer.txt        |  13 ++-
 drivers/video/fbdev/simplefb.c                     | 120 ++++++++++++++++++++-
 2 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.6.2

