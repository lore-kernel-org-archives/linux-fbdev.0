From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 2/7] fbset: warning fixes
Date: Mon, 9 Oct 2006 05:27:03 +0300
Message-ID: <20061009022703.GB9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWmbN-0004Nq-Gi for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:18:53 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWmbM-0007wM-1a
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:18:53 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWkti-00067d-3v for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:29:42 +0200
Content-Disposition: inline
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


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch fixes some warnings due to some printf trying to print
unsigned longs as pointers (those types changed in the new fb.h).

regards,
guillem

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_02_warnings.patch"

--- fbset.c	1999-06-23 17:11:46.000000000 +0300
+++ fbset.c	2006-10-09 03:16:33.000000000 +0300
@@ -710,7 +710,7 @@ static void DisplayFBInfo(struct fb_fix_
 
     puts("Frame buffer device information:");
     printf("    Name        : %s\n", fix->id);
-    printf("    Address     : %p\n", fix->smem_start);
+    printf("    Address     : %#0lx\n", fix->smem_start);
     printf("    Size        : %d\n", fix->smem_len);
     printf("    Type        : ");
     switch (fix->type) {
@@ -780,7 +780,7 @@ static void DisplayFBInfo(struct fb_fix_
     printf("    YWrapStep   : %d\n", fix->ywrapstep);
     printf("    LineLength  : %d\n", fix->line_length);
     if (fix->mmio_len) {
-	printf("    MMIO Address: %p\n", fix->mmio_start);
+	printf("    MMIO Address: %#0lx\n", fix->mmio_start);
 	printf("    MMIO Size   : %d\n", fix->mmio_len);
     }
     printf("    Accelerator : ");

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--uQr8t48UFsdbeI+V--
