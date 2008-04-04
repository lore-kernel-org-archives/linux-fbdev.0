From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [PATCH 1/4 2.6.24] fbdev: metronomefb bugfix v4
Date: Fri, 04 Apr 2008 08:24:16 -0400
Message-ID: <20080404122415.6404.5895.sendpatchset@hit-nxdomain.opendns.com>
References: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhlsF-00045e-Az for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:31 -0700
Received: from rn-out-0910.google.com ([64.233.170.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhlsC-0007nY-T8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:31 -0700
Received: by rn-out-0910.google.com with SMTP id i6so79453rng.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 04 Apr 2008 06:22:28 -0700 (PDT)
In-Reply-To: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch is a bugfix for the use of cfb_* functions instead of sys_*
functions. sys_* should be used with vmalloced framebuffers. the previous
cfb_ use would not work for callers of imageblit/etc.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

---

 metronomefb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index e9a89fd..5602f3e 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -678,7 +678,7 @@ static void metronomefb_fillrect(struct fb_info *info,
 {
 	struct metronomefb_par *par = info->par;
 
-	cfb_fillrect(info, rect);
+	sys_fillrect(info, rect);
 	metronomefb_dpy_update(par);
 }
 
@@ -687,7 +687,7 @@ static void metronomefb_copyarea(struct fb_info *info,
 {
 	struct metronomefb_par *par = info->par;
 
-	cfb_copyarea(info, area);
+	sys_copyarea(info, area);
 	metronomefb_dpy_update(par);
 }
 
@@ -696,7 +696,7 @@ static void metronomefb_imageblit(struct fb_info *info,
 {
 	struct metronomefb_par *par = info->par;
 
-	cfb_imageblit(info, image);
+	sys_imageblit(info, image);
 	metronomefb_dpy_update(par);
 }
 

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
