From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 11:38:37 +0000
Subject: [PATCH 0/2] Remove Typrdefs
Message-Id: <20170321112639.32495-1-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: w.d.hubbs@gmail.com
Cc: linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com, teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

Typedefs are removed in sm750fb driver.

Arushi Singhal (2):
  staging: sm750fb: Remove typedefs from struct
  staging: sm750fb: Remove typedefs from enum

 drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
 drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.11.0

