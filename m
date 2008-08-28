From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/4] cirrusfb: simplify clock calculation
Date: Thu, 28 Aug 2008 22:12:13 +0200
Message-ID: <20080828221213.caac0b14.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYnkY-0005TY-C8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:05:46 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYnkX-0000WI-0U
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:05:46 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Simplify clock calculation.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 09f4214..dfd12a2 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -3075,38 +3075,36 @@ static void bestclock(long freq, long *best, long *nom,
 	f = freq * 10;
 
 	for (n = 32; n < 128; n++) {
+		int s = 0;
+
 		d = (143181 * n) / f;
 		if ((d >= 7) && (d <= 63)) {
-			if (d > 31)
-				d = (d / 2) * 2;
-			h = (14318 * n) / d;
+			int temp = d;
+
+			if (temp > 31) {
+				s = 1;
+				temp >>= 1;
+			}
+			h = ((14318 * n) / temp) >> s;
 			if (abs(h - freq) < abs(*best - freq)) {
 				*best = h;
 				*nom = n;
-				if (d < 32) {
-					*den = d;
-					*div = 0;
-				} else {
-					*den = d / 2;
-					*div = 1;
-				}
+				*den = temp;
+				*div = s;
 			}
 		}
-		d = DIV_ROUND_UP(143181 * n, f);
+		d++;
 		if ((d >= 7) && (d <= 63)) {
-			if (d > 31)
-				d = (d / 2) * 2;
-			h = (14318 * n) / d;
+			if (d > 31) {
+				s = 1;
+				d >>= 1;
+			}
+			h = ((14318 * n) / d) >> s;
 			if (abs(h - freq) < abs(*best - freq)) {
 				*best = h;
 				*nom = n;
-				if (d < 32) {
-					*den = d;
-					*div = 0;
-				} else {
-					*den = d / 2;
-					*div = 1;
-				}
+				*den = d;
+				*div = s;
 			}
 		}
 	}
-- 
1.5.2.2


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
