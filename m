From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 12 Nov 2013 03:32:12 +0000
Subject: [PATCH 5/5] pcmcia: sa1111: make use of device clock
Message-Id: <1384227132-10501-5-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use per-device clock (instead of calling cpufreq_get(0), which can
return 0 if no cpu frequency driver is selected) to program timings.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/sa1111_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 65b02c3..c5988be 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -145,6 +145,9 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 			return -ENOMEM;
 
 		s->soc.nr = ops->first + i;
+		s->soc.clk = clk_get(&dev->dev, NULL);
+		if (IS_ERR(s->soc.clk))
+			return -ENODEV;
 		soc_pcmcia_init_one(&s->soc, ops, &dev->dev);
 		s->dev = dev;
 		if (s->soc.nr) {
@@ -220,6 +223,7 @@ static int pcmcia_remove(struct sa1111_dev *dev)
 	for (; s; s = next) {
 		next = s->next;
 		soc_pcmcia_remove_one(&s->soc);
+		clk_put(s->soc.clk);
 		kfree(s);
 	}
 
-- 
1.8.4.2

