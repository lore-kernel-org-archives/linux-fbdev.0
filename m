From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 3/11] imsttfb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:15:31 -0800
Message-ID: <20050309101531.6e059da8.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vw-0001GK-5O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:24 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vv-0007gF-5l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:23 -0800
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


Fix imsttfb section references:  change __initdata to __devinitdata
  and __init to __devinit.

Error: ./drivers/video/imsttfb.o .text refers to 000000000000103b R_X86_64_32S      .init.data+0x0000000000000040
Error: ./drivers/video/imsttfb.o .text refers to 0000000000001049 R_X86_64_32S      .init.data+0x0000000000000041
Error: ./drivers/video/imsttfb.o .text refers to 0000000000001064 R_X86_64_32S      .init.data
Error: ./drivers/video/imsttfb.o .text refers to 0000000000001071 R_X86_64_32S      .init.data+0x0000000000000001

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/imsttfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp ./drivers/video/imsttfb.c~vid_imsttfb_sections ./drivers/video/imsttfb.c
--- ./drivers/video/imsttfb.c~vid_imsttfb_sections	2005-03-01 23:38:09.000000000 -0800
+++ ./drivers/video/imsttfb.c	2005-03-07 20:40:35.000000000 -0800
@@ -228,7 +228,7 @@ struct initvalues {
 	__u8 addr, value;
 };
 
-static struct initvalues ibm_initregs[] __initdata = {
+static struct initvalues ibm_initregs[] __devinitdata = {
 	{ CLKCTL,	0x21 },
 	{ SYNCCTL,	0x00 },
 	{ HSYNCPOS,	0x00 },
@@ -275,7 +275,7 @@ static struct initvalues ibm_initregs[] 
 	{ KEYCTL,	0x00 }
 };
 
-static struct initvalues tvp_initregs[] __initdata = {
+static struct initvalues tvp_initregs[] __devinitdata = {
 	{ TVPIRICC,	0x00 },
 	{ TVPIRBRC,	0xe4 },
 	{ TVPIRLAC,	0x06 },
@@ -338,7 +338,7 @@ enum {
 static int inverse = 0;
 static char fontname[40] __initdata = { 0 };
 #if defined(CONFIG_PPC)
-static signed char init_vmode __initdata = -1, init_cmode __initdata = -1;
+static signed char init_vmode __devinitdata = -1, init_cmode __devinitdata = -1;
 #endif
 
 static struct imstt_regvals tvp_reg_init_2 = {
@@ -1348,7 +1348,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void __init 
+static void __devinit 
 init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = (struct imstt_par *) info->par;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
