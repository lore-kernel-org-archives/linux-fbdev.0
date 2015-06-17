From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 17 Jun 2015 11:36:39 +0000
Subject: [PATCH v2 0/9] fix sm7xxfb
Message-Id: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

fixing the few remaining issues of sm7xxfb before sending the patch to
remove it from staging.
Also attempted to setup a tree and all the patches of this series are
available there for you.


The following changes since commit f0feeaff9c60bfb3dbadf09da15d70cf35700f29:

  staging: wilc1000: remove unwanted code (2015-06-16 19:23:25 -0700)

are available in the git repository at:

  git://git.vectorindia.net/staging staging-testing

for you to fetch changes up to e1acca34e255e7ed0c93d1a66dc06bda2000a1b0:

  staging: sm7xxfb: fix camelcase (2015-06-17 16:32:00 +0530)

----------------------------------------------------------------
Sudip Mukherjee (9):
      staging: sm7xxfb: declare struct as const
      staging: sm7xxfb: remove numvgamodes
      staging: sm7xxfb: add newline
      staging: sm7xxfb: no space after cast
      staging: sm7xxfb: fix alignment
      staging: sm7xxfb: reduce indention
      staging: sm7xxfb: move mode table
      staging: sm7xxfb: fix indention
      staging: sm7xxfb: fix camelcase

 drivers/staging/sm7xxfb/sm7xx.h   | 664 +----------------------------
 drivers/staging/sm7xxfb/sm7xxfb.c | 872 +++++++++++++++++++++++++++++++++-----
 2 files changed, 761 insertions(+), 775 deletions(-)

-- 
1.8.1.2

