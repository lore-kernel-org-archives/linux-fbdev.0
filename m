From: York Sun <yorksun@freescale.com>
Subject: [PATCH 2/2] Bug fix. Add sanity check for AOI
	position
Date: Wed, 13 Aug 2008 15:55:04 -0500
Message-ID: <1218660906446-git-send-email-yorksun@freescale.com>
References: <12186609042933-git-send-email-yorksun@freescale.com>
	<12186609063047-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTNNk-0004IW-O6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:55:51 -0700
Received: from az33egw01.freescale.net ([192.88.158.102])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KTNNj-00054p-HO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 13:55:48 -0700
In-Reply-To: <12186609063047-git-send-email-yorksun@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, galak@kernel.crashing.org

AOI position cannot be negative.

Signed-off-by: York Sun <yorksun@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index d67e79b..8898d2a 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -479,6 +479,10 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 	base_plane_width = machine_data->fsl_diu_info[0]->var.xres;
 	base_plane_height = machine_data->fsl_diu_info[0]->var.yres;
 
+	if (mfbi->x_aoi_d < 0)
+		mfbi->x_aoi_d = 0;
+	if (mfbi->y_aoi_d < 0)
+		mfbi->y_aoi_d = 0;
 	switch (index) {
 	case 0:
 		if (mfbi->x_aoi_d != 0)
-- 
1.5.2.2


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
