From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 05 Dec 2009 23:24:47 +0000
Subject: [PATCH 1/2] viafb: Documentation update
Message-Id: <1260055488-10833-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Harald Welte <laforge@gnumonks.org>, Harald Welte <HaraldWelte@viatech.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Harald Welte <laforge@gnumonks.org>

viafb: Documentation update

We now support the VX855, and the VX800 is no longer unaccellerated.
viafb_video_dev was removed as it was useless.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 Documentation/fb/viafb.txt |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/Documentation/fb/viafb.txt b/Documentation/fb/viafb.txt
index 67dbf44..f3e046a 100644
--- a/Documentation/fb/viafb.txt
+++ b/Documentation/fb/viafb.txt
@@ -7,7 +7,7 @@
     VIA UniChrome Family(CLE266, PM800 / CN400 / CN300,
                         P4M800CE / P4M800Pro / CN700 / VN800,
                         CX700 / VX700, K8M890, P4M890,
-                        CN896 / P4M900, VX800)
+                        CN896 / P4M900, VX800, VX855)
 
 [Driver features]
 ------------------------
@@ -154,13 +154,6 @@
         0 : No Dual Edge Panel (default)
         1 : Dual Edge Panel
 
-    viafb_video_dev:
-        This option is used to specify video output devices(CRT, DVI, LCD) for
-        duoview case.
-        For example:
-        To output video on DVI, we should use:
-            modprobe viafb viafb_video_dev=DVI...
-
     viafb_lcd_port:
         This option is used to specify LCD output port,
         available values are "DVP0" "DVP1" "DFP_HIGHLOW" "DFP_HIGH" "DFP_LOW".
@@ -181,9 +174,6 @@ Notes:
        and bpp, need to call VIAFB specified ioctl interface VIAFB_SET_DEVICE
        instead of calling common ioctl function FBIOPUT_VSCREENINFO since
        viafb doesn't support multi-head well, or it will cause screen crush.
-    4. VX800 2D accelerator hasn't been supported in this driver yet. When
-       using driver on VX800, the driver will disable the acceleration
-       function as default.
 
 
 [Configure viafb with "fbset" tool]
-- 
1.6.3.2

