From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 17:33:32 +0000
Subject: [PATCH AUTOSEL 4.9 063/251] fbdev: chipsfb: remove set but not used variable 'size'
Message-Id: <20200116173641.22137-23-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 8e71fa5e4d86bedfd26df85381d65d6b4c860020 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
drivers/video/fbdev/chipsfb.c:352:22: warning:
 variable 'size' set but not used [-Wunused-but-set-variable]

Fixes: 8c8709334cec ("[PATCH] ppc32: Remove CONFIG_PMAC_PBOOK").
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
[b.zolnierkie: minor commit summary and description fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/chipsfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 59abdc6a97f6..314b7eceb81c 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -350,7 +350,7 @@ static void init_chips(struct fb_info *p, unsigned long addr)
 static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
 	struct fb_info *p;
-	unsigned long addr, size;
+	unsigned long addr;
 	unsigned short cmd;
 	int rc = -ENODEV;
 
@@ -362,7 +362,6 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	if ((dp->resource[0].flags & IORESOURCE_MEM) = 0)
 		goto err_disable;
 	addr = pci_resource_start(dp, 0);
-	size = pci_resource_len(dp, 0);
 	if (addr = 0)
 		goto err_disable;
 
-- 
2.20.1
