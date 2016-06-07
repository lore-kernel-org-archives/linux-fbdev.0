From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 07 Jun 2016 13:51:11 +0000
Subject: [PATCH 0/3] fbdev: ssd1307fb: Make reset-gpios optional property
Message-Id: <cover.1465303439.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Use gpiod for reset-gpios property and make it optional. Also removes
the nerver implemented reset-active-low property from the devicetree
binding document. The default gpio binding should be enough.

Jyri Sarha (3):
  fbdev: ssd1307fb: Start to use gpiod API for reset gpio
  fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
  fbdev: ssd1307fb: Make reset gpio devicetree property optional

 .../devicetree/bindings/display/ssd1307fb.txt      |  4 +--
 drivers/video/fbdev/ssd1307fb.c                    | 38 ++++++++++------------
 2 files changed, 20 insertions(+), 22 deletions(-)

-- 
1.9.1

