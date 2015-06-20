From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 08:45:42 +0000
Subject: [PATCH 0/4] staging: sm750fb: checkpatch.pl fixes
Message-Id: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gisudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch set includes 4 patches fixing indentation, spacing, brace placement
and missing blank lines from checkpatch.pl warnings/errors in staging/sm750fb.

Regards
Juston

-------------
 drivers/staging/sm750fb/ddk750_chip.c    |  15 +--
 drivers/staging/sm750fb/ddk750_chip.h    |  12 +-
 drivers/staging/sm750fb/ddk750_display.c | 168 +++++++++++++-----------
 drivers/staging/sm750fb/ddk750_display.h |  11 +-
 drivers/staging/sm750fb/ddk750_dvi.c     |  75 +++++------
 drivers/staging/sm750fb/ddk750_dvi.h     |   3 +-
 drivers/staging/sm750fb/ddk750_help.c    |   2 +-
 drivers/staging/sm750fb/ddk750_help.h    |   4 +-
 drivers/staging/sm750fb/ddk750_hwi2c.c   | 244
++++++++++++++++++-----------------
 drivers/staging/sm750fb/ddk750_mode.c    | 164 +++++++++++------------
 drivers/staging/sm750fb/ddk750_mode.h    |  52 ++++----
 drivers/staging/sm750fb/ddk750_power.c   | 254
++++++++++++++++++------------------
 drivers/staging/sm750fb/ddk750_power.h   |  11 +-
 drivers/staging/sm750fb/ddk750_reg.h     |  18 +--
 drivers/staging/sm750fb/ddk750_sii164.c  | 394
+++++++++++++++++++++++++++++---------------------------
 drivers/staging/sm750fb/ddk750_sii164.h  |  32 ++---
 drivers/staging/sm750fb/sm750.c          |   2 +-
 drivers/staging/sm750fb/sm750.h          |  58 ++++-----
 drivers/staging/sm750fb/sm750_accel.c    | 374
++++++++++++++++++++++++++++-------------------------
 drivers/staging/sm750fb/sm750_accel.h    |   4 +-
 drivers/staging/sm750fb/sm750_cursor.c   |  49 +++----
 drivers/staging/sm750fb/sm750_help.h     |  28 ++--
 drivers/staging/sm750fb/sm750_hw.c       | 205 +++++++++++++++--------------
 drivers/staging/sm750fb/sm750_hw.h       |  42 +++---
 24 files changed, 1163 insertions(+), 1058 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
