From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb (2.6): Memory type correction
Date: Fri, 7 May 2004 05:11:26 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040507021126.GA11648@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLupp-0006o2-A6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:11:33 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLupn-0000IZ-Oo
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:11:31 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id B09CFF38E4E
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 05:11:26 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch changes the memory type message to match reality. This agrees=20
with both my hardware and the Mobility register specs.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-mem_type.patch"

--- linux/drivers/video/aty/atyfb_base.c.orig	2004-05-07 03:48:44.109865088 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-05-07 03:49:33.872300048 +0300
@@ -457,9 +457,9 @@
 #endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
 static char ram_edo[] __initdata = "EDO";
-static char ram_sdram[] __initdata = "SDRAM";
-static char ram_sgram[] __initdata = "SGRAM";
-static char ram_wram[] __initdata = "WRAM";
+static char ram_sdram[] __initdata = "SDRAM (1:1)";
+static char ram_sgram[] __initdata = "SGRAM (1:1)";
+static char ram_sdram32[] __initdata = "SDRAM (2:1) (32-bit)";
 static char ram_off[] __initdata = "OFF";
 #endif /* CONFIG_FB_ATY_CT */
 
@@ -476,7 +476,7 @@
 #ifdef CONFIG_FB_ATY_CT
 static char *aty_ct_ram[8] __initdata = {
 	ram_off, ram_dram, ram_edo, ram_edo,
-	ram_sdram, ram_sgram, ram_wram, ram_resv
+	ram_sdram, ram_sgram, ram_sdram32, ram_resv
 };
 #endif /* CONFIG_FB_ATY_CT */
 

--liOOAslEiF7prFVr--


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
