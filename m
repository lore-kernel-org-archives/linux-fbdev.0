From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] newport: newport_*wait() return 0 on
	timeout
Date: Mon, 09 Feb 2009 22:44:54 +0100
Message-ID: <4990A3D6.9040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LWfU8-00061Q-M0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Feb 2009 23:24:16 +0000
Received: from nf-out-0910.google.com ([64.233.182.185])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LWfU6-00034V-3P for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Feb 2009 23:24:16 +0000
Received: by nf-out-0910.google.com with SMTP id g16so324370nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Feb 2009 15:24:12 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

With a postfix decrement t reaches -1 on timeout which results in a
return of 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/include/video/newport.h b/include/video/newport.h
index 1f5ebea..001b935 100644
--- a/include/video/newport.h
+++ b/include/video/newport.h
@@ -453,7 +453,7 @@ static __inline__ int newport_wait(struct newport_regs *regs)
 {
 	int t = BUSY_TIMEOUT;
 
-	while (t--)
+	while (--t)
 		if (!(regs->cset.status & NPORT_STAT_GBUSY))
 			break;
 	return !t;
@@ -463,7 +463,7 @@ static __inline__ int newport_bfwait(struct newport_regs *regs)
 {
 	int t = BUSY_TIMEOUT;
 
-	while (t--)
+	while (--t)
 		if(!(regs->cset.status & NPORT_STAT_BBUSY))
 			break;
 	return !t;


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
