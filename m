From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fbdev: asiliantfb: unsigned subtraction
	not less than 0
Date: Sun, 18 Jan 2009 23:17:38 +0100
Message-ID: <4973AA82.2070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LOgIh-00023c-OH
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 22:39:27 +0000
Received: from ey-out-1920.google.com ([74.125.78.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOgIf-00071n-4q for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 22:39:27 +0000
Received: by ey-out-1920.google.com with SMTP id 26so248757eyw.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jan 2009 14:39:24 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

An unsigned subtraction does not become less than 0

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 1fd22f4..de6c408 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -140,7 +140,7 @@ static void asiliant_calc_dclk2(u32 *ppixclock, u8 *dclk2_m, u8 *dclk2_n, u8 *dc
 
 		/* 3 <= m <= 257 */
 		if (m >= 3 && m <= 257) {
-			unsigned new_error = ((Ftarget * n) - (Fref * m)) >= 0 ?
+			unsigned new_error = Ftarget * n >= Fref * m ?
 					       ((Ftarget * n) - (Fref * m)) : ((Fref * m) - (Ftarget * n));
 			if (new_error < best_error) {
 				best_n = n;
@@ -152,7 +152,7 @@ static void asiliant_calc_dclk2(u32 *ppixclock, u8 *dclk2_m, u8 *dclk2_n, u8 *dc
 		else if (m <= 1028) {
 			/* remember there are still only 8-bits of precision in m, so
 			 * avoid over-optimistic error calculations */
-			unsigned new_error = ((Ftarget * n) - (Fref * (m & ~3))) >= 0 ?
+			unsigned new_error = Ftarget * n >= Fref * (m & ~3) ?
 					       ((Ftarget * n) - (Fref * (m & ~3))) : ((Fref * (m & ~3)) - (Ftarget * n));
 			if (new_error < best_error) {
 				best_n = n;

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
