From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:50:04 +0000
Subject: [PATCH 0/8] sa1100fb updates
Message-Id: <20170929105004.GY20805@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Bart,

This series updates the sa1100fb fbdev driver's initialisation paths
to be more robust.  In doing these updates, I realised that we omitted
to free some memory which was allocated for the framebuffer if
initialisation fails - something that was hidden due to the complex
cleanup that the driver performs.  Switching to managed resources made
this more obvious.

Tested on H3600 iPAQ and Assabet.

 drivers/video/fbdev/sa1100fb.c | 75 +++++++++++++++---------------------------
 drivers/video/fbdev/sa1100fb.h |  2 ++
 2 files changed, 29 insertions(+), 48 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
