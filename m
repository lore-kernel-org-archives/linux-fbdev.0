From: akpm@osdl.org
Subject: [patch 03/25] pmagb-b-fb: Fix a default clock
	frequency
Date: Wed, 01 Nov 2006 21:50:19 -0800
Message-ID: <200611020550.kA25oJKo002288@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTD-0007Xw-Ar for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:31 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTC-0007Bq-19
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:31 -0800
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
Cc: akpm@osdl.org, macro@linux-mips.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>

Inspection of real hardware has revealed one of the clock frequencies known
to be supported by PMAGB-B hardware is off by 3kHz.  Following is a fix. 
Please apply.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/pmagb-b-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/pmagb-b-fb.c~pmagb-b-fb-fix-a-default-clock drivers/video/pmagb-b-fb.c
--- a/drivers/video/pmagb-b-fb.c~pmagb-b-fb-fix-a-default-clock
+++ a/drivers/video/pmagb-b-fb.c
@@ -186,7 +186,7 @@ static void __init pmagbbfb_screen_setup
 static void __init pmagbbfb_osc_setup(struct fb_info *info)
 {
 	static unsigned int pmagbbfb_freqs[] __initdata = {
-		130808, 119843, 104000, 92980, 74367, 72800,
+		130808, 119843, 104000, 92980, 74370, 72800,
 		69197, 66000, 65000, 50350, 36000, 32000, 25175
 	};
 	struct pmagbbfb_par *par = info->par;
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
