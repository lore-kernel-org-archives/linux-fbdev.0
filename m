From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 7/11] radeonfb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:23:15 -0800
Message-ID: <20050309102315.0c181db7.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95w0-0001HA-WE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:29 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vz-0005qf-EV
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


Fix radeonfb section references by changing __initdata
  to __devinitdata.

Error: ./drivers/video/radeonfb.o .text refers to 0000000000002037 R_X86_64_PC32     .init.data+0x0000000000000003
Error: ./drivers/video/radeonfb.o .text refers to 0000000000002491 R_X86_64_PC32     .init.data
Error: ./drivers/video/radeonfb.o .text refers to 0000000000002870 R_X86_64_PC32     .init.data+0x000000000000000c
Error: ./drivers/video/radeonfb.o .text refers to 0000000000002a21 R_X86_64_PC32     .init.data+0xfffffffffffffffb

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/radeonfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp ./drivers/video/radeonfb.c~video_radfb_sections ./drivers/video/radeonfb.c
--- ./drivers/video/radeonfb.c~video_radfb_sections	2005-03-01 23:38:32.000000000 -0800
+++ ./drivers/video/radeonfb.c	2005-03-08 15:12:05.000000000 -0800
@@ -658,13 +658,13 @@ static __inline__ int _max(int val1, int
  * globals
  */
         
-static char *mode_option __initdata;
+static char *mode_option;
 static char noaccel = 0;
 static char mirror = 0;
-static int panel_yres __initdata = 0;
-static char force_dfp __initdata = 0;
+static int panel_yres = 0;
+static char force_dfp = 0;
 static struct radeonfb_info *board_list = NULL;
-static char nomtrr __initdata = 0;
+static char nomtrr = 0;
 
 /*
  * prototypes


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
