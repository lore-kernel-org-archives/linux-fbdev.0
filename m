From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 04 Jan 2018 19:36:23 +0000
Subject: [PATCH v2 0/5] video: udlfb: (not only) Logging cleanup
Message-Id: <20180104193623.GA22612@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patchset is a side product of debugging on unreliable USB host
where devices saw a lot of disconnects. It turned out that udlfb
logging is just too noisy to be usefull as produced syslog is hard
to read.

Hence this attempt to clean things up.

Comments and suggestions welcome and appreciated, as always.

Changes in v2:
- Dropped patch "Delete error messages for failed allocations"
- Dropped patch "Remove unnecessary 'return'"
- Added patch "Remove noisy warnings"
- Reordered patches
- Rebased against next-20180104
  Please note as kernel compilation fails with:
    kernel/exit.o: In function `__crc_abort':
    exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
    Makefile:1029: recipe for target 'vmlinux' failed
  this patchset is not runtime tested.

Ladislav Michl (5):
  video: udlfb: Remove unnecessary local variable
  video: udlfb: Remove redundant gdev variable
  video: udlfb: Remove noisy warnings
  video: udlfb: Do not name private data 'dev'
  video: udlfb: Switch from the pr_*() to the dev_*() logging functions

 drivers/video/fbdev/udlfb.c | 635 +++++++++++++++++++++-----------------------
 include/video/udlfb.h       |   3 +-
 2 files changed, 302 insertions(+), 336 deletions(-)

-- 
2.15.1

