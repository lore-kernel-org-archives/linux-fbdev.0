From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Feb 2015 14:53:48 +0000
Subject: [PATCH 0/2] staging: sm7xxfb: checkpatch cleanup
Message-Id: <1422975214-15250-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Hi,
Continuing with the checkpatch cleanup, this series will just fix the CamelCase.
Two different patches are made just to make review easier.
Now there is only one checkpatch warning pending about __setup, which will be fixed
in one of the upcoming patch where I will introduce the use of fb_get_options() and
that will also fix the compilation warning of unused function.

thanks
sudip

Sudip Mukherjee (2):
  staging: sm7xxfb: fix camelcase
  staging: sm7xxfb: fix remaining camelcase

 drivers/staging/sm7xxfb/sm7xx.h   | 44 ++++++++++++++---------------
 drivers/staging/sm7xxfb/sm7xxfb.c | 58 +++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 51 deletions(-)

-- 
1.8.1.2

