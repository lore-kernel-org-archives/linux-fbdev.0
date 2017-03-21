From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 15:18:36 +0000
Subject: [PATCH v2 0/2] Remove Typedefs.
Message-Id: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, linux-iio@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

Typedefs are removed in sm750fb driver.

Arushi Singhal (2):
  staging: sm750fb: Remove typedef from "typedef struct _mode_parameter_t"
  staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"

 drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
 drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
changes in v2
 -change the spelling of coverpatch subject.
2.11.0

