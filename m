From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:42:28 +0000
Subject: [PATCH] video: fbdev: msm: mddi.c:  Cleaning up variable that is never used
Message-Id: <1404672148-19061-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563514-20355-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563514-20355-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/msm/mddi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/msm/mddi.c b/drivers/video/fbdev/msm/mddi.c
index e0f8011..d65ff75a 100644
--- a/drivers/video/fbdev/msm/mddi.c
+++ b/drivers/video/fbdev/msm/mddi.c
@@ -257,12 +257,12 @@ static irqreturn_t mddi_isr(int irq, void *data)
 	struct msm_mddi_client_data *cdata = data;
 	struct mddi_info *mddi = container_of(cdata, struct mddi_info,
 					      client_data);
-	uint32_t active, status;
+	uint32_t active;
 
 	spin_lock(&mddi->int_lock);
 
 	active = mddi_readl(INT);
-	status = mddi_readl(STAT);
+	mddi_readl(STAT);
 
 	mddi_writel(active, INT);
 
@@ -548,7 +548,6 @@ uint32_t mddi_remote_read(struct msm_mddi_client_data *cdata, uint32_t reg)
 	struct mddi_llentry *ll;
 	struct mddi_register_access *ra;
 	struct reg_read_info ri;
-	unsigned s;
 	int retry_count = 2;
 	unsigned long irq_flags;
 
@@ -572,7 +571,7 @@ uint32_t mddi_remote_read(struct msm_mddi_client_data *cdata, uint32_t reg)
 	ll->next = 0;
 	ll->reserved = 0;
 
-	s = mddi_readl(STAT);
+	mddi_readl(STAT);
 
 	ri.reg = reg;
 	ri.status = -1;
-- 
1.7.10.4

