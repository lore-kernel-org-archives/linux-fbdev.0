From: Ralf Baechle <ralf@linux-mips.org>
Subject: [FB] Convert struct font_desc to use ISO C
	initializers.
Date: Wed, 22 Aug 2007 15:04:48 +0100
Message-ID: <20070822140448.GA16004@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INqqA-0000ib-G4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 07:05:46 -0700
Received: from ftp.linux-mips.org ([194.74.144.162])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1INqq8-0008M6-IP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 07:05:46 -0700
Received: from localhost.localdomain ([127.0.0.1]:60066 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022742AbXHVOEu (ORCPT
	<rfc822;linux-fbdev-devel@lists.sourceforge.net>);
	Wed, 22 Aug 2007 15:04:50 +0100
Content-Disposition: inline
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
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
Akpm's patch "newport_con warning fix" got me to look at the console
drivers again and one thing that I noticed was that none of the fonts
was using ISO initializers for it's fonts.

diff --git a/drivers/video/console/font_10x18.c b/drivers/video/console/font_10x18.c
index e6aa0ea..6be72bb 100644
--- a/drivers/video/console/font_10x18.c
+++ b/drivers/video/console/font_10x18.c
@@ -5133,14 +5133,14 @@ static const unsigned char fontdata_10x18[FONTDATAMAX] = {
 
 
 const struct font_desc font_10x18 = {
-	FONT10x18_IDX,
-	"10x18",
-	10,
-	18,
-	fontdata_10x18,
+	.idx	= FONT10x18_IDX,
+	.name	= "10x18",
+	.width	= 10,
+	.height	= 18,
+	.data	= fontdata_10x18,
 #ifdef __sparc__
-	5
+	.pref	= 5,
 #else
-	-1
+	.pref	= -1,
 #endif
 };
diff --git a/drivers/video/console/font_6x11.c b/drivers/video/console/font_6x11.c
index 89976cd..46e86e6 100644
--- a/drivers/video/console/font_6x11.c
+++ b/drivers/video/console/font_6x11.c
@@ -3342,10 +3342,11 @@ static const unsigned char fontdata_6x11[FONTDATAMAX] = {
 
 
 const struct font_desc font_vga_6x11 = {
-	VGA6x11_IDX,
-	"ProFont6x11",
-	6,
-	11,
-	fontdata_6x11,
-	-2000	/* Try avoiding this font if possible unless on MAC */
+	.idx	= VGA6x11_IDX,
+	.name	= "ProFont6x11",
+	.width	= 6,
+	.height	= 11,
+	.data	= fontdata_6x11,
+	/* Try avoiding this font if possible unless on MAC */
+	.pref	= -2000,
 };
diff --git a/drivers/video/console/font_7x14.c b/drivers/video/console/font_7x14.c
index bbf1166..3b7dbf9 100644
--- a/drivers/video/console/font_7x14.c
+++ b/drivers/video/console/font_7x14.c
@@ -4109,10 +4109,10 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 
 
 const struct font_desc font_7x14 = {
-	FONT7x14_IDX,
-	"7x14",
-	7,
-	14,
-	fontdata_7x14,
-	0
+	.idx	= FONT7x14_IDX,
+	.name	= "7x14",
+	.width	= 7,
+	.height	= 14,
+	.data	= fontdata_7x14,
+	.pref	= 0,
 };
diff --git a/drivers/video/console/font_8x16.c b/drivers/video/console/font_8x16.c
index 74fe86f..a9f35b4 100644
--- a/drivers/video/console/font_8x16.c
+++ b/drivers/video/console/font_8x16.c
@@ -4622,10 +4622,10 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 
 
 const struct font_desc font_vga_8x16 = {
-	VGA8x16_IDX,
-	"VGA8x16",
-	8,
-	16,
-	fontdata_8x16,
-	0
+	.idx	= VGA8x16_IDX,
+	.name	= "VGA8x16",
+	.width	= 8,
+	.height	= 16,
+	.data	= fontdata_8x16,
+	.pref	= 0,
 };
diff --git a/drivers/video/console/font_8x8.c b/drivers/video/console/font_8x8.c
index 26199f8..9f56efe 100644
--- a/drivers/video/console/font_8x8.c
+++ b/drivers/video/console/font_8x8.c
@@ -2574,10 +2574,10 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 
 
 const struct font_desc font_vga_8x8 = {
-	VGA8x8_IDX,
-	"VGA8x8",
-	8,
-	8,
-	fontdata_8x8,
-	0
+	.idx	= VGA8x8_IDX,
+	.name	= "VGA8x8",
+	.width	= 8,
+	.height	= 8,
+	.data	= fontdata_8x8,
+	.pref	= 0,
 };
diff --git a/drivers/video/console/font_acorn_8x8.c b/drivers/video/console/font_acorn_8x8.c
index 40f3d4e..639e31a 100644
--- a/drivers/video/console/font_acorn_8x8.c
+++ b/drivers/video/console/font_acorn_8x8.c
@@ -262,14 +262,14 @@ static const unsigned char acorndata_8x8[] = {
 };
 
 const struct font_desc font_acorn_8x8 = {
-	ACORN8x8_IDX,
-	"Acorn8x8",
-	8,
-	8,
-	acorndata_8x8,
+	.idx	= ACORN8x8_IDX,
+	.name	= "Acorn8x8",
+	.width	= 8,
+	.height	= 8,
+	.data	= acorndata_8x8,
 #ifdef CONFIG_ARCH_ACORN
-	20
+	.pref	= 20,
 #else
-	0
+	.pref	= 0,
 #endif
 };
diff --git a/drivers/video/console/font_mini_4x6.c b/drivers/video/console/font_mini_4x6.c
index d818234..a19a7f3 100644
--- a/drivers/video/console/font_mini_4x6.c
+++ b/drivers/video/console/font_mini_4x6.c
@@ -2148,11 +2148,11 @@ static const unsigned char fontdata_mini_4x6[FONTDATAMAX] = {
 };
 
 const struct font_desc font_mini_4x6 = {
-	MINI4x6_IDX,
-	"MINI4x6",
-	4,
-	6,
-	fontdata_mini_4x6,
-	3
+	.idx	= MINI4x6_IDX,
+	.name	= "MINI4x6",
+	.width	= 4,
+	.height	= 6,
+	.data	= fontdata_mini_4x6,
+	.pref	= 3,
 };
 
diff --git a/drivers/video/console/font_pearl_8x8.c b/drivers/video/console/font_pearl_8x8.c
index e646c88..dc6ad53 100644
--- a/drivers/video/console/font_pearl_8x8.c
+++ b/drivers/video/console/font_pearl_8x8.c
@@ -2578,10 +2578,10 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
 };
 
 const struct font_desc font_pearl_8x8 = {
-	PEARL8x8_IDX,
-	"PEARL8x8",
-	8,
-	8,
-	fontdata_pearl8x8,
-	2
+	.idx	= PEARL8x8_IDX,
+	.name	= "PEARL8x8",
+	.width	= 8,
+	.height	= 8,
+	.data	= fontdata_pearl8x8,
+	.pref	= 2,
 };
diff --git a/drivers/video/console/font_sun12x22.c b/drivers/video/console/font_sun12x22.c
index ab5eb93..d364385 100644
--- a/drivers/video/console/font_sun12x22.c
+++ b/drivers/video/console/font_sun12x22.c
@@ -6152,14 +6152,14 @@ static const unsigned char fontdata_sun12x22[FONTDATAMAX] = {
 
 
 const struct font_desc font_sun_12x22 = {
-	SUN12x22_IDX,
-	"SUN12x22",
-	12,
-	22,
-	fontdata_sun12x22,
+	.idx	= SUN12x22_IDX,
+	.name	= "SUN12x22",
+	.width	= 12,
+	.height	= 22,
+	.data	= fontdata_sun12x22,
 #ifdef __sparc__
-	5
+	.pref	= 5,
 #else
-	-1
+	.pref	= -1,
 #endif
 };
diff --git a/drivers/video/console/font_sun8x16.c b/drivers/video/console/font_sun8x16.c
index 41f910f..5abf290 100644
--- a/drivers/video/console/font_sun8x16.c
+++ b/drivers/video/console/font_sun8x16.c
@@ -262,14 +262,14 @@ static const unsigned char fontdata_sun8x16[FONTDATAMAX] = {
 };
 
 const struct font_desc font_sun_8x16 = {
-	SUN8x16_IDX,
-	"SUN8x16",
-	8,
-	16,
-	fontdata_sun8x16,
+	.idx	= SUN8x16_IDX,
+	.name	= "SUN8x16",
+	.width	= 8,
+	.height	= 16,
+	.data	= fontdata_sun8x16,
 #ifdef __sparc__
-	10
+	.pref	= 10,
 #else
-	-1
+	.pref	= -1,
 #endif
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
