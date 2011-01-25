From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 09:51:59 +0000
Subject: [GIT PULL] fbdev updates for 2.6.38-rc3
Message-Id: <20110125095159.GA18633@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Amerigo Wang (1):
      video: fix some comments in drivers/video/console/vgacon.c

Axel Lin (5):
      video: nuc900fb: fix compile error
      video: nuc900fb: properly free resources in nuc900fb_remove
      video: pxa3xx-gcu: Return -EFAULT when copy_from_user() fails
      video: da8xx-fb: fix fb_probe error path
      video: pxa168fb: remove a redundant pxa168fb_check_var call

Julia Lawall (1):
      drivers/video/bf537-lq035.c: Add missing IS_ERR test

Paul Mundt (1):
      mailmap: Add an entry for Axel Lin.

 .mailmap                       |    1 +
 drivers/video/bf537-lq035.c    |   58 ++++++++++++++++++++++-----------------
 drivers/video/console/vgacon.c |    6 +---
 drivers/video/da8xx-fb.c       |    3 +-
 drivers/video/nuc900fb.c       |    6 +++-
 drivers/video/pxa168fb.c       |    6 +---
 drivers/video/pxa3xx-gcu.c     |    4 +-
 7 files changed, 44 insertions(+), 40 deletions(-)
