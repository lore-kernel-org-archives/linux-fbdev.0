From: Marko Kohtala <marko.kohtala@okoko.fi>
Date: Tue, 18 Jun 2019 07:41:05 +0000
Subject: [PATCH 0/6] video: ssd1307fb: Support more displays
Message-Id: <20190618074111.9309-1-marko.kohtala@okoko.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

The kernel driver for ssd1307fb did not allow for all proper
initialization for a Densitron 128x36 display. The trend in the driver
has been to add devicetree properties for the controller initialization
and these patches continue on that trend.

There also were some sparse and Coccinelle errors.

A small bug causing scrolling on display updates with nonzero page_offset
was a bit surprising. It would seem the driver has only been used with
page_offset set to zero. Bug has been there since commit
301bc0675b677a98475187050d56cd2b39ff0acf ("video: ssd1307fb: Make use of
horizontal addressing mode").

Marko Kohtala (6):
  video: ssd1307fb: Use screen_buffer instead of screen_base
  video: ssd1307fb: Remove unneeded semicolons
  video: ssd1307fb: Start page range at page_offset
  video: ssd1307fb: Handle width and height that are not multiple of 8
  dt-bindings: display: ssd1307fb: Add initialization properties
  video: ssd1307fb: Add devicetree configuration of display setup

 .../devicetree/bindings/display/ssd1307fb.txt |  10 ++
 drivers/video/fbdev/ssd1307fb.c               | 130 ++++++++++++------
 2 files changed, 101 insertions(+), 39 deletions(-)

-- 
2.17.1
