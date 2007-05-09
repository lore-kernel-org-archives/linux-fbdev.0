From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] smart blitter usage for scrolling
Date: Wed, 09 May 2007 09:05:48 +0200
Message-ID: <464172cc491d5@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part464172cc4b908"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlgFG-00079X-PF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 00:05:54 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlgFE-0007Mu-QH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 00:05:54 -0700
Received: from poczta-15.free.wp-sa.pl (HELO localhost) ([10.1.1.43])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 9 May 2007 09:05:48 +0200
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

--part464172cc4b908
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds option to uses blitter only to move characters
which have to be moved instead of current brute force approach
(move whole screen).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch uses the same logic as the fbcon_redraw() but uses
bmove() instead of putcs(). On my system (dual P3 866MHz and
Permedia 2 with 83MHz clock) this gives the SCROLL_MOVE up to 5%
slower than non accelerated SCROLL_REDRAW. Previously, the
SCROLL_MOVE was few times (up to 10) slower. I tested it with
"time dmesg" at 1024x768 and 1600x1200 resolutions.

I think that this new approach can completely replace the brute
force SCROLL_MOVE method used currently. It should help all
drivers which uses SCROLL_MOVE method (probably not many), reduce
difference between SCROLL_REDRAW and SCROLL_MOVE and do nothing
to drivers useng SCROLL_REDRAW method.

There is additional possibility to improve performance by
enabling MERGE_BLIT definition. In this case, the first matching
character to scroll (in source and destination location) is
ignored. This produces about half of blits requests (in my test
case - around 100 instead of around 200) but blits are larger
(each one is one character larger). This may help on cards where
the blitter is fast but slow to start (any known card?). If it is
not a case it can be dropped completely (to simplify the code).
In my case it has not produced any speed improvement (and even
slower scrolling by 1-2%).

This patch is indented for your review and tests on different
hardware. I will also test it on hardware I have (I can borrow
slower machine and I have few other GFX cards to tests).

Kind regards,
Krzysztof

diff -urp linux-2.6.21/drivers/video/Kconfig
linux-2.6.21.mod/drivers/video/Kconfig
--- linux-2.6.21/drivers/video/Kconfig	2007-05-08
23:38:34.055228990 +0200
+++ linux-2.6.21.mod/drivers/video/Kconfig	2007-05-09
00:13:34.910949935 +0200
@@ -139,6 +139,23 @@ config FB_TILEBLITTING
 	 This is particularly important to one driver, matroxfb.  If
 	 unsure, say N.
=20
+config FB_SMALL_BLITS
+       bool "Enable Enhanced Blitting Support (EXPERIMENTAL)"
+       depends on FB && EXPERIMENTAL
+       default n
+       ---help---
+         This enables smart usage of blitter to sroll screen. A
standard
+	 way is to use blitter to move almost whole screen. The enhanced
+	 blitting moves only characters which have to be moved. The same
+	 logic is used for redrawing characters during scroll if the
+	 blitting is not used to scroll.
+	 It may or may not speed up scrolling of your framebuffer. It
+	 depends on relative speed of your CPU and GPU. If you have
+	 fast CPU and slow GPU this option may slow down scrolling.
+	 If the opposite is true this may speed up scrolling for you.
+
+	 If unsure, say N.
+
 comment "Frame buffer hardware drivers"
 	depends on FB
=20
diff -urp linux-2.6.21/drivers/video/console/fbcon.c
linux-2.6.21.mod/drivers/video/console/fbcon.c
--- linux-2.6.21/drivers/video/console/fbcon.c	2007-04-26
05:08:32.000000000 +0200
+++ linux-2.6.21.mod/drivers/video/console/fbcon.c	2007-05-09
00:15:37.501935997 +0200
@@ -1663,6 +1663,81 @@ static void fbcon_redraw_move(struct vc_
 	}
 }
=20
+static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info
*info,
+			struct display *p, int line, int count, int ycount)
+{
+	int offset =3D ycount * vc->vc_cols;
+	unsigned short *d =3D (unsigned short *)
+	    (vc->vc_origin + vc->vc_size_row * line);
+	unsigned short *s =3D d + offset;
+	struct fbcon_ops *ops =3D info->fbcon_par;
+
+	while (count--) {
+		unsigned short *start =3D s;
+		unsigned short *le =3D advance_row(s, 1);
+		unsigned short c;
+		int x =3D 0;
+		unsigned short attr =3D 1;
+#ifdef MERGE_BLITS
+		int was_blit =3D 1;
+#endif
+
+		do {
+			c =3D scr_readw(s);
+			if (attr !=3D (c & 0xff00)) {
+				attr =3D c & 0xff00;
+				if (s > start) {
+					ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
+#ifdef MERGE_BLITS
+					was_blit =3D 1;
+#endif
+					x +=3D s - start;
+					start =3D s;
+				}
+			}
+			if (c =3D=3D scr_readw(d)) {
+				if (s > start) {
+#ifdef MERGE_BLITS
+					if (!was_blit) {
+#endif
+						ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
+						x +=3D s - start + 1;
+						start =3D s + 1;
+#ifdef MERGE_BLITS
+					}
+					was_blit =3D !was_blit;
+#endif
+				} else {
+#ifdef MERGE_BLITS
+					if (was_blit) {
+#endif
+						x++;
+						start++;
+#ifdef MERGE_BLITS
+					}
+#endif
+				}
+			}
+			scr_writew(c, d);
+			console_conditional_schedule();
+			s++;
+			d++;
+		} while (s < le);
+		if (s > start) {
+			ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
+		}
+		console_conditional_schedule();
+		if (ycount > 0)
+			line++;
+		else {
+			line--;
+			/* NOTE: We subtract two lines from these pointers */
+			s -=3D vc->vc_size_row;
+			d -=3D vc->vc_size_row;
+		}
+	}
+}
+
 static void fbcon_redraw(struct vc_data *vc, struct display *p,
 			 int line, int count, int offset)
 {
@@ -1748,7 +1823,9 @@ static int fbcon_scroll(struct vc_data *
 {
 	struct fb_info *info =3D registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p =3D &fb_display[vc->vc_num];
+#ifndef CONFIG_FB_SMALL_BLITS
 	struct fbcon_ops *ops =3D info->fbcon_par;
+#endif
 	int scroll_partial =3D info->flags & FBINFO_PARTIAL_PAN_OK;
=20
 	if (fbcon_is_inactive(vc, info))
@@ -1772,10 +1849,22 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
+#ifndef CONFIG_FB_SMALL_BLITS
 			ops->bmove(vc, info, t + count, 0, t, 0,
 				    b - t - count, vc->vc_cols);
 			ops->clear(vc, info, b - count, 0, count,
 				  vc->vc_cols);
+#else
+			fbcon_redraw_blit(vc, info, p, t, b - t - count,
+				     count);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							(b - count)),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
+#endif
 			break;
=20
 		case SCROLL_WRAP_MOVE:
@@ -1858,9 +1947,21 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_down;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
+#ifndef CONFIG_FB_SMALL_BLITS
 			ops->bmove(vc, info, t, 0, t + count, 0,
 				    b - t - count, vc->vc_cols);
 			ops->clear(vc, info, t, 0, count, vc->vc_cols);
+#else
+			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
+				     -count);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							t),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
+#endif
 			break;
=20
 		case SCROLL_WRAP_MOVE:





----------------------------------------------------
Sprawd=BC ile wart jest Tw=F3j samoch=F3d.=20
Wycena aut jak na d=B3oni: http://klik.wp.pl/?adr=3Dwww.wycenyaut.wp.pl&s=
id=3D1132

--part464172cc4b908
Content-Type: text/x-patch; name="video-small-blit.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="video-small-blit.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL0tjb25maWcgbGludXgtMi42LjIx
Lm1vZC9kcml2ZXJzL3ZpZGVvL0tjb25maWcKLS0tIGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVv
L0tjb25maWcJMjAwNy0wNS0wOCAyMzozODozNC4wNTUyMjg5OTAgKzAyMDAKKysrIGxpbnV4LTIu
Ni4yMS5tb2QvZHJpdmVycy92aWRlby9LY29uZmlnCTIwMDctMDUtMDkgMDA6MTM6MzQuOTEwOTQ5
OTM1ICswMjAwCkBAIC0xMzksNiArMTM5LDIzIEBAIGNvbmZpZyBGQl9USUxFQkxJVFRJTkcKIAkg
VGhpcyBpcyBwYXJ0aWN1bGFybHkgaW1wb3J0YW50IHRvIG9uZSBkcml2ZXIsIG1hdHJveGZiLiAg
SWYKIAkgdW5zdXJlLCBzYXkgTi4KIAorY29uZmlnIEZCX1NNQUxMX0JMSVRTCisgICAgICAgYm9v
bCAiRW5hYmxlIEVuaGFuY2VkIEJsaXR0aW5nIFN1cHBvcnQgKEVYUEVSSU1FTlRBTCkiCisgICAg
ICAgZGVwZW5kcyBvbiBGQiAmJiBFWFBFUklNRU5UQUwKKyAgICAgICBkZWZhdWx0IG4KKyAgICAg
ICAtLS1oZWxwLS0tCisgICAgICAgICBUaGlzIGVuYWJsZXMgc21hcnQgdXNhZ2Ugb2YgYmxpdHRl
ciB0byBzcm9sbCBzY3JlZW4uIEEgc3RhbmRhcmQKKwkgd2F5IGlzIHRvIHVzZSBibGl0dGVyIHRv
IG1vdmUgYWxtb3N0IHdob2xlIHNjcmVlbi4gVGhlIGVuaGFuY2VkCisJIGJsaXR0aW5nIG1vdmVz
IG9ubHkgY2hhcmFjdGVycyB3aGljaCBoYXZlIHRvIGJlIG1vdmVkLiBUaGUgc2FtZQorCSBsb2dp
YyBpcyB1c2VkIGZvciByZWRyYXdpbmcgY2hhcmFjdGVycyBkdXJpbmcgc2Nyb2xsIGlmIHRoZQor
CSBibGl0dGluZyBpcyBub3QgdXNlZCB0byBzY3JvbGwuCisJIEl0IG1heSBvciBtYXkgbm90IHNw
ZWVkIHVwIHNjcm9sbGluZyBvZiB5b3VyIGZyYW1lYnVmZmVyLiBJdAorCSBkZXBlbmRzIG9uIHJl
bGF0aXZlIHNwZWVkIG9mIHlvdXIgQ1BVIGFuZCBHUFUuIElmIHlvdSBoYXZlCisJIGZhc3QgQ1BV
IGFuZCBzbG93IEdQVSB0aGlzIG9wdGlvbiBtYXkgc2xvdyBkb3duIHNjcm9sbGluZy4KKwkgSWYg
dGhlIG9wcG9zaXRlIGlzIHRydWUgdGhpcyBtYXkgc3BlZWQgdXAgc2Nyb2xsaW5nIGZvciB5b3Uu
CisKKwkgSWYgdW5zdXJlLCBzYXkgTi4KKwogY29tbWVudCAiRnJhbWUgYnVmZmVyIGhhcmR3YXJl
IGRyaXZlcnMiCiAJZGVwZW5kcyBvbiBGQgogCmRpZmYgLXVycCBsaW51eC0yLjYuMjEvZHJpdmVy
cy92aWRlby9jb25zb2xlL2ZiY29uLmMgbGludXgtMi42LjIxLm1vZC9kcml2ZXJzL3ZpZGVvL2Nv
bnNvbGUvZmJjb24uYwotLS0gbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNv
bi5jCTIwMDctMDQtMjYgMDU6MDg6MzIuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjEu
bW9kL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5jCTIwMDctMDUtMDkgMDA6MTU6MzcuNTAx
OTM1OTk3ICswMjAwCkBAIC0xNjYzLDYgKzE2NjMsODEgQEAgc3RhdGljIHZvaWQgZmJjb25fcmVk
cmF3X21vdmUoc3RydWN0IHZjXwogCX0KIH0KIAorc3RhdGljIHZvaWQgZmJjb25fcmVkcmF3X2Js
aXQoc3RydWN0IHZjX2RhdGEgKnZjLCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKKwkJCXN0cnVjdCBk
aXNwbGF5ICpwLCBpbnQgbGluZSwgaW50IGNvdW50LCBpbnQgeWNvdW50KQoreworCWludCBvZmZz
ZXQgPSB5Y291bnQgKiB2Yy0+dmNfY29sczsKKwl1bnNpZ25lZCBzaG9ydCAqZCA9ICh1bnNpZ25l
ZCBzaG9ydCAqKQorCSAgICAodmMtPnZjX29yaWdpbiArIHZjLT52Y19zaXplX3JvdyAqIGxpbmUp
OworCXVuc2lnbmVkIHNob3J0ICpzID0gZCArIG9mZnNldDsKKwlzdHJ1Y3QgZmJjb25fb3BzICpv
cHMgPSBpbmZvLT5mYmNvbl9wYXI7CisKKwl3aGlsZSAoY291bnQtLSkgeworCQl1bnNpZ25lZCBz
aG9ydCAqc3RhcnQgPSBzOworCQl1bnNpZ25lZCBzaG9ydCAqbGUgPSBhZHZhbmNlX3JvdyhzLCAx
KTsKKwkJdW5zaWduZWQgc2hvcnQgYzsKKwkJaW50IHggPSAwOworCQl1bnNpZ25lZCBzaG9ydCBh
dHRyID0gMTsKKyNpZmRlZiBNRVJHRV9CTElUUworCQlpbnQgd2FzX2JsaXQgPSAxOworI2VuZGlm
CisKKwkJZG8geworCQkJYyA9IHNjcl9yZWFkdyhzKTsKKwkJCWlmIChhdHRyICE9IChjICYgMHhm
ZjAwKSkgeworCQkJCWF0dHIgPSBjICYgMHhmZjAwOworCQkJCWlmIChzID4gc3RhcnQpIHsKKwkJ
CQkJb3BzLT5ibW92ZSh2YywgaW5mbywgbGluZSArIHljb3VudCwgeCwgbGluZSwgeCwgMSwgcy1z
dGFydCk7CisjaWZkZWYgTUVSR0VfQkxJVFMKKwkJCQkJd2FzX2JsaXQgPSAxOworI2VuZGlmCisJ
CQkJCXggKz0gcyAtIHN0YXJ0OworCQkJCQlzdGFydCA9IHM7CisJCQkJfQorCQkJfQorCQkJaWYg
KGMgPT0gc2NyX3JlYWR3KGQpKSB7CisJCQkJaWYgKHMgPiBzdGFydCkgeworI2lmZGVmIE1FUkdF
X0JMSVRTCisJCQkJCWlmICghd2FzX2JsaXQpIHsKKyNlbmRpZgorCQkJCQkJb3BzLT5ibW92ZSh2
YywgaW5mbywgbGluZSArIHljb3VudCwgeCwgbGluZSwgeCwgMSwgcy1zdGFydCk7CisJCQkJCQl4
ICs9IHMgLSBzdGFydCArIDE7CisJCQkJCQlzdGFydCA9IHMgKyAxOworI2lmZGVmIE1FUkdFX0JM
SVRTCisJCQkJCX0KKwkJCQkJd2FzX2JsaXQgPSAhd2FzX2JsaXQ7CisjZW5kaWYKKwkJCQl9IGVs
c2UgeworI2lmZGVmIE1FUkdFX0JMSVRTCisJCQkJCWlmICh3YXNfYmxpdCkgeworI2VuZGlmCisJ
CQkJCQl4Kys7CisJCQkJCQlzdGFydCsrOworI2lmZGVmIE1FUkdFX0JMSVRTCisJCQkJCX0KKyNl
bmRpZgorCQkJCX0KKwkJCX0KKwkJCXNjcl93cml0ZXcoYywgZCk7CisJCQljb25zb2xlX2NvbmRp
dGlvbmFsX3NjaGVkdWxlKCk7CisJCQlzKys7CisJCQlkKys7CisJCX0gd2hpbGUgKHMgPCBsZSk7
CisJCWlmIChzID4gc3RhcnQpIHsKKwkJCW9wcy0+Ym1vdmUodmMsIGluZm8sIGxpbmUgKyB5Y291
bnQsIHgsIGxpbmUsIHgsIDEsIHMtc3RhcnQpOworCQl9CisJCWNvbnNvbGVfY29uZGl0aW9uYWxf
c2NoZWR1bGUoKTsKKwkJaWYgKHljb3VudCA+IDApCisJCQlsaW5lKys7CisJCWVsc2UgeworCQkJ
bGluZS0tOworCQkJLyogTk9URTogV2Ugc3VidHJhY3QgdHdvIGxpbmVzIGZyb20gdGhlc2UgcG9p
bnRlcnMgKi8KKwkJCXMgLT0gdmMtPnZjX3NpemVfcm93OworCQkJZCAtPSB2Yy0+dmNfc2l6ZV9y
b3c7CisJCX0KKwl9Cit9CisKIHN0YXRpYyB2b2lkIGZiY29uX3JlZHJhdyhzdHJ1Y3QgdmNfZGF0
YSAqdmMsIHN0cnVjdCBkaXNwbGF5ICpwLAogCQkJIGludCBsaW5lLCBpbnQgY291bnQsIGludCBv
ZmZzZXQpCiB7CkBAIC0xNzQ4LDcgKzE4MjMsOSBAQCBzdGF0aWMgaW50IGZiY29uX3Njcm9sbChz
dHJ1Y3QgdmNfZGF0YSAqCiB7CiAJc3RydWN0IGZiX2luZm8gKmluZm8gPSByZWdpc3RlcmVkX2Zi
W2NvbjJmYl9tYXBbdmMtPnZjX251bV1dOwogCXN0cnVjdCBkaXNwbGF5ICpwID0gJmZiX2Rpc3Bs
YXlbdmMtPnZjX251bV07CisjaWZuZGVmIENPTkZJR19GQl9TTUFMTF9CTElUUwogCXN0cnVjdCBm
YmNvbl9vcHMgKm9wcyA9IGluZm8tPmZiY29uX3BhcjsKKyNlbmRpZgogCWludCBzY3JvbGxfcGFy
dGlhbCA9IGluZm8tPmZsYWdzICYgRkJJTkZPX1BBUlRJQUxfUEFOX09LOwogCiAJaWYgKGZiY29u
X2lzX2luYWN0aXZlKHZjLCBpbmZvKSkKQEAgLTE3NzIsMTAgKzE4NDksMjIgQEAgc3RhdGljIGlu
dCBmYmNvbl9zY3JvbGwoc3RydWN0IHZjX2RhdGEgKgogCQkJZ290byByZWRyYXdfdXA7CiAJCXN3
aXRjaCAocC0+c2Nyb2xsbW9kZSkgewogCQljYXNlIFNDUk9MTF9NT1ZFOgorI2lmbmRlZiBDT05G
SUdfRkJfU01BTExfQkxJVFMKIAkJCW9wcy0+Ym1vdmUodmMsIGluZm8sIHQgKyBjb3VudCwgMCwg
dCwgMCwKIAkJCQkgICAgYiAtIHQgLSBjb3VudCwgdmMtPnZjX2NvbHMpOwogCQkJb3BzLT5jbGVh
cih2YywgaW5mbywgYiAtIGNvdW50LCAwLCBjb3VudCwKIAkJCQkgIHZjLT52Y19jb2xzKTsKKyNl
bHNlCisJCQlmYmNvbl9yZWRyYXdfYmxpdCh2YywgaW5mbywgcCwgdCwgYiAtIHQgLSBjb3VudCwK
KwkJCQkgICAgIGNvdW50KTsKKwkJCWZiY29uX2NsZWFyKHZjLCBiIC0gY291bnQsIDAsIGNvdW50
LCB2Yy0+dmNfY29scyk7CisJCQlzY3JfbWVtc2V0dygodW5zaWduZWQgc2hvcnQgKikgKHZjLT52
Y19vcmlnaW4gKworCQkJCQkJCXZjLT52Y19zaXplX3JvdyAqCisJCQkJCQkJKGIgLSBjb3VudCkp
LAorCQkJCSAgICB2Yy0+dmNfdmlkZW9fZXJhc2VfY2hhciwKKwkJCQkgICAgdmMtPnZjX3NpemVf
cm93ICogY291bnQpOworCQkJcmV0dXJuIDE7CisjZW5kaWYKIAkJCWJyZWFrOwogCiAJCWNhc2Ug
U0NST0xMX1dSQVBfTU9WRToKQEAgLTE4NTgsOSArMTk0NywyMSBAQCBzdGF0aWMgaW50IGZiY29u
X3Njcm9sbChzdHJ1Y3QgdmNfZGF0YSAqCiAJCQlnb3RvIHJlZHJhd19kb3duOwogCQlzd2l0Y2gg
KHAtPnNjcm9sbG1vZGUpIHsKIAkJY2FzZSBTQ1JPTExfTU9WRToKKyNpZm5kZWYgQ09ORklHX0ZC
X1NNQUxMX0JMSVRTCiAJCQlvcHMtPmJtb3ZlKHZjLCBpbmZvLCB0LCAwLCB0ICsgY291bnQsIDAs
CiAJCQkJICAgIGIgLSB0IC0gY291bnQsIHZjLT52Y19jb2xzKTsKIAkJCW9wcy0+Y2xlYXIodmMs
IGluZm8sIHQsIDAsIGNvdW50LCB2Yy0+dmNfY29scyk7CisjZWxzZQorCQkJZmJjb25fcmVkcmF3
X2JsaXQodmMsIGluZm8sIHAsIGIgLSAxLCBiIC0gdCAtIGNvdW50LAorCQkJCSAgICAgLWNvdW50
KTsKKwkJCWZiY29uX2NsZWFyKHZjLCB0LCAwLCBjb3VudCwgdmMtPnZjX2NvbHMpOworCQkJc2Ny
X21lbXNldHcoKHVuc2lnbmVkIHNob3J0ICopICh2Yy0+dmNfb3JpZ2luICsKKwkJCQkJCQl2Yy0+
dmNfc2l6ZV9yb3cgKgorCQkJCQkJCXQpLAorCQkJCSAgICB2Yy0+dmNfdmlkZW9fZXJhc2VfY2hh
ciwKKwkJCQkgICAgdmMtPnZjX3NpemVfcm93ICogY291bnQpOworCQkJcmV0dXJuIDE7CisjZW5k
aWYKIAkJCWJyZWFrOwogCiAJCWNhc2UgU0NST0xMX1dSQVBfTU9WRToK

--part464172cc4b908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part464172cc4b908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part464172cc4b908--
