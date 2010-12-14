From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 10:05:48 +0000
Subject: [GIT PULL] fbdev updates for 2.6.37-rc6
Message-Id: <20101214100548.GA15297@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git fbdev-fixes-for-linus

Which contains:

Andrew Kephart (1):
      fbdev: Fix fb_find_nearest_mode refresh comparison

 drivers/video/modedb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
