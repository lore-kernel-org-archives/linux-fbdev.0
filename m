From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 10/11] sis: eliminate bad section references
Date: Wed, 9 Mar 2005 10:26:00 -0800
Message-ID: <20050309102600.41f745cc.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95w1-0001HI-LP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:29 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95w0-0007gU-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:29 -0800
In-Reply-To: <20050309100825.0d77ded8.rddunlap@osdl.org>
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
To: adaplas <adaplas@pol.net>, akpm <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Fix sis section reference:
  change 2 __init functions to be __devinit.

Error: ./drivers/video/sis/sis_main.o .text refers to 0000000000000b5b R_X86_64_PC32     .init.text+0xfffffffffffffffc

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/sis/sis_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/video/sis/sis_main.c~video_sis_sections ./drivers/video/sis/sis_main.c
--- ./drivers/video/sis/sis_main.c~video_sis_sections	2005-03-01 23:38:13.000000000 -0800
+++ ./drivers/video/sis/sis_main.c	2005-03-08 13:28:32.000000000 -0800
@@ -144,7 +144,7 @@ sisfb_setdefaultparms(void)
 #endif
 }
 
-static void __init
+static void __devinit
 sisfb_search_vesamode(unsigned int vesamode, BOOLEAN quiet)
 {
 	int i = 0, j = 0;
@@ -5939,7 +5939,7 @@ MODULE_PARM_DESC(videoram,
 #endif
 #endif
 
-int __init sisfb_init_module(void)
+int __devinit sisfb_init_module(void)
 {
 	sisfb_setdefaultparms();
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
