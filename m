From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 22 Feb 2012 18:53:04 +0000
Subject: [PATCH 0/5] viafb misc patches
Message-Id: <cover.1329936280.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi all,

this is another patch series for viafb. 1 and 2 are fixes for 
previous patch series; 3 and 4 are fixes for our VX900 support; 
5 is a cleanup


Best regards,

Florian Tobias Schandinat


Florian Tobias Schandinat (5):
  viafb: another workaround for OLPCs weird wiring
  viafb: Fix bug in centering code
  viafb: select HW scaling on VX900 for IGA2
  viafb: fix IGA1 modesetting on VX900
  viafb: LCD bpp cleanup

 drivers/video/via/chip.h     |    1 -
 drivers/video/via/hw.c       |   22 +++++++---------------
 drivers/video/via/hw.h       |    2 +-
 drivers/video/via/lcd.c      |   21 ++++++++-------------
 drivers/video/via/viafbdev.c |    8 +++++---
 5 files changed, 21 insertions(+), 33 deletions(-)

-- 
1.7.9

