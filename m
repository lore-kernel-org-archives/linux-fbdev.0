From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sun, 05 Mar 2017 11:36:47 +0000
Subject: [PATCH 0/3] multiple checkpatch issues
Message-Id: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

Improve readability by fixing multiple checkpatch.pl
issues in sm750fb driver. 

Arushi Singhal (3):
  staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
  staging: sm750fb: function prototype argument should have an identifier name
  staging: sm750fb: Alignment should match open parenthesis

 drivers/staging/sm750fb/ddk750_display.h |  3 +-
 drivers/staging/sm750fb/ddk750_mode.c    | 69 ++++++++++++++++----------------
 drivers/staging/sm750fb/ddk750_mode.h    |  4 +-
 drivers/staging/sm750fb/ddk750_power.h   |  3 +-
 drivers/staging/sm750fb/sm750.h          |  2 +-
 drivers/staging/sm750fb/sm750_cursor.c   |  3 ++
 6 files changed, 45 insertions(+), 39 deletions(-)

-- 
2.11.0

