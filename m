From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 09 Mar 2012 15:02:14 +0000
Subject: [PATCH 0/2] some da8xx-fb driver updates
Message-Id: <1331305336-32644-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

  fbdev: da8xx:: fix reporting of the display timing info
  fbdev: da8xx: add support for SP10Q010 display

 drivers/video/Kconfig    |    1 +
 drivers/video/da8xx-fb.c |   51 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletions(-)

-- 
1.7.7.6

