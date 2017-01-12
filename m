From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 12 Jan 2017 11:16:26 +0000
Subject: [PATCH 0/6] fbdev/ssd1307fb: Some changes and improvement
Message-Id: <cover.1484219137.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

We needed these changes for couple of our evm. Everything else is quite
straight forward, but removing the reset-active-low dts property is a
questionable at least in theory. However, in practice if anyone was
using the property in their device-tree blobs, they have never been
able to get desired effect with mainline kernel.

Jyri Sarha (3):
  fbdev: ssd1307fb: Start to use gpiod API for reset gpio
  fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
  fbdev: ssd1307fb: Make reset gpio devicetree property optional

Tomi Valkeinen (3):
  fbdev/ssd1307fb: add support to enable VBAT
  fbdev/ssd1307fb: clear screen in probe
  fbdev/ssd1307fb: add support to enable VBAT

 .../devicetree/bindings/display/ssd1307fb.txt      |  5 +-
 drivers/video/fbdev/ssd1307fb.c                    | 55 ++++++++++++++--------
 2 files changed, 38 insertions(+), 22 deletions(-)

-- 
1.9.1

