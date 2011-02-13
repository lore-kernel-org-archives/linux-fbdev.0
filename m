From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 13 Feb 2011 22:11:22 +0000
Subject: [PATCH 0/6] sisfb: XGI Z9 POST
Message-Id: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Here's some patches to get POST working with XGI Z9. I have tested them
with the following card:

	http://www.roboard.com/Files/RB-100/MiniPCI-VGA-Z9s_UM_v1r1A.pdf

I'm using the card on an ARM board where the bootloader knows nothing
about VGA or VGA BIOS, so having POST support in the kernel driver
is mandatory. With these patches the memory size is correct detected,
R/W test passes and it's possible to use e.g. framebuffer console.

Aaro Koskinen (6):
  sisfb: POST should fail if R/W test fails
  sisfb: move XGI POST RAM type detection into a subroutine
  sisfb: add subroutine for detecting XGI Z9
  sisfb: add RAM type detection for XGI Z9
  sisfb: move XGI POST DDR2 bootup code into subroutines
  sisfb: add support for XGI Z9 DDR2 POST

 drivers/video/sis/sis.h      |    1 +
 drivers/video/sis/sis_main.c |  315 ++++++++++++++++++++++++++++++------------
 drivers/video/sis/vgatypes.h |    1 +
 3 files changed, 228 insertions(+), 89 deletions(-)

