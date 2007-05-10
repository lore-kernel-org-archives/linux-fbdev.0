From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] Clean up of sparc FB options
Date: Thu, 10 May 2007 18:32:08 +0200
Message-ID: <464349082bc87@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part464349082e39e"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmBYs-0001qi-GC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 09:32:14 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HmBYq-0003M2-Mx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 09:32:14 -0700
Received: from poczta-8.free.wp-sa.pl (HELO localhost) ([10.1.1.19])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	10 May 2007 18:32:08 +0200
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part464349082e39e
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch puts all SBUS/UPA selection under one option "SBUS/UPA=20
framebuffers" and moves all sparc specific drivers next to them=20
in one group.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
--- linux-2.6.21.orig/drivers/video/Kconfig	2007-05-09 16:56:
07.204702359 +0200
+++ linux-2.6.21/drivers/video/Kconfig	2007-05-10 18:09:09.
478548219 +0200
@@ -703,6 +703,91 @@ config FB_CG6
 	  This is the frame buffer device driver for the CGsix (GX,=20
TurboGX)
 	  frame buffer.
=20
+config FB_FFB
+	bool "Creator/Creator3D/Elite3D support"
+	depends on FB_SBUS && SPARC64
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the Creator,=20
Creator3D,
+	  and Elite3D graphics boards.
+
+config FB_TCX
+	bool "TCX (SS4/SS5 only) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the TCX 24/8bit=20
frame
+	  buffer.
+
+config FB_CG14
+	bool "CGfourteen (SX) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the CGfourteen=20
frame
+	  buffer on Desktop SPARCsystems with the SX graphics option.
+
+config FB_P9100
+	bool "P9100 (Sparcbook 3 only) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the P9100 card
+	  supported on Sparcbook 3 machines.
+
+config FB_LEO
+	bool "Leo (ZX) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the SBUS-based=20
Sun ZX
+	  (leo) frame buffer cards.
+
+config FB_IGA
+	bool "IGA 168x display support"
+	depends on FB && SPARC32
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the INTERGRAPHICS 1680=20
and
+	  successor frame buffer cards.
+
+config FB_XVR500
+	bool "Sun XVR-500 3DLABS Wildcat support"
+	depends on FB && PCI && SPARC64
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the Sun XVR-500 and=20
similar
+	  graphics cards based upon the 3DLABS Wildcat chipset.  The=20
driver
+	  only works on sparc64 systems where the system firwmare has
+	  mostly initialized the card already.  It is treated as a
+	  completely dumb framebuffer device.
+
+config FB_XVR2500
+	bool "Sun XVR-2500 3DLABS Wildcat support"
+	depends on FB && PCI && SPARC64
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the Sun XVR-2500 and=20
similar
+	  graphics cards based upon the 3DLABS Wildcat chipset.  The=20
driver
+	  only works on sparc64 systems where the system firwmare has
+	  mostly initialized the card already.  It is treated as a
+	  completely dumb framebuffer device.
+
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
@@ -1169,7 +1254,7 @@ config FB_ATY
 config FB_ATY_CT
 	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
 	depends on PCI && FB_ATY
-	default y if SPARC64 && FB_PCI
+	default y if SPARC64 && PCI
 	help
 	  Say Y here to support use of ATI's 64-bit Rage boards (or=20
other
 	  boards based on the Mach64 CT, VT, GT, and LT chipsets) as=20
a
@@ -1427,95 +1512,6 @@ config FB_AU1200
=20
 source "drivers/video/geode/Kconfig"
=20
-config FB_FFB
-	bool "Creator/Creator3D/Elite3D support"
-	depends on FB_SBUS && SPARC64
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the Creator,=20
Creator3D,
-	  and Elite3D graphics boards.
-
-config FB_TCX
-	bool "TCX (SS4/SS5 only) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the TCX 24/8bit=20
frame
-	  buffer.
-
-config FB_CG14
-	bool "CGfourteen (SX) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the CGfourteen=20
frame
-	  buffer on Desktop SPARCsystems with the SX graphics option.
-
-config FB_P9100
-	bool "P9100 (Sparcbook 3 only) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the P9100 card
-	  supported on Sparcbook 3 machines.
-
-config FB_LEO
-	bool "Leo (ZX) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the SBUS-based=20
Sun ZX
-	  (leo) frame buffer cards.
-
-config FB_XVR500
-	bool "Sun XVR-500 3DLABS Wildcat support"
-	depends on FB && PCI && SPARC64
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the Sun XVR-500 and=20
similar
-	  graphics cards based upon the 3DLABS Wildcat chipset.  The=20
driver
-	  only works on sparc64 systems where the system firwmare has
-	  mostly initialized the card already.  It is treated as a
-	  completely dumb framebuffer device.
-
-config FB_XVR2500
-	bool "Sun XVR-2500 3DLABS Wildcat support"
-	depends on FB && PCI && SPARC64
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the Sun XVR-2500 and=20
similar
-	  graphics cards based upon the 3DLABS Wildcat chipset.  The=20
driver
-	  only works on sparc64 systems where the system firwmare has
-	  mostly initialized the card already.  It is treated as a
-	  completely dumb framebuffer device.
-
-config FB_PCI
-	bool "PCI framebuffers"
-	depends on (FB =3D y) && PCI && SPARC
-
-config FB_IGA
-	bool "IGA 168x display support"
-	depends on SPARC32 && FB_PCI
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the INTERGRAPHICS 1680=20
and
-	  successor frame buffer cards.
-
 config FB_HIT
 	tristate "HD64461 Frame Buffer support"
 	depends on FB && HD64461


----------------------------------------------------
Bebe Lilly - "M=F3j =B6wiat". Ta p=B3yta rozbawi Twoje dziecko!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fbebe.html&=
sid=3D1135

--part464349082e39e
Content-Type: application/octet-stream; name="sparc-kconfig-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparc-kconfig-cleanup.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vS2NvbmZpZwkyMDA3LTA1LTA5IDE2
OjU2OjA3LjIwNDcwMjM1OSArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vS2Nv
bmZpZwkyMDA3LTA1LTEwIDE4OjA5OjA5LjQ3ODU0ODIxOSArMDIwMApAQCAtNzAzLDYgKzcwMyw5
MSBAQCBjb25maWcgRkJfQ0c2CiAJICBUaGlzIGlzIHRoZSBmcmFtZSBidWZmZXIgZGV2aWNlIGRy
aXZlciBmb3IgdGhlIENHc2l4IChHWCwgVHVyYm9HWCkKIAkgIGZyYW1lIGJ1ZmZlci4KIAorY29u
ZmlnIEZCX0ZGQgorCWJvb2wgIkNyZWF0b3IvQ3JlYXRvcjNEL0VsaXRlM0Qgc3VwcG9ydCIKKwlk
ZXBlbmRzIG9uIEZCX1NCVVMgJiYgU1BBUkM2NAorCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKKwlz
ZWxlY3QgRkJfQ0ZCX0lNQUdFQkxJVAorCWhlbHAKKwkgIFRoaXMgaXMgdGhlIGZyYW1lIGJ1ZmZl
ciBkZXZpY2UgZHJpdmVyIGZvciB0aGUgQ3JlYXRvciwgQ3JlYXRvcjNELAorCSAgYW5kIEVsaXRl
M0QgZ3JhcGhpY3MgYm9hcmRzLgorCitjb25maWcgRkJfVENYCisJYm9vbCAiVENYIChTUzQvU1M1
IG9ubHkpIHN1cHBvcnQiCisJZGVwZW5kcyBvbiBGQl9TQlVTCisJc2VsZWN0IEZCX0NGQl9GSUxM
UkVDVAorCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKKwlzZWxlY3QgRkJfQ0ZCX0lNQUdFQkxJVAor
CWhlbHAKKwkgIFRoaXMgaXMgdGhlIGZyYW1lIGJ1ZmZlciBkZXZpY2UgZHJpdmVyIGZvciB0aGUg
VENYIDI0LzhiaXQgZnJhbWUKKwkgIGJ1ZmZlci4KKworY29uZmlnIEZCX0NHMTQKKwlib29sICJD
R2ZvdXJ0ZWVuIChTWCkgc3VwcG9ydCIKKwlkZXBlbmRzIG9uIEZCX1NCVVMKKwlzZWxlY3QgRkJf
Q0ZCX0ZJTExSRUNUCisJc2VsZWN0IEZCX0NGQl9DT1BZQVJFQQorCXNlbGVjdCBGQl9DRkJfSU1B
R0VCTElUCisJaGVscAorCSAgVGhpcyBpcyB0aGUgZnJhbWUgYnVmZmVyIGRldmljZSBkcml2ZXIg
Zm9yIHRoZSBDR2ZvdXJ0ZWVuIGZyYW1lCisJICBidWZmZXIgb24gRGVza3RvcCBTUEFSQ3N5c3Rl
bXMgd2l0aCB0aGUgU1ggZ3JhcGhpY3Mgb3B0aW9uLgorCitjb25maWcgRkJfUDkxMDAKKwlib29s
ICJQOTEwMCAoU3BhcmNib29rIDMgb25seSkgc3VwcG9ydCIKKwlkZXBlbmRzIG9uIEZCX1NCVVMK
KwlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCisJc2VsZWN0IEZCX0NGQl9DT1BZQVJFQQorCXNlbGVj
dCBGQl9DRkJfSU1BR0VCTElUCisJaGVscAorCSAgVGhpcyBpcyB0aGUgZnJhbWUgYnVmZmVyIGRl
dmljZSBkcml2ZXIgZm9yIHRoZSBQOTEwMCBjYXJkCisJICBzdXBwb3J0ZWQgb24gU3BhcmNib29r
IDMgbWFjaGluZXMuCisKK2NvbmZpZyBGQl9MRU8KKwlib29sICJMZW8gKFpYKSBzdXBwb3J0Igor
CWRlcGVuZHMgb24gRkJfU0JVUworCXNlbGVjdCBGQl9DRkJfRklMTFJFQ1QKKwlzZWxlY3QgRkJf
Q0ZCX0NPUFlBUkVBCisJc2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQKKwloZWxwCisJICBUaGlzIGlz
IHRoZSBmcmFtZSBidWZmZXIgZGV2aWNlIGRyaXZlciBmb3IgdGhlIFNCVVMtYmFzZWQgU3VuIFpY
CisJICAobGVvKSBmcmFtZSBidWZmZXIgY2FyZHMuCisKK2NvbmZpZyBGQl9JR0EKKwlib29sICJJ
R0EgMTY4eCBkaXNwbGF5IHN1cHBvcnQiCisJZGVwZW5kcyBvbiBGQiAmJiBTUEFSQzMyCisJc2Vs
ZWN0IEZCX0NGQl9GSUxMUkVDVAorCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKKwlzZWxlY3QgRkJf
Q0ZCX0lNQUdFQkxJVAorCWhlbHAKKwkgIFRoaXMgaXMgdGhlIGZyYW1lYnVmZmVyIGRldmljZSBm
b3IgdGhlIElOVEVSR1JBUEhJQ1MgMTY4MCBhbmQKKwkgIHN1Y2Nlc3NvciBmcmFtZSBidWZmZXIg
Y2FyZHMuCisKK2NvbmZpZyBGQl9YVlI1MDAKKwlib29sICJTdW4gWFZSLTUwMCAzRExBQlMgV2ls
ZGNhdCBzdXBwb3J0IgorCWRlcGVuZHMgb24gRkIgJiYgUENJICYmIFNQQVJDNjQKKwlzZWxlY3Qg
RkJfQ0ZCX0ZJTExSRUNUCisJc2VsZWN0IEZCX0NGQl9DT1BZQVJFQQorCXNlbGVjdCBGQl9DRkJf
SU1BR0VCTElUCisJaGVscAorCSAgVGhpcyBpcyB0aGUgZnJhbWVidWZmZXIgZGV2aWNlIGZvciB0
aGUgU3VuIFhWUi01MDAgYW5kIHNpbWlsYXIKKwkgIGdyYXBoaWNzIGNhcmRzIGJhc2VkIHVwb24g
dGhlIDNETEFCUyBXaWxkY2F0IGNoaXBzZXQuICBUaGUgZHJpdmVyCisJICBvbmx5IHdvcmtzIG9u
IHNwYXJjNjQgc3lzdGVtcyB3aGVyZSB0aGUgc3lzdGVtIGZpcndtYXJlIGhhcworCSAgbW9zdGx5
IGluaXRpYWxpemVkIHRoZSBjYXJkIGFscmVhZHkuICBJdCBpcyB0cmVhdGVkIGFzIGEKKwkgIGNv
bXBsZXRlbHkgZHVtYiBmcmFtZWJ1ZmZlciBkZXZpY2UuCisKK2NvbmZpZyBGQl9YVlIyNTAwCisJ
Ym9vbCAiU3VuIFhWUi0yNTAwIDNETEFCUyBXaWxkY2F0IHN1cHBvcnQiCisJZGVwZW5kcyBvbiBG
QiAmJiBQQ0kgJiYgU1BBUkM2NAorCXNlbGVjdCBGQl9DRkJfRklMTFJFQ1QKKwlzZWxlY3QgRkJf
Q0ZCX0NPUFlBUkVBCisJc2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQKKwloZWxwCisJICBUaGlzIGlz
IHRoZSBmcmFtZWJ1ZmZlciBkZXZpY2UgZm9yIHRoZSBTdW4gWFZSLTI1MDAgYW5kIHNpbWlsYXIK
KwkgIGdyYXBoaWNzIGNhcmRzIGJhc2VkIHVwb24gdGhlIDNETEFCUyBXaWxkY2F0IGNoaXBzZXQu
ICBUaGUgZHJpdmVyCisJICBvbmx5IHdvcmtzIG9uIHNwYXJjNjQgc3lzdGVtcyB3aGVyZSB0aGUg
c3lzdGVtIGZpcndtYXJlIGhhcworCSAgbW9zdGx5IGluaXRpYWxpemVkIHRoZSBjYXJkIGFscmVh
ZHkuICBJdCBpcyB0cmVhdGVkIGFzIGEKKwkgIGNvbXBsZXRlbHkgZHVtYiBmcmFtZWJ1ZmZlciBk
ZXZpY2UuCisKIGNvbmZpZyBGQl9QVlIyCiAJdHJpc3RhdGUgIk5FQyBQb3dlclZSIDIgZGlzcGxh
eSBzdXBwb3J0IgogCWRlcGVuZHMgb24gRkIgJiYgU0hfRFJFQU1DQVNUCkBAIC0xMTY5LDcgKzEy
NTQsNyBAQCBjb25maWcgRkJfQVRZCiBjb25maWcgRkJfQVRZX0NUCiAJYm9vbCAiTWFjaDY0IENU
L1ZUL0dUL0xUIChpbmNsLiAzRCBSQUdFKSBzdXBwb3J0IgogCWRlcGVuZHMgb24gUENJICYmIEZC
X0FUWQotCWRlZmF1bHQgeSBpZiBTUEFSQzY0ICYmIEZCX1BDSQorCWRlZmF1bHQgeSBpZiBTUEFS
QzY0ICYmIFBDSQogCWhlbHAKIAkgIFNheSBZIGhlcmUgdG8gc3VwcG9ydCB1c2Ugb2YgQVRJJ3Mg
NjQtYml0IFJhZ2UgYm9hcmRzIChvciBvdGhlcgogCSAgYm9hcmRzIGJhc2VkIG9uIHRoZSBNYWNo
NjQgQ1QsIFZULCBHVCwgYW5kIExUIGNoaXBzZXRzKSBhcyBhCkBAIC0xNDI3LDk1ICsxNTEyLDYg
QEAgY29uZmlnIEZCX0FVMTIwMAogCiBzb3VyY2UgImRyaXZlcnMvdmlkZW8vZ2VvZGUvS2NvbmZp
ZyIKIAotY29uZmlnIEZCX0ZGQgotCWJvb2wgIkNyZWF0b3IvQ3JlYXRvcjNEL0VsaXRlM0Qgc3Vw
cG9ydCIKLQlkZXBlbmRzIG9uIEZCX1NCVVMgJiYgU1BBUkM2NAotCXNlbGVjdCBGQl9DRkJfQ09Q
WUFSRUEKLQlzZWxlY3QgRkJfQ0ZCX0lNQUdFQkxJVAotCWhlbHAKLQkgIFRoaXMgaXMgdGhlIGZy
YW1lIGJ1ZmZlciBkZXZpY2UgZHJpdmVyIGZvciB0aGUgQ3JlYXRvciwgQ3JlYXRvcjNELAotCSAg
YW5kIEVsaXRlM0QgZ3JhcGhpY3MgYm9hcmRzLgotCi1jb25maWcgRkJfVENYCi0JYm9vbCAiVENY
IChTUzQvU1M1IG9ubHkpIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBGQl9TQlVTCi0Jc2VsZWN0IEZC
X0NGQl9GSUxMUkVDVAotCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKLQlzZWxlY3QgRkJfQ0ZCX0lN
QUdFQkxJVAotCWhlbHAKLQkgIFRoaXMgaXMgdGhlIGZyYW1lIGJ1ZmZlciBkZXZpY2UgZHJpdmVy
IGZvciB0aGUgVENYIDI0LzhiaXQgZnJhbWUKLQkgIGJ1ZmZlci4KLQotY29uZmlnIEZCX0NHMTQK
LQlib29sICJDR2ZvdXJ0ZWVuIChTWCkgc3VwcG9ydCIKLQlkZXBlbmRzIG9uIEZCX1NCVVMKLQlz
ZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCi0Jc2VsZWN0IEZCX0NGQl9DT1BZQVJFQQotCXNlbGVjdCBG
Ql9DRkJfSU1BR0VCTElUCi0JaGVscAotCSAgVGhpcyBpcyB0aGUgZnJhbWUgYnVmZmVyIGRldmlj
ZSBkcml2ZXIgZm9yIHRoZSBDR2ZvdXJ0ZWVuIGZyYW1lCi0JICBidWZmZXIgb24gRGVza3RvcCBT
UEFSQ3N5c3RlbXMgd2l0aCB0aGUgU1ggZ3JhcGhpY3Mgb3B0aW9uLgotCi1jb25maWcgRkJfUDkx
MDAKLQlib29sICJQOTEwMCAoU3BhcmNib29rIDMgb25seSkgc3VwcG9ydCIKLQlkZXBlbmRzIG9u
IEZCX1NCVVMKLQlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCi0Jc2VsZWN0IEZCX0NGQl9DT1BZQVJF
QQotCXNlbGVjdCBGQl9DRkJfSU1BR0VCTElUCi0JaGVscAotCSAgVGhpcyBpcyB0aGUgZnJhbWUg
YnVmZmVyIGRldmljZSBkcml2ZXIgZm9yIHRoZSBQOTEwMCBjYXJkCi0JICBzdXBwb3J0ZWQgb24g
U3BhcmNib29rIDMgbWFjaGluZXMuCi0KLWNvbmZpZyBGQl9MRU8KLQlib29sICJMZW8gKFpYKSBz
dXBwb3J0IgotCWRlcGVuZHMgb24gRkJfU0JVUwotCXNlbGVjdCBGQl9DRkJfRklMTFJFQ1QKLQlz
ZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBCi0Jc2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQKLQloZWxwCi0J
ICBUaGlzIGlzIHRoZSBmcmFtZSBidWZmZXIgZGV2aWNlIGRyaXZlciBmb3IgdGhlIFNCVVMtYmFz
ZWQgU3VuIFpYCi0JICAobGVvKSBmcmFtZSBidWZmZXIgY2FyZHMuCi0KLWNvbmZpZyBGQl9YVlI1
MDAKLQlib29sICJTdW4gWFZSLTUwMCAzRExBQlMgV2lsZGNhdCBzdXBwb3J0IgotCWRlcGVuZHMg
b24gRkIgJiYgUENJICYmIFNQQVJDNjQKLQlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCi0Jc2VsZWN0
IEZCX0NGQl9DT1BZQVJFQQotCXNlbGVjdCBGQl9DRkJfSU1BR0VCTElUCi0JaGVscAotCSAgVGhp
cyBpcyB0aGUgZnJhbWVidWZmZXIgZGV2aWNlIGZvciB0aGUgU3VuIFhWUi01MDAgYW5kIHNpbWls
YXIKLQkgIGdyYXBoaWNzIGNhcmRzIGJhc2VkIHVwb24gdGhlIDNETEFCUyBXaWxkY2F0IGNoaXBz
ZXQuICBUaGUgZHJpdmVyCi0JICBvbmx5IHdvcmtzIG9uIHNwYXJjNjQgc3lzdGVtcyB3aGVyZSB0
aGUgc3lzdGVtIGZpcndtYXJlIGhhcwotCSAgbW9zdGx5IGluaXRpYWxpemVkIHRoZSBjYXJkIGFs
cmVhZHkuICBJdCBpcyB0cmVhdGVkIGFzIGEKLQkgIGNvbXBsZXRlbHkgZHVtYiBmcmFtZWJ1ZmZl
ciBkZXZpY2UuCi0KLWNvbmZpZyBGQl9YVlIyNTAwCi0JYm9vbCAiU3VuIFhWUi0yNTAwIDNETEFC
UyBXaWxkY2F0IHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBGQiAmJiBQQ0kgJiYgU1BBUkM2NAotCXNl
bGVjdCBGQl9DRkJfRklMTFJFQ1QKLQlzZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBCi0Jc2VsZWN0IEZC
X0NGQl9JTUFHRUJMSVQKLQloZWxwCi0JICBUaGlzIGlzIHRoZSBmcmFtZWJ1ZmZlciBkZXZpY2Ug
Zm9yIHRoZSBTdW4gWFZSLTI1MDAgYW5kIHNpbWlsYXIKLQkgIGdyYXBoaWNzIGNhcmRzIGJhc2Vk
IHVwb24gdGhlIDNETEFCUyBXaWxkY2F0IGNoaXBzZXQuICBUaGUgZHJpdmVyCi0JICBvbmx5IHdv
cmtzIG9uIHNwYXJjNjQgc3lzdGVtcyB3aGVyZSB0aGUgc3lzdGVtIGZpcndtYXJlIGhhcwotCSAg
bW9zdGx5IGluaXRpYWxpemVkIHRoZSBjYXJkIGFscmVhZHkuICBJdCBpcyB0cmVhdGVkIGFzIGEK
LQkgIGNvbXBsZXRlbHkgZHVtYiBmcmFtZWJ1ZmZlciBkZXZpY2UuCi0KLWNvbmZpZyBGQl9QQ0kK
LQlib29sICJQQ0kgZnJhbWVidWZmZXJzIgotCWRlcGVuZHMgb24gKEZCID0geSkgJiYgUENJICYm
IFNQQVJDCi0KLWNvbmZpZyBGQl9JR0EKLQlib29sICJJR0EgMTY4eCBkaXNwbGF5IHN1cHBvcnQi
Ci0JZGVwZW5kcyBvbiBTUEFSQzMyICYmIEZCX1BDSQotCXNlbGVjdCBGQl9DRkJfRklMTFJFQ1QK
LQlzZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBCi0Jc2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQKLQloZWxw
Ci0JICBUaGlzIGlzIHRoZSBmcmFtZWJ1ZmZlciBkZXZpY2UgZm9yIHRoZSBJTlRFUkdSQVBISUNT
IDE2ODAgYW5kCi0JICBzdWNjZXNzb3IgZnJhbWUgYnVmZmVyIGNhcmRzLgotCiBjb25maWcgRkJf
SElUCiAJdHJpc3RhdGUgIkhENjQ0NjEgRnJhbWUgQnVmZmVyIHN1cHBvcnQiCiAJZGVwZW5kcyBv
biBGQiAmJiBIRDY0NDYxCg==

--part464349082e39e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part464349082e39e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part464349082e39e--
