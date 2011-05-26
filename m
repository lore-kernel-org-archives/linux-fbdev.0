From: Andy Lutomirski <luto@MIT.EDU>
Date: Thu, 26 May 2011 14:13:30 +0000
Subject: [PATCH 0/4] efifb speedup and fixes
Message-Id: <cover.1306418703.git.luto@mit.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fbcon over efifb is so slow that I thought I needed a faster modem.
It turns out that scrolling boot messages at 1024x768 pixels with
uncached accesses can take longer than every other step of kernel
bootup *combined*.

Fixing it is a one-liner, but I found some bugs while I was digging
around.  One is a mismatched resource release (although not on my
box), one is a harmless compiler warning, and one fixes all manner of
badness that happens if you manually bind or unbind the efifb driver.

The speedup may or may not be 2.6.40 material, but the other fixes
should probably go in.  (2/4 and 4/4 are possibly -stable candidates.)

Andy Lutomirski (4):
  efifb: Enable write-combining
  efifb: Fix mismatched request/release_mem_region
  efifb: Fix an integer-to-pointer size warning
  efifb: Disallow manual bind and unbind

Andy Lutomirski (4):
  efifb: Enable write-combining
  efifb: Fix mismatched request/release_mem_region
  efifb: Fix an integer-to-pointer size warning
  efifb: Disallow manual bind and unbind

 drivers/video/efifb.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

-- 
1.7.5.1

