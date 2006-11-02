From: akpm@osdl.org
Subject: [patch 19/25] atyfb: Fix sparse warnings
Date: Wed, 01 Nov 2006 21:50:30 -0800
Message-ID: <200611020550.kA25oUAS002345@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTS-0007Z9-7Q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:46 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTR-0007IC-UO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:46 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, syrjala@sci.fi

From: Ville Syrjala <syrjala@sci.fi>

Silence some sparse warnings:
* Remove casts from atari out_le32() and friends.
* Move accel functions' declarations to atyfb.h.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/atyfb.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/video/aty/atyfb.h~atyfb-fix-sparse-warnings drivers/video/aty/atyfb.h
--- a/drivers/video/aty/atyfb.h~atyfb-fix-sparse-warnings
+++ a/drivers/video/aty/atyfb.h
@@ -227,7 +227,7 @@ static inline u32 aty_ld_le32(int regind
 		regindex -= 0x800;
 
 #ifdef CONFIG_ATARI
-	return in_le32((volatile u32 *)(par->ati_regbase + regindex));
+	return in_le32(par->ati_regbase + regindex);
 #else
 	return readl(par->ati_regbase + regindex);
 #endif
@@ -240,7 +240,7 @@ static inline void aty_st_le32(int regin
 		regindex -= 0x800;
 
 #ifdef CONFIG_ATARI
-	out_le32((volatile u32 *)(par->ati_regbase + regindex), val);
+	out_le32(par->ati_regbase + regindex, val);
 #else
 	writel(val, par->ati_regbase + regindex);
 #endif
@@ -253,7 +253,7 @@ static inline void aty_st_le16(int regin
 	if (regindex >= 0x400)
 		regindex -= 0x800;
 #ifdef CONFIG_ATARI
-	out_le16((volatile u16 *)(par->ati_regbase + regindex), val);
+	out_le16(par->ati_regbase + regindex, val);
 #else
 	writel(val, par->ati_regbase + regindex);
 #endif
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
