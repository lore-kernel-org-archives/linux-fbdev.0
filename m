From: Andrei Epure <epure.andrei@gmail.com>
Date: Wed, 27 Mar 2013 20:12:19 +0000
Subject: [PATCH] drivers: video: matrox: changed kmalloc+memset with kzalloc
Message-Id: <1364415139-22303-1-git-send-email-epure.andrei@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrei Epure <epure.andrei@gmail.com>

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/video/matrox/matroxfb_base.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 401a56e..2456529 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -2029,10 +2029,9 @@ static int matroxfb_probe(struct pci_dev* pdev, const struct pci_device_id* dumm
 		return -1;
 	}
 
-	minfo = kmalloc(sizeof(*minfo), GFP_KERNEL);
+	minfo = kzalloc(sizeof(*minfo), GFP_KERNEL);
 	if (!minfo)
 		return -1;
-	memset(minfo, 0, sizeof(*minfo));
 
 	minfo->pcidev = pdev;
 	minfo->dead = 0;
-- 
1.7.9.5

