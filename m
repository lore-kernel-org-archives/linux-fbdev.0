From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH 2/6] pxa: frame buffer support both pxa168 and pxa910
Date: Tue, 3 Nov 2009 14:45:27 +0800
Message-ID: <7c34ac520911022245o4c8fd276vcaf0d8d106b77da3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net

pxa: frame buffer support both pxa168 and pxa910

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 27bdf2b..2ba1444 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -875,12 +875,18 @@ failed:
        return ret;
 }

+ static const struct platform_device_id mmpfb_id_table[] = {
+        {"pxa168-fb", 0},
+        {"pxa910-fb", 1},
+ };
+
 static struct platform_driver pxa168fb_driver = {
        .driver         = {
                .name   = "pxa168-fb",
                .owner  = THIS_MODULE,
        },
        .probe          = pxa168fb_probe,
+       .id_table       = mmpfb_id_table,
 };

 static int __devinit pxa168fb_init(void)
-- 
1.5.4.3
