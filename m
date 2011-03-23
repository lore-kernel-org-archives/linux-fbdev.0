From: Joe Perches <joe@perches.com>
Date: Wed, 23 Mar 2011 19:55:35 +0000
Subject: [PATCH 0/2] Fix resource size miscalculations
Message-Id: <cover.1300909445.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use resource_size a few places

Joe Perches (2):
  trivial: treewide: Fix iomap resource size miscalculations
  trivial: arm: mach-u300/gpio: Fix mem_region resource size miscalculations

 arch/arm/mach-u300/gpio.c         |    7 +++----
 arch/arm/mach-ux500/mbox-db5500.c |    6 ++----
 arch/mips/rb532/gpio.c            |    2 +-
 drivers/video/msm/mddi.c          |    2 +-
 drivers/watchdog/bcm63xx_wdt.c    |    2 +-
 5 files changed, 8 insertions(+), 11 deletions(-)

-- 
1.7.4.2.g597a6.dirty

