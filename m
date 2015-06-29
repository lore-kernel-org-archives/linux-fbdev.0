From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:12:30 +0000
Subject: [PATCH v4 00/19] staging: sm750fb: checkpatch.pl fixes
Message-Id: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

This patch set includes 19 patches fixing indentation, spacing, brace placement
and missing blank lines from checkpatch.pl warnings/errors in staging/sm750fb.

Regards
Juston

-------------
Changes since v3:
 * Fix comment placement 16/19
 * Rebase to current staging-testing

Changes since v2:

 * Fix Subject
 * Don't rearrange lines in 01/19
 * Split up spacing fixes patch by checkpatch errors into 14 patches
 * Split up brace fixes patch by checkpatch errors in 3 patches

-------------
Diffstat:
 drivers/staging/sm750fb/ddk750_chip.c    |  15 +-
 drivers/staging/sm750fb/ddk750_chip.h    |  12 +-
 drivers/staging/sm750fb/ddk750_display.c | 170 ++++-----
 drivers/staging/sm750fb/ddk750_display.h |  11 +-
 drivers/staging/sm750fb/ddk750_dvi.c     |  75 ++--
 drivers/staging/sm750fb/ddk750_dvi.h     |   3 +-
 drivers/staging/sm750fb/ddk750_help.c    |   2 +-
 drivers/staging/sm750fb/ddk750_help.h    |   4 +-
 drivers/staging/sm750fb/ddk750_hwi2c.c   | 244 +++++++------
 drivers/staging/sm750fb/ddk750_mode.c    | 164 +++++----
 drivers/staging/sm750fb/ddk750_mode.h    |  52 ++-
 drivers/staging/sm750fb/ddk750_power.c   | 254 +++++++-------
 drivers/staging/sm750fb/ddk750_power.h   |  11 +-
 drivers/staging/sm750fb/ddk750_reg.h     |  18 +-
 drivers/staging/sm750fb/ddk750_sii164.c  | 389 ++++++++++-----------
 drivers/staging/sm750fb/ddk750_sii164.h  |  31 +-
 drivers/staging/sm750fb/sm750.c          |   2 +-
 drivers/staging/sm750fb/sm750.h          |  58 +--
 drivers/staging/sm750fb/sm750_accel.c    | 379 ++++++++++----------
 drivers/staging/sm750fb/sm750_accel.h    |   4 +-
 drivers/staging/sm750fb/sm750_cursor.c   |  51 ++-
 drivers/staging/sm750fb/sm750_help.h     |  28 +-
 drivers/staging/sm750fb/sm750_hw.c       | 218 ++++++------
 drivers/staging/sm750fb/sm750_hw.h       |  42 +--
 24 files changed, 1081 insertions(+), 1156 deletions(-)
