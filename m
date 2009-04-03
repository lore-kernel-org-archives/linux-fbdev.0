From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] fbdev: generated logo sources depend on
	scripts/pnmtologo
Date: Fri, 3 Apr 2009 16:55:17 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0904031654410.10182@vixen.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1Lpknj-0002fz-J1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Apr 2009 14:55:23 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Lpknh-0000rI-0d
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Apr 2009 14:55:23 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="ks_c_5601-1987"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

From: Sam Ravnborg <sam@ravnborg.org>

The generated logo sources are not automatically regenerated if
scripts/pnmtologo.c has changed. Add the missing dependency to fix this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Tested-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/logo/Makefile |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index b91251d..3b43781 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -37,22 +37,24 @@ extra-y +=3D $(call logo-cfiles,_clut224,ppm)
 # Gray 256
 extra-y +=3D $(call logo-cfiles,_gray256,pgm)
 =

+pnmtologo :=3D scripts/pnmtologo
+
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo =3D LOGO    $@
-	cmd_logo =3D scripts/pnmtologo \
+	cmd_logo =3D $(pnmtologo) \
 			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
 			-n $(notdir $(basename $<)) -o $@ $<
 =

-$(obj)/%_mono.c: $(src)/%_mono.pbm FORCE
+$(obj)/%_mono.c: $(src)/%_mono.pbm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 =

-$(obj)/%_vga16.c: $(src)/%_vga16.ppm FORCE
+$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 =

-$(obj)/%_clut224.c: $(src)/%_clut224.ppm FORCE
+$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 =

-$(obj)/%_gray256.c: $(src)/%_gray256.pgm FORCE
+$(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 =

 # Files generated that shall be removed upon make clean
-- =

1.6.0.4


With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
