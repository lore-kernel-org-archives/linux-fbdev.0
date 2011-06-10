From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 10 Jun 2011 15:23:00 +0000
Subject: [PATCH 0/4] fbdev: au1200fb updates
Message-Id: <1307719384-23702-1-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Here are 4 updates to the au1200fb codebase to get it to work and compile
again, also with PM enabled.

Run and PM-tested on DB1200 and DB1300.

Manuel Lauss (4):
  au1200fb: use framebuffer_alloc()
  au1200fb: fixup PM
  au1200fb: make number of windows configurable at load time.
  au1200fb: switch to FB_SYS helpers

 drivers/video/Kconfig    |    7 +-
 drivers/video/au1200fb.c |  285 ++++++++++++++++++++--------------------------
 2 files changed, 128 insertions(+), 164 deletions(-)

-- 
1.7.5.3

