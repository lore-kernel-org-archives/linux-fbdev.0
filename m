From: Julia Lawall <julia@diku.dk>
Date: Thu, 13 May 2010 20:07:11 +0000
Subject: [PATCH 18/20] drivers/video/matrox: Use kzalloc
Message-Id: <Pine.LNX.4.64.1005132206530.6282@ask.diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than the combination of kmalloc and memset.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,size,flags;
statement S;
@@

-x = kmalloc(size,flags);
+x = kzalloc(size,flags);
 if (x = NULL) S
-memset(x, 0, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/matrox/matroxfb_base.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -2040,10 +2040,9 @@ static int matroxfb_probe(struct pci_dev
 		return -1;
 	}
 
-	minfo = kmalloc(sizeof(*minfo), GFP_KERNEL);
+	minfo = kzalloc(sizeof(*minfo), GFP_KERNEL);
 	if (!minfo)
 		return -1;
-	memset(minfo, 0, sizeof(*minfo));
 
 	minfo->pcidev = pdev;
 	minfo->dead = 0;
