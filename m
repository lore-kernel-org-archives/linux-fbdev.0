From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Sun, 05 Apr 2015 01:53:47 +0000
Subject: [PATCH] Staging: sm750fb: Remove extra parentheses around right bit shift operation
Message-Id: <20150405014147.GA9738@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Removes extra parentheses around bitwise right shift operation.

The issue was detected using the following coccinelle script.
@@
expression e, e1;
constant c;
@@

e -(e1
+e1
<<
-c);
+c;

@@
identifier i;
constant c;
type t;
expression e;
@@

t i -(e
+e
<<
-c);
+c;

@@
expression e, e1;
identifier f;
constant c;
@@

e1 = f(...,
-(e
+e
<<
-c)
+c
,...);


Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4074375..626b841 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -737,7 +737,7 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
                 output->paths = sm750_crt;
                 crtc->channel = sm750_secondary;
                 /* not consider of padding stuffs for oScreen,need fix*/
-                crtc->oScreen = (share->vidmem_size >> 1);
+                crtc->oScreen = share->vidmem_size >> 1;
                 crtc->vScreen = share->pvMem + crtc->oScreen;
             }
             break;
@@ -751,7 +751,7 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
                 output->paths = sm750_crt;
                 crtc->channel = sm750_primary;
                 /* not consider of padding stuffs for oScreen,need fix*/
-                crtc->oScreen = (share->vidmem_size >> 1);
+                crtc->oScreen = share->vidmem_size >> 1;
                 crtc->vScreen = share->pvMem + crtc->oScreen;
             }
             break;
-- 
1.9.1

