From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:51 +0000
Subject: [PATCH 0/6] staging: sm750fb: fixed all build warnings
Message-Id: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi Greg,
all the build warnings have been taken care of in this series.
some of the patches will generate a few checkpatch warning and for some I tried
to address few of the chcekpatch warnings while modifying them.

regards
sudip


Sudip Mukherjee (6):
  staging: sm750fb: remove unused functions
  staging: sm750fb: remove unused variables
  staging: sm750fb: correct function return
  staging: sm750fb: correct incompatible pointer type
  staging: sm750fb: fix mixed declarations
  staging: sm750fb: correct integer comparison

 drivers/staging/sm750fb/ddk750_display.c | 11 -----
 drivers/staging/sm750fb/ddk750_swi2c.c   |  8 ----
 drivers/staging/sm750fb/sm750.c          | 70 ++------------------------------
 drivers/staging/sm750fb/sm750.h          | 11 ++---
 drivers/staging/sm750fb/sm750_accel.c    |  4 +-
 drivers/staging/sm750fb/sm750_accel.h    |  4 +-
 drivers/staging/sm750fb/sm750_cursor.c   |  5 +--
 7 files changed, 14 insertions(+), 99 deletions(-)

-- 
1.8.1.2

