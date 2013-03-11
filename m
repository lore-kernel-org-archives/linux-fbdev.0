From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Date: Mon, 11 Mar 2013 07:32:33 +0000
Subject: [PATCH] matrox: fix coccicheck warning in matroxfb_base.c
Message-Id: <1362987153-6290-1-git-send-email-silviupopescu1990@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, linux-kernel@vger.kernel.org, Silviu-Mihai Popescu <silviupopescu1990@gmail.com>

This replaces a call to kmalloc() followed by memset() with just one
call to kzalloc().

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
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

