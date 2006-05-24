From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] fbcon: Fix scrollback with logo issue immediately after
 boot
Date: Wed, 24 May 2006 13:41:28 -0600
Message-ID: <20060524194128.GA2680@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FizFA-0004bn-Mr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 12:42:08 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FizFA-0004yq-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 12:42:08 -0700
Received: from amdext4.amd.com ([163.181.251.6])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FizF7-0004jZ-Vw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 12:42:08 -0700
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k4OJfXbt020669
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 May 2006 14:42:19 -0500
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: david.hollister@amd.com


--5mCyUwZo2JvN/JJP
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Greeting folks -

Sending on a patch against latest git that attempts to fix an issue with
the scrollback buffer in the fbcon immediately after boot.    As always,
comments welcome.

Regards,
Jordan

--5mCyUwZo2JvN/JJP
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=fbcon.patch
Content-Transfer-Encoding: 7bit

PATCH: Fix scrollback with logo issue immediately after boot.

From: David Hollister <david.hollister@amd.com>

After the system boots with the logo, if the first action is a
scrollback, the screen may become garbled.  This patch ensures
that the softback_curr value is updated along with softback_in
following the scrollback.

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index ca02071..953eb8c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2631,7 +2631,7 @@ static int fbcon_scrolldelta(struct vc_d
 					scr_memcpyw((u16 *) q, (u16 *) p,
 						    vc->vc_size_row);
 				}
-				softback_in = p;
+				softback_in = softback_curr = p;
 				update_region(vc, vc->vc_origin,
 					      logo_lines * vc->vc_cols);
 			}

--5mCyUwZo2JvN/JJP--



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
