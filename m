From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 4/7] fbset: add new accelerators
Date: Mon, 9 Oct 2006 05:42:59 +0300
Message-ID: <20061009024259.GD9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GyRA7555PLgSTuth"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWmgY-0004rM-Hy for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:14 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWmgX-0003g9-R9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:14 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWl9B-00069Y-A1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:45:41 +0200
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


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

With this one, the list of accelerators is synced with latest kernel.

regards,
guillem

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_04_new_accels.patch"

--- fbset.c	2006-10-09 03:25:59.000000000 +0300
+++ fbset.c	2006-10-09 03:26:48.000000000 +0300
@@ -199,6 +199,52 @@ static struct accelentry {
     { FB_ACCEL_SUN_CGTHREE, "Sun cg3" },
     { FB_ACCEL_SUN_TCX, "Sun tcx" },
     { FB_ACCEL_MATROX_MGAG400, "Matrox G400" },
+    { FB_ACCEL_NV3, "nVidia RIVA 128" },
+    { FB_ACCEL_NV4, "nVidia RIVA TNT" },
+    { FB_ACCEL_NV5, "nVidia RIVA TNT2" },
+    { FB_ACCEL_CT_6555x, "C&T 6555x" },
+    { FB_ACCEL_3DFX_BANSHEE, "3Dfx Banshee" },
+    { FB_ACCEL_ATI_RAGE128, "ATI Rage128 family" },
+    { FB_ACCEL_ATI_RADEON, "ATI Radeon family" },
+    { FB_ACCEL_IGS_CYBER2000, "CyberPro 2000" },
+    { FB_ACCEL_IGS_CYBER2010, "CyberPro 2010" },
+    { FB_ACCEL_IGS_CYBER5000, "CyberPro 5000" },
+    { FB_ACCEL_SIS_GLAMOUR, "SiS 300/630/540" },
+    { FB_ACCEL_SIS_GLAMOUR_2, "SiS 315/650/740" },
+    { FB_ACCEL_SIS_XABRE, "SiS 330 (Xabre)" },
+    { FB_ACCEL_3DLABS_PERMEDIA3, "3Dlabs Permedia 3" },
+    { FB_ACCEL_I810, "Intel 810/815" },
+    { FB_ACCEL_I830, "Intel 830M/845G/85x/865G" },
+    { FB_ACCEL_NEOMAGIC_NM2070, "NeoMagic NM2070" },
+    { FB_ACCEL_NEOMAGIC_NM2090, "NeoMagic NM2090" },
+    { FB_ACCEL_NEOMAGIC_NM2093, "NeoMagic NM2093" },
+    { FB_ACCEL_NEOMAGIC_NM2097, "NeoMagic NM2097" },
+    { FB_ACCEL_NEOMAGIC_NM2160, "NeoMagic NM2160" },
+    { FB_ACCEL_NEOMAGIC_NM2200, "NeoMagic NM2200" },
+    { FB_ACCEL_NEOMAGIC_NM2230, "NeoMagic NM2230" },
+    { FB_ACCEL_NEOMAGIC_NM2360, "NeoMagic NM2360" },
+    { FB_ACCEL_NEOMAGIC_NM2380, "NeoMagic NM2380" },
+    { FB_ACCEL_SAVAGE4, "S3 Savage4" },
+    { FB_ACCEL_SAVAGE3D, "S3 Savage3D" },
+    { FB_ACCEL_SAVAGE3D_MV, "S3 Savage3D-MV" },
+    { FB_ACCEL_SAVAGE2000, "S3 Savage2000" },
+    { FB_ACCEL_SAVAGE_MX_MV, "S3 Savage/MX-MV" },
+    { FB_ACCEL_SAVAGE_MX, "S3 Savage/MX" },
+    { FB_ACCEL_SAVAGE_IX_MV, "S3 Savage/IX-MV" },
+    { FB_ACCEL_SAVAGE_IX, "S3 Savage/IX" },
+    { FB_ACCEL_PROSAVAGE_PM, "S3 ProSavage PM133" },
+    { FB_ACCEL_PROSAVAGE_KM, "S3 ProSavage KM133" },
+    { FB_ACCEL_S3TWISTER_P, "S3 Twister" },
+    { FB_ACCEL_S3TWISTER_K, "S3 TwisterK" },
+    { FB_ACCEL_SUPERSAVAGE, "S3 Supersavage" },
+    { FB_ACCEL_PROSAVAGE_DDR, "S3 ProSavage DDR" },
+    { FB_ACCEL_PROSAVAGE_DDRK, "S3 ProSavage DDR-K" },
+    { FB_ACCEL_NV_10, "nVidia Arch 10" },
+    { FB_ACCEL_NV_20, "nVidia Arch 20" },
+    { FB_ACCEL_NV_30, "nVidia Arch 30" },
+    { FB_ACCEL_NV_40, "nVidia Arch 40" },
+    { FB_ACCEL_XGI_VOLARI_V, "XGI Volari V3XT, V5, V8" },
+    { FB_ACCEL_XGI_VOLARI_Z, "XGI Volari Z7" },
 };
 
 

--GyRA7555PLgSTuth
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--GyRA7555PLgSTuth
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--GyRA7555PLgSTuth--
