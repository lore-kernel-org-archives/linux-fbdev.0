From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:29:57 +0000
Subject: [PATCH] video: fbdev: mb862xx: mb862xxfbdrv.c:  Cleaning up variable that is never used
Message-Id: <1404563397-20188-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563339-20105-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563339-20105-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Anatolij Gustschin <agust@denx.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 0cd4c33..24be945 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -273,7 +273,6 @@ static int mb862xxfb_set_par(struct fb_info *fbi)
 static int mb862xxfb_pan(struct fb_var_screeninfo *var,
 			 struct fb_info *info)
 {
-	struct mb862xxfb_par *par = info->par;
 	unsigned long reg;
 
 	reg = pack(var->yoffset, var->xoffset);
@@ -286,7 +285,6 @@ static int mb862xxfb_pan(struct fb_var_screeninfo *var,
 
 static int mb862xxfb_blank(int mode, struct fb_info *fbi)
 {
-	struct mb862xxfb_par  *par = fbi->par;
 	unsigned long reg;
 
 	dev_dbg(fbi->dev, "blank mode=%d\n", mode);
@@ -548,7 +546,6 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
-	struct mb862xxfb_par *par = fbi->par;
 	char *ptr = buf;
 	unsigned int reg;
 
-- 
1.7.10.4

