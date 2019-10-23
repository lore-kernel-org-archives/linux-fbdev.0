From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Wed, 23 Oct 2019 16:30:12 +0000
Subject: [PATCH v3 0/2] staging: sm750fb: format description of parameters to the kernel-doc format
Message-Id: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cluster comments that describes parameters of functions and create one
single comment before the function in kernel doc format.

Gabriela Bittencourt (2):
  staging: sm750fb: format description of parameters in accel.c
  staging: sm750fb: format description of parameters in accel.h

 drivers/staging/sm750fb/sm750_accel.c | 72 +++++++++++++++----------
 drivers/staging/sm750fb/sm750_accel.h | 75 ++++++++++++++++-----------
 2 files changed, 90 insertions(+), 57 deletions(-)

-- 
2.20.1
