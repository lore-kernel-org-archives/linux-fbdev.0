From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: fix clock doubling
Date: Wed, 4 Mar 2009 18:38:12 +0100
Message-ID: <20090304183812.90a996f4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Leuxd-00038x-V7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Mar 2009 17:32:49 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LeuxY-0004Zd-I4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Mar 2009 17:32:49 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Cirrus' Alpine and Picasso4 chips
uses DAC clock doubling to achieve
full range of pixclock frequencies.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index ec03506..0ef7ccc 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -470,10 +470,23 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
 	/* If the frequency is greater than we can support, we might be able
 	 * to use multiplexing for the video mode */
 	if (freq > maxclock) {
+		dev_err(info->device,
+			"Frequency greater than maxclock (%ld kHz)\n",
+			maxclock);
+		return -EINVAL;
+	}
+	/* Additional constrain: 8bpp uses DAC clock doubling
+	 * to allow maximum pixel clock */
+	if (var->bits_per_pixel == 8) {
 		switch (cinfo->btype) {
 		case BT_ALPINE:
+		case BT_PICASSO4:
+			if (freq > 85500)
+				cinfo->multiplexing = 1;
+			break;
 		case BT_GD5480:
-			cinfo->multiplexing = 1;
+			if (freq > 135100)
+				cinfo->multiplexing = 1;
 			break;
 
 		default:
@@ -815,6 +828,8 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	freq = PICOS2KHZ(var->pixclock);
 	if (cinfo->btype == BT_ALPINE && var->bits_per_pixel == 24)
 		freq *= 3;
+	if (cinfo->multiplexing)
+		freq /= 2;
 
 	bestclock(freq, &nom, &den, &div);
 
-- 
1.5.2.2



----------------------------------------------------------------------
Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
