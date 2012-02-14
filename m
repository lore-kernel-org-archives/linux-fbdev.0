From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 14 Feb 2012 05:51:23 +0000
Subject: [PATCH 0/4] implement viafb SAMM mode
Message-Id: <cover.1329194838.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi all,

this patch series implements viafb single adapter multiple monitor 
mode in a useful way. It allows showing the same image on 2 devices 
with different video modes by centering the smaller image.
It is useful for presentation or similar tasks, whenever dual fb is 
not desired. I have now used it for quite some time.


Best regards,

Florian Tobias Schandinat


Florian Tobias Schandinat (4):
  viafb: set correct polarity for second adapter
  viafb: fill xres and yres
  viafb: make single framebuffer multiple adapter mode work
  viafb: make SAMM to also work on LCD

 drivers/video/via/chip.h |    2 -
 drivers/video/via/dvi.c  |    5 ++-
 drivers/video/via/dvi.h  |    3 +-
 drivers/video/via/hw.c   |   85 +++++++++++++++++++++++----------------------
 drivers/video/via/hw.h   |    3 +-
 drivers/video/via/lcd.c  |   18 +++++-----
 drivers/video/via/lcd.h  |    3 +-
 7 files changed, 61 insertions(+), 58 deletions(-)

-- 
1.7.9

