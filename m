From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:50 +0000
Subject: [PATCH 0/9] staging: sm750fb: cleaning code
Message-Id: <1494453359-3722-1-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Folowing patches are cleaning some warnings and checkups from checkpatch.pl

Matej Dujava (9):
  staging: sm750fb: fix length of lines
  staging: sm750fb: unifying macro definitions
  staging: sm750fb: reordering of macro definitions
  staging: sm750fb: removing unnecessary binary operations
  staging: sm750fb: Remove typedef from "typedef enum
    _logical_chip_type_t"
  staging: sm750fb: Remove typedef from "typedef enum _clock_type"
  staging: sm750fb: Remove typedef from "typedef enum _disp_output_t"
  staging: sm750fb: Remove typedef from "typedef enum _DPMS_t"
  staging: sm750fb: Remove typedef from "typedef enum
    _sii164_hot_plug_mode_t"

 drivers/staging/sm750fb/ddk750_chip.c    | 11 ++--
 drivers/staging/sm750fb/ddk750_chip.h    | 16 +++---
 drivers/staging/sm750fb/ddk750_display.c |  2 +-
 drivers/staging/sm750fb/ddk750_display.h | 86 ++++++++++++++++----------------
 drivers/staging/sm750fb/ddk750_dvi.c     | 35 +++++++------
 drivers/staging/sm750fb/ddk750_dvi.h     | 43 ++++++++--------
 drivers/staging/sm750fb/ddk750_hwi2c.c   | 37 +++++---------
 drivers/staging/sm750fb/ddk750_mode.c    |  2 +-
 drivers/staging/sm750fb/ddk750_power.c   |  2 +-
 drivers/staging/sm750fb/ddk750_power.h   |  7 ++-
 drivers/staging/sm750fb/ddk750_sii164.c  | 49 ++++++++----------
 drivers/staging/sm750fb/ddk750_sii164.h  | 26 +++++-----
 drivers/staging/sm750fb/ddk750_swi2c.c   | 21 +++-----
 drivers/staging/sm750fb/ddk750_swi2c.h   | 18 ++-----
 drivers/staging/sm750fb/sm750.c          | 26 +++++-----
 drivers/staging/sm750fb/sm750.h          |  6 +--
 drivers/staging/sm750fb/sm750_accel.c    | 15 +++---
 drivers/staging/sm750fb/sm750_cursor.c   | 17 +++----
 drivers/staging/sm750fb/sm750_hw.c       |  4 +-
 19 files changed, 193 insertions(+), 230 deletions(-)

-- 
1.8.3.1

