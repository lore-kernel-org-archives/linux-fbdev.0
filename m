From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 9/11] savagefb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:25:10 -0800
Message-ID: <20050309102510.126bf59e.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95w0-0001H8-Qw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:28 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95w0-0005qz-Bv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:28 -0800
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


Fix savagefb section reference:
  change __initdata to __devinitdata.

Error: ./drivers/video/savage/savagefb.o .text refers to 0000000000002a50 R_X86_64_PC32     .init.data+0xfffffffffffffffc

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/savage/savagefb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/video/savage/savagefb.c~video_savfb_sections ./drivers/video/savage/savagefb.c
--- ./drivers/video/savage/savagefb.c~video_savfb_sections	2005-03-01 23:38:09.000000000 -0800
+++ ./drivers/video/savage/savagefb.c	2005-03-08 13:20:53.000000000 -0800
@@ -73,7 +73,7 @@
 /* --------------------------------------------------------------------- */
 
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 static int   paletteEnabled = 0;
 
 #ifdef MODULE


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
