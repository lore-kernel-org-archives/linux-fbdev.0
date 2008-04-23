From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH v2] aty128fb: test below 0 on unsigned
	pll->post_divider
Date: Wed, 23 Apr 2008 21:24:58 +0200
Message-ID: <480F8D0A.8080808@tiscali.nl>
References: <480F81DC.5010505@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JokaW-0005B7-Tb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 12:25:05 -0700
Received: from smtp-out1.tiscali.nl ([195.241.79.176])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JokaV-0008Tk-4j
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 12:25:04 -0700
In-Reply-To: <480F81DC.5010505@tiscali.nl>
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
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>

Joe Perches wrote:
> 
> In both uses, sizeof(post_dividers) should be ARRAY_SIZE(post_dividers)
> Yes, it's an unsigned char array, it works, but it's unsightly.
> 
> cheers, Joe

Thanks Joe, updated patch below
---
pll->post_divider is unsigned, so the test fails

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index cbd3308..5049228 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1339,10 +1339,8 @@ static int aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
 	if (vclk * 12 < c.ppll_min)
 		vclk = c.ppll_min/12;
 
-	pll->post_divider = -1;
-
 	/* now, find an acceptable divider */
-	for (i = 0; i < sizeof(post_dividers); i++) {
+	for (i = 0; i < ARRAY_SIZE(post_dividers); i++) {
 		output_freq = post_dividers[i] * vclk;
 		if (output_freq >= c.ppll_min && output_freq <= c.ppll_max) {
 			pll->post_divider = post_dividers[i];
@@ -1350,7 +1348,7 @@ static int aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
 		}
 	}
 
-	if (pll->post_divider < 0)
+	if (i == ARRAY_SIZE(post_dividers))
 		return -EINVAL;
 
 	/* calculate feedback divider */



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
