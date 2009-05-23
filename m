From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 05/14] viafb: pass reference to pci
	device when calling framebuffer_alloc()
Date: Sat, 23 May 2009 17:41:27 +0800
Message-ID: <1243071696-9334-5-git-send-email-HaraldWelte@viatech.com>
References: <1243071696-9334-1-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-2-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-3-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-4-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M7nsK-0000Jp-MA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:44 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7ns6-0007tq-Qp
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:38 +0000
In-Reply-To: <1243071696-9334-4-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/via/viafbdev.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 3040dd9..7e8f2f6 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -2128,7 +2128,8 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
 	 * variables
 	*/
 	viafbinfo = framebuffer_alloc(viafb_par_length + 2 * lvds_length +
-	tmds_length + crt_length + chip_length, NULL);
+				      tmds_length + crt_length + chip_length,
+				      &pdev->dev);
 	if (!viafbinfo) {
 		printk(KERN_ERR"Could not allocate memory for viafb_info.\n");
 		return -ENOMEM;
-- 
1.6.2.4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
