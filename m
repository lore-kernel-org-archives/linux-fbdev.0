From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/7] fbcon: Do not set palette if console is not visible
Date: Sun, 20 Mar 2005 21:09:14 +0800
Message-ID: <200503202109.14927.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0Ce-0001GA-KV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:48 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0Cc-0002F0-Ql
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:48 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3BC0DFD90CE
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:36 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

A long standing bug in fbcon where switching/opening a vt will also
set the palette even if the vt is in the background.  This results in
color corruption in the foreground vt.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |    3 +++
 1 files changed, 3 insertions(+)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-16 07:39:24 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-18 04:58:31 +08:00
@@ -2331,6 +2331,9 @@
 	if (fbcon_is_inactive(vc, info))
 		return -EINVAL;
 
+	if (!CON_IS_VISIBLE(vc))
+		return 0;
+
 	depth = fb_get_color_depth(&info->var);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
