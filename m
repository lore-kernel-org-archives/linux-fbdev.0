From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Thu, 24 Oct 2019 16:38:19 +0000
Subject: [PATCH 0/3] staging: sm750fb: align arguments with open parenthesis
Message-Id: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cleans up checks of "Alignment should match open parenthesis"
in tree sm750fb

Gabriela Bittencourt (3):
  staging: sm750fb: align arguments with open parenthesis in
    ddk750_sii164.c
  staging: sm750fb: align arguments with open parenthesis in file
    sm750_accel.h
  staging: sm750fb: align arguments with open parenthesis in file
    sm750_cursor.h

 drivers/staging/sm750fb/ddk750_sii164.c |  2 +-
 drivers/staging/sm750fb/sm750_accel.h   |  6 +++---
 drivers/staging/sm750fb/sm750_cursor.h  | 17 +++++++----------
 3 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.20.1
