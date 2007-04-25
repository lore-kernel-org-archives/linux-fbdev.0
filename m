From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 40/41] pm2fb: pixclock setting
	restriction
Date: Wed, 25 Apr 2007 15:24:13 +0800
Message-ID: <462F021D.3090200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcEE-0001mp-3m for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:54 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcED-0007z9-Ry
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:54 -0700
Received: by py-out-1112.google.com with SMTP id a29so117820pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:47:53 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds restrictions to calculations of m, n and p factors
which sets the pixclock for the Permedia 2V. I found during tests
that synchronization is unstable if m (divisor) is bigger than
half of the n (numerator). The patch disallows such settings
combination.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 6f634e3..2a8ba60 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -302,10 +302,10 @@ static void pm2v_mnp(u32 clk, unsigned c
 	s32 delta = 1000;
 
 	*mm = *nn = *pp = 0;
-	for (n = 1; n; n++) {
-		for ( m = 1; m; m++) {
+	for ( m = 1; m < 128; m++) {
+		for (n = 2 * m + 1; n; n++) {
 			for ( p = 0; p < 2; p++) {
-				f = PM2_REFERENCE_CLOCK * n / (m * (1 << (p + 1)));
+				f = ( PM2_REFERENCE_CLOCK >> ( p + 1 )) * n / m;
 				if ( clk > f - delta && clk < f + delta ) {
 					delta = ( clk > f ) ? clk - f : f - clk;
 					*mm=m;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
