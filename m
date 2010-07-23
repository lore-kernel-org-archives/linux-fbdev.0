From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:19 +0000
Subject: [PATCH 04/11] viafb: add lcd scaling support for some IGPs
Message-Id: <1279899566-4359-5-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: add lcd scaling support for some IGPs

These IGPs should also support lcd scaling but likely this switch was
missed when adding support for them. Fix it, allowing lcd scaling on
CN750, VX800 and VX855. At least this improves the situation for
VX855. (there seems to be another scaling unrelated bug somewhere)

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/lcd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
index 55cb4ec..568d15b 100644
--- a/drivers/video/via/lcd.c
+++ b/drivers/video/via/lcd.c
@@ -458,6 +458,9 @@ static void load_lcd_scaling(int set_hres, int set_vres, int panel_hres,
 		case UNICHROME_K8M890:
 		case UNICHROME_P4M890:
 		case UNICHROME_P4M900:
+		case UNICHROME_CN750:
+		case UNICHROME_VX800:
+		case UNICHROME_VX855:
 			reg_value  			    K800_LCD_HOR_SCF_FORMULA(set_hres, panel_hres);
 			/* Horizontal scaling enabled */
@@ -498,6 +501,9 @@ static void load_lcd_scaling(int set_hres, int set_vres, int panel_hres,
 		case UNICHROME_K8M890:
 		case UNICHROME_P4M890:
 		case UNICHROME_P4M900:
+		case UNICHROME_CN750:
+		case UNICHROME_VX800:
+		case UNICHROME_VX855:
 			reg_value  			    K800_LCD_VER_SCF_FORMULA(set_vres, panel_vres);
 			/* Vertical scaling enabled */
-- 
1.6.3.2

