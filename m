From: Henk Vergonet <rememberme@systol.god.lan>
Subject: PATCH Proposal make FB_ACCEL_ private to the driver
Date: Sun, 27 Feb 2005 04:26:11 +0100
Message-ID: <20050227032611.GB14968@systol.god.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5F4R-0001HR-7U
	for Linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Feb 2005 19:26:15 -0800
Received: from god.demon.nl ([83.160.164.11] helo=god.dyndns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5F4P-0002fF-VN
	for Linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Feb 2005 19:26:15 -0800
Content-Disposition: inline
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
To: Linux-fbdev-devel@lists.sourceforge.net


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi gents,

This post was originally posted to the kernel-janitors list. After which
I learned there was an active development-list for linux-framebuffer stuff. 


-------------------------

I want to propose to localize the maintenance and registration of the
FB_ACCEL_ id's and remove it from the public fb.h include file.

Motivation:
- This removes an unneeded dependency to fb.h if an additional cards/chips are
  introduced. (These id's are only interesting for the driver anyhow. 
  Only fbset will print out the id, but I'll doubt this is used by anyone.)
- It relieves maintenance of the common frambuffer code, because we don't have
  to keep fb.h in sync.
- It also relieves the maintenance for the  driver developer
  because he can add new cards without having to request modifications
  to public framebuffer code.
  => cleaner fb.h

Could we make this a general guideline?


I have created a patch for the savage driver and fb.h to give an idea
how this would look like. It has no impact on the other fb drivers.

Best regards,

Henk Vergonet


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.11-rc4-fb_h"

diff -urpN linux-2.6.11-rc4-vanilla/include/linux/fb.h linux-2.6.11-rc4/include/linux/fb.h
--- linux-2.6.11-rc4-vanilla/include/linux/fb.h	2005-02-23 10:09:26.000000000 +0100
+++ linux-2.6.11-rc4/include/linux/fb.h	2005-02-24 11:49:55.000000000 +0100
@@ -60,6 +60,14 @@
 #define FB_VISUAL_DIRECTCOLOR		4	/* Direct color */
 #define FB_VISUAL_STATIC_PSEUDOCOLOR	5	/* Pseudo color readonly */
 
+/*
+   The maintenance and registration of a global FB_ACCEL_ accelerator table is
+   deprecated. The driver specific chip identifier should be local to the driver
+   and not be exported via public include files.
+   For userspace applications the use of the sys interface is recommended.
+*/
+#define FB_ACCEL_DUMMY		0xffff	/* Placeholder value until all global */
+					/* administration is removed.	*/
 #define FB_ACCEL_NONE		0	/* no hardware accelerator	*/
 #define FB_ACCEL_ATARIBLITT	1	/* Atari Blitter		*/
 #define FB_ACCEL_AMIGABLITT	2	/* Amiga Blitter                */
@@ -114,22 +122,6 @@
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
 
-#define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
-#define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
-#define FB_ACCEL_SAVAGE3D_MV    0x82	/* S3 Savage3D-MV               */
-#define FB_ACCEL_SAVAGE2000     0x83	/* S3 Savage2000                */
-#define FB_ACCEL_SAVAGE_MX_MV   0x84	/* S3 Savage/MX-MV              */
-#define FB_ACCEL_SAVAGE_MX      0x85	/* S3 Savage/MX                 */
-#define FB_ACCEL_SAVAGE_IX_MV   0x86	/* S3 Savage/IX-MV              */
-#define FB_ACCEL_SAVAGE_IX      0x87	/* S3 Savage/IX                 */
-#define FB_ACCEL_PROSAVAGE_PM   0x88	/* S3 ProSavage PM133           */
-#define FB_ACCEL_PROSAVAGE_KM   0x89	/* S3 ProSavage KM133           */
-#define FB_ACCEL_S3TWISTER_P    0x8a	/* S3 Twister                   */
-#define FB_ACCEL_S3TWISTER_K    0x8b	/* S3 TwisterK                  */
-#define FB_ACCEL_SUPERSAVAGE    0x8c    /* S3 Supersavage               */
-#define FB_ACCEL_PROSAVAGE_DDR  0x8d	/* S3 ProSavage DDR             */
-#define FB_ACCEL_PROSAVAGE_DDRK 0x8e	/* S3 ProSavage DDR-K           */
-
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
 	unsigned long smem_start;	/* Start of frame buffer mem */
@@ -145,8 +137,10 @@ struct fb_fix_screeninfo {
 	unsigned long mmio_start;	/* Start of Memory Mapped I/O   */
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
-	__u32 accel;			/* Indicate to driver which	*/
-					/*  specific chip/card we have	*/
+	__u32 accel;			/* OBSOLETE please use FB_ACCEL_DUMMY */
+					/* as a placeholder see explanation   */
+					/* above. (Used to indicate to driver */
+					/* which specific chip/card we had.)  */
 	__u16 reserved[3];		/* Reserved for future compatibility */
 };
 

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.11-rc4-savage-accel"

diff -urpN --exclude='*.o' linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb-i2c.c linux-2.6.11-rc4/drivers/video/savage/savagefb-i2c.c
--- linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb-i2c.c	2005-02-23 10:08:55.000000000 +0100
+++ linux-2.6.11-rc4/drivers/video/savage/savagefb-i2c.c	2005-02-23 17:51:17.000000000 +0100
@@ -183,7 +183,7 @@ void savagefb_create_i2c_busses(struct f
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 	par->chan.par	= par;
 
-	switch(info->fix.accel) {
+	switch(par->accel) {
 	case FB_ACCEL_PROSAVAGE_DDRK:
 	case FB_ACCEL_PROSAVAGE_PM:
 		par->chan.reg         = CR_SERIAL2;
diff -urpN --exclude='*.o' linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb.c linux-2.6.11-rc4/drivers/video/savage/savagefb.c
--- linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.11-rc4/drivers/video/savage/savagefb.c	2005-02-23 17:51:42.000000000 +0100
@@ -1793,9 +1793,10 @@ static int __devinit savage_init_fb_info
 	info->fix.xpanstep	   = 2;
 	info->fix.ypanstep	   = 1;
 	info->fix.ywrapstep   = 0;
-	info->fix.accel       = id->driver_data;
+	info->fix.accel       = FB_ACCEL_DUMMY;
 
-	switch (info->fix.accel) {
+	par->accel = id->driver_data;
+	switch (par->accel) {
 	case FB_ACCEL_SUPERSAVAGE:
 		par->chip = S3_SUPERSAVAGE;
 		snprintf (info->fix.id, 16, "SuperSavage");
diff -urpN --exclude='*.o' linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb.h linux-2.6.11-rc4/drivers/video/savage/savagefb.h
--- linux-2.6.11-rc4-vanilla/drivers/video/savage/savagefb.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc4/drivers/video/savage/savagefb.h	2005-02-23 17:49:32.000000000 +0100
@@ -76,6 +76,24 @@ typedef enum {
   S3_LAST
 } savage_chipset;
 
+typedef enum {
+	FB_ACCEL_SAVAGE4 = 0x80,	/* S3 Savage4		*/
+	FB_ACCEL_SAVAGE3D,		/* S3 Savage3D		*/
+	FB_ACCEL_SAVAGE3D_MV,		/* S3 Savage3D-MV	*/
+	FB_ACCEL_SAVAGE2000,		/* S3 Savage2000	*/
+	FB_ACCEL_SAVAGE_MX_MV,		/* S3 Savage/MX-MV	*/
+	FB_ACCEL_SAVAGE_MX,		/* S3 Savage/MX		*/
+	FB_ACCEL_SAVAGE_IX_MV,		/* S3 Savage/IX-MV	*/
+	FB_ACCEL_SAVAGE_IX,		/* S3 Savage/IX		*/
+	FB_ACCEL_PROSAVAGE_PM,		/* S3 ProSavage PM133	*/
+	FB_ACCEL_PROSAVAGE_KM,		/* S3 ProSavage KM133	*/
+	FB_ACCEL_S3TWISTER_P,		/* S3 Twister		*/
+	FB_ACCEL_S3TWISTER_K,		/* S3 TwisterK		*/
+	FB_ACCEL_SUPERSAVAGE,		/* S3 Supersavage	*/
+	FB_ACCEL_PROSAVAGE_DDR,		/* S3 ProSavage DDR	*/
+	FB_ACCEL_PROSAVAGE_DDRK		/* S3 ProSavage DDR-K	*/
+} savage_accel;
+
 #define BIOS_BSIZE		     1024
 #define BIOS_BASE		     0xc0000
 
@@ -163,6 +181,7 @@ struct savagefb_i2c_chan {
 struct savagefb_par {
 	struct pci_dev *pcidev;
 	savage_chipset  chip;
+	savage_accel	accel;
 	struct savagefb_i2c_chan chan;
 	unsigned char   *edid;
 	u32 pseudo_palette[16];

--LZvS9be/3tNcYl/X--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
