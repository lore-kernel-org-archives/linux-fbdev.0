From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 19:35:13 -0500
Message-ID: <9e473391050307163553dbd88e@mail.gmail.com>
References: <200503060816.55890.adaplas@hotpop.com>
	 <20050307022828.54d52983.akpm@osdl.org>
	 <9e47339105030711117f6ffdc9@mail.gmail.com>
	 <20050307154355.2fd5094c.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_991_18914537.1110242113220"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8ShJ-00052T-Tw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:35:41 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8ShI-0006sk-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:35:41 -0800
Received: by rproxy.gmail.com with SMTP id z35so2162486rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 16:35:40 -0800 (PST)
In-Reply-To: <20050307154355.2fd5094c.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

------=_Part_991_18914537.1110242113220
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All of the hunks failed because the most of the patch had already been applied.
Here is the delta you need against 2.6.11 + x.bz2

Not sure if ppc will build since I don't have a machine to check it on.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_991_18914537.1110242113220
Content-Type: text/x-diff; name="fbmodfix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="fbmodfix.patch"

=3D=3D=3D=3D=3D drivers/video/Kconfig 1.75 vs edited =3D=3D=3D=3D=3D
--- 1.75/drivers/video/Kconfig=092005-03-07 19:16:25 -05:00
+++ edited/drivers/video/Kconfig=092005-03-07 19:30:04 -05:00
@@ -753,6 +753,7 @@
 =09select FB_CFB_COPYAREA
 =09select FB_CFB_IMAGEBLIT
 =09select FB_SOFT_CURSOR
+=09select FB_TILEBLITTING
 =09---help---
 =09  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 =09  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
=3D=3D=3D=3D=3D drivers/video/Makefile 1.117 vs edited =3D=3D=3D=3D=3D
--- 1.117/drivers/video/Makefile=092005-03-07 19:16:25 -05:00
+++ edited/drivers/video/Makefile=092005-03-07 19:30:33 -05:00
@@ -10,10 +10,6 @@
=20
 obj-$(CONFIG_FB)                  +=3D fb.o
 fb-y                              :=3D fbmem.o fbmon.o fbcmap.o fbsysfs.o =
modedb.o
-ifneq ($(CONFIG_FB),n)
-fb-$(CONFIG_PPC)                  +=3D macmodes.o
-# Only include macmodes.o if we have FB support and are PPC
-endif
 fb-objs                           :=3D $(fb-y)
=20
 obj-$(CONFIG_FB_CFB_FILLRECT)  +=3D cfbfillrect.o
=3D=3D=3D=3D=3D drivers/video/console/Makefile 1.19 vs edited =3D=3D=3D=3D=
=3D
--- 1.19/drivers/video/console/Makefile=092004-10-19 05:40:21 -04:00
+++ edited/drivers/video/console/Makefile=092005-03-07 19:31:46 -05:00
@@ -25,7 +25,9 @@
 obj-$(CONFIG_VGA_CONSOLE)         +=3D vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         +=3D mdacon.o
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE) +=3D fbcon.o bitblit.o font.o
-obj-$(CONFIG_FB_TILEBLITTING)     +=3D tileblit.o
+ifeq ($(CONFIG_FB_TILEBLITTING),y)
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     +=3D tileblit.o
+endif
=20
 obj-$(CONFIG_FB_STI)              +=3D sticore.o
=20

------=_Part_991_18914537.1110242113220--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
