From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/imsttfb.c. warning fix.
Date: Mon, 19 Apr 2004 17:13:12 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040419171312.49cbc731.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFfBs-0001dG-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 13:16:28 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFfBr-0003V8-Ty
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 13:16:28 -0700
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
To: akpm@osdl.org
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sf.net


 Hi,

 The patch fixes this warning:

drivers/video/imsttfb.c:1089: warning: `imsttfb_load_cursor_image' defined but not used
drivers/video/imsttfb.c:1159: warning: `imstt_set_cursor' defined but not used

 In that case the code will be commented, the patch is:

 drivers/video/imsttfb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -X dontdiff -Nparu a/drivers/video/imsttfb.c a~/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	2003-10-20 08:11:34.000000000 -0200
+++ a~/drivers/video/imsttfb.c	2004-04-19 16:02:58.000000000 -0300
@@ -1084,6 +1084,7 @@ imsttfb_copyarea(struct fb_info *info, c
 	while(read_reg_le32(par->dc_regs, SSTATUS) & 0x40);
 }
 
+#if 0
 static int
 imsttfb_load_cursor_image(struct imstt_par *par, int width, int height, __u8 fgc)
 {
@@ -1191,7 +1192,6 @@ imstt_set_cursor(struct imstt_par *par, 
 	}
 }
 
-#if 0
 static int 
 imsttfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
