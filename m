From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 5/11] neofb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:18:28 -0800
Message-ID: <20050309101828.10b79756.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vx-0001Ga-5S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:25 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vw-0007gH-Bg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:24 -0800
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
To: adaplas@pol.net, akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net


Fix neofb section reference to __initdata: make it __devinitdata.

Error: ./drivers/video/neofb.o .text refers to 0000000000001fb4 R_X86_64_PC32     .init.data+0xfffffffffffffffc

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/neofb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/video/neofb.c~video_neofb_sections ./drivers/video/neofb.c
--- ./drivers/video/neofb.c~video_neofb_sections	2005-03-01 23:38:12.000000000 -0800
+++ ./drivers/video/neofb.c	2005-03-07 20:50:40.000000000 -0800
@@ -93,7 +93,7 @@ static int external;
 static int libretto;
 static int nostretch;
 static int nopciburst;
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 
 #ifdef MODULE
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
