From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:39:48 +0000
Subject: [PATCH 0/6] video: udlfb: (not only) Logging cleanup
Message-Id: <20171211213948.GA29173@lenoch>
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

Ladislav Michl (6):
  video: udlfb: Do not name private data 'dev'
  video: udlfb: Remove unnecessary 'return'
  video: udlfb: Remove unnecessary local variable
  video: udlfb: Delete error messages for failed allocations
  video: udlfb: Remove redundant gdev variable
  video: udlfb: Switch from the pr_*() to the dev_*() logging functions

 drivers/video/fbdev/udlfb.c | 617 ++++++++++++++++++++------------------------
 include/video/udlfb.h       |   3 +-
 2 files changed, 284 insertions(+), 336 deletions(-)

