From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15-rc5-git3] Disable ywrap if not supported by fbcon
 scrolling code
Date: Tue, 13 Dec 2005 14:26:00 +0100
Message-ID: <439ECBE8.5090002@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmADL-00035I-2C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 05:29:07 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmADJ-0004H4-Fs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 05:29:07 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net

updatescrollmode() must not select ywrap scrolling if
divides(vc->vc_font.height, yres) is not true as this is not
supported by the actual ywrap scrolling code.

The bug is triggered with e.g. mode 800x600, vxres 1024,
vyres 8192, bpp 8, font dimensions 8x16, 8Mb video ram
and FBINFO_HWACCEL_YWRAP set. If those conditions
are met, scrolling is broken and garbage is permanently
displayed at the bottom of the screen.

No regression, no possible side effects.

Definitely needed by cyblafb and probably needed by amifb.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-13 13:09:56.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2005-12-13 13:55:20.000000000 +0100
@@ -1968,7 +1968,8 @@ static __inline__ void updatescrollmode(
 		divides(ypan, vc->vc_font.height) && vyres > yres;
 	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP) &&
 		divides(ywrap, vc->vc_font.height) &&
-		divides(vc->vc_font.height, vyres);
+		divides(vc->vc_font.height, vyres) &&
+		divides(vc->vc_font.height, yres);
 	int reading_fast = cap & FBINFO_READS_FAST;
 	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) &&
 		!(cap & FBINFO_HWACCEL_DISABLED);




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
