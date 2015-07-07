From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 07 Jul 2015 08:26:32 +0000
Subject: [PATCH 0/5] staging: sm7xxfb: few changes
Message-Id: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Few more changes in sm7xxfb, and hopefully the last changes before I
send the patch to move it to drivers/video/fbdev.

Has been tested with:
1) fbtest available at https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/
2) read and write tested on Little-Endian system


regards
sudip

Sudip Mukherjee (5):
  staging: sm7xxfb: remove unused macros
  staging: sm7xxfb: fix error handling
  staging: sm7xxfb: use kernel commandline
  staging: sm7xxfb: define new macros
  staging: sm7xxfb: usr fb_read and fb_write

 drivers/staging/sm7xxfb/sm7xx.h   | 39 +++++++++++-----------
 drivers/staging/sm7xxfb/sm7xxfb.c | 69 ++++++++++-----------------------------
 2 files changed, 37 insertions(+), 71 deletions(-)

-- 
1.8.1.2

