From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/9] fbcon: Saner 16-color to 4-color conversion
Date: Sat, 20 Aug 2005 00:45:53 +0800
Message-ID: <43060CC1.9030203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HHZ-0002PT-KH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:21 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HHZ-0000sw-BG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:21 -0700
Received: by wproxy.gmail.com with SMTP id i3so655796wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:32:15 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Currently, the default linux 16-colors are converted to 4-colors by simply
    dividing the values by 4.  However, this is not necessarily correct since
    the first 4 colors are converted to black, rendering them invisible.

    So, for black, no conversion; for light colors, convert to gray, for
    normal text color, no conversion, and for bright colors, convert to intense
    white.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -247,9 +247,26 @@ static inline int get_color(struct vc_da
 	case 2:
 		/*
 		 * Scale down 16-colors to 4 colors. Default 4-color palette
-		 * is grayscale.
+		 * is grayscale. However, simply dividing the values by 4
+		 * will not work, as colors 1, 2 and 3 will be scaled-down
+		 * to zero rendering them invisible.  So empirically convert
+		 * colors to a sane 4-level grayscale.
 		 */
-		color /= 4;
+		switch (color) {
+		case 0:
+			color = 0; /* black */
+			break;
+		case 1 ... 6:
+			color = 2; /* white */
+			break;
+		case 7 ... 8:
+			color = 1; /* gray */
+			break;
+		default:
+			color = 3; /* intense white */
+			break;
+		}
+		break;
 	case 3:
 		/*
 		 * Last 8 entries of default 16-color palette is a more intense



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
