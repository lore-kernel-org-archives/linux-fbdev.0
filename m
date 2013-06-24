From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 24 Jun 2013 14:16:53 +0000
Subject: [PATCHv2 0/2] HX8357 driver improvement
Message-Id: <1372083415-9734-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: jimwall@q.com, brian@crystalfontz.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

This is a set of improvements for the hx8357 driver. The first patch removes the
need to defines IM pins in the device tree. So that it is possible to use the
controller with fixed IM pins.

The second patch adds support for the Himax HX8369 controller which is quite
similar.

Tested on CFA-10055 (hx8357) and CFA-10056 (hx8369).

Alexandre Belloni (1):
  fb: backlight: HX8357: Add HX8369 support

Maxime Ripard (1):
  video: hx8357: Make IM pins optional

 drivers/video/backlight/hx8357.c | 256 +++++++++++++++++++++++++++++++++------
 1 file changed, 219 insertions(+), 37 deletions(-)

-- 
1.8.1.2

