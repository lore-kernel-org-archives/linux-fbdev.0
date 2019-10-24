From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Thu, 24 Oct 2019 16:38:21 +0000
Subject: [PATCH 2/3] staging: sm750fb: align arguments with open parenthesis in file sm750_accel.h
Message-Id: <20191024163822.7157-3-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cleans up checks of "Alignment should match open parenthesis"
in file sm750_accel.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index c16350b5a310..2c79cb730a0a 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,9 +190,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-				u32 base, u32 pitch, u32 Bpp,
-				u32 x, u32 y, u32 width, u32 height,
-				u32 color, u32 rop);
+		      u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height,
+		      u32 color, u32 rop);
 
 /**
  * sm750_hm_copyarea
-- 
2.20.1
