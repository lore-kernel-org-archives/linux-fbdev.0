From: Christoph Hellwig <hch@lst.de>
Date: Sat, 13 Oct 2018 15:17:00 +0000
Subject: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to dma_alloc_coherent
Message-Id: <20181013151707.32210-2-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cpufreq/tegra186-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 1f59966573aa..f1e09022b819 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -121,7 +121,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
 	void *virt;
 
 	virt = dma_alloc_coherent(bpmp->dev, sizeof(*data), &phys,
-				  GFP_KERNEL | GFP_DMA32);
+				  GFP_KERNEL);
 	if (!virt)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.19.1
