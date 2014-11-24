From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 24 Nov 2014 23:05:36 +0000
Subject: [PATCH V2 6/6] pcmcia: sa1100: make use of device clock
Message-Id: <1416870336-30114-7-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use per-device clock (instead of calling cpufreq_get(0), which can
return 0 if no cpu frequency driver is selected) to program timings.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/sa1100_generic.c |  1 +
 drivers/pcmcia/sa11xx_base.c    | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index ff8a027..d2ab060 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -93,6 +93,7 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
+	clk_put(sinfo->clk);
 	kfree(sinfo);
 	return 0;
 }
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 54d3089..cf6de2c 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -135,14 +135,16 @@ sa1100_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 static int
 sa1100_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
 {
-	return sa1100_pcmcia_set_mecr(skt, cpufreq_get(0));
+	unsigned long clk = clk_get_rate(skt->clk);
+
+	return sa1100_pcmcia_set_mecr(skt, clk / 1000);
 }
 
 static int
 sa1100_pcmcia_show_timing(struct soc_pcmcia_socket *skt, char *buf)
 {
 	struct soc_pcmcia_timing timing;
-	unsigned int clock = cpufreq_get(0);
+	unsigned int clock = clk_get_rate(skt->clk);
 	unsigned long mecr = MECR;
 	char *p = buf;
 
@@ -218,6 +220,11 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	struct skt_dev_info *sinfo;
 	struct soc_pcmcia_socket *skt;
 	int i, ret = 0;
+	struct clk *clk;
+
+	clk = clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	sa11xx_drv_pcmcia_ops(ops);
 
@@ -226,12 +233,14 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 		return -ENOMEM;
 
 	sinfo->nskt = nr;
+	sinfo->clk = clk;
 
 	/* Initialize processor specific parameters */
 	for (i = 0; i < nr; i++) {
 		skt = &sinfo->skt[i];
 
 		skt->nr = first + i;
+		skt->clk = clk;
 		soc_pcmcia_init_one(skt, ops, dev);
 
 		ret = sa11xx_drv_pcmcia_add_one(skt);
@@ -242,6 +251,7 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	if (ret) {
 		while (--i >= 0)
 			soc_pcmcia_remove_one(&sinfo->skt[i]);
+		clk_put(clk);
 		kfree(sinfo);
 	} else {
 		dev_set_drvdata(dev, sinfo);
-- 
2.1.3

