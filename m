From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] smart blitter usage for scrolling
	(cleaned)
Date: Fri, 11 May 2007 08:42:52 +0200
Message-ID: <4644106cacb67@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4644106caf2b1"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmOq9-0007kN-16 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:43:05 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HmOq7-0003TD-5f
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 23:42:56 -0700
Received: from poczta-11.free.wp-sa.pl (HELO localhost) ([10.1.1.31])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 May 2007 08:42:52 +0200
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

--part4644106caf2b1
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces the current SCROLL_MOVE method with smarter
method using the same logic as the SCROLL_REDRAW method. This
brings these two methods much closer in performance and benefits
all framebuffers which uses the SCROLL_MOVE method.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This version does not merge blits and does not uses ifdefs. The
patch was diffed against linux-2.6.21-git11

Regards,
Krzysztof

diff -urp linux-2.6.21.orig/drivers/video/console/fbcon.c
linux-2.6.21/drivers/video/console/fbcon.c
--- linux-2.6.21.orig/drivers/video/console/fbcon.c	2007-05-09
16:56:07.936744076 +0200
+++ linux-2.6.21/drivers/video/console/fbcon.c	2007-05-10
21:00:22.685633709 +0200
@@ -1704,6 +1704,61 @@ static void fbcon_redraw_move(struct vc_
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
+
+		do {
+			c =3D scr_readw(s);
+			if (attr !=3D (c & 0xff00)) {
+				attr =3D c & 0xff00;
+				if (s > start) {
+					ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
+					x +=3D s - start;
+					start =3D s;
+				}
+			}
+			if (c =3D=3D scr_readw(d))
+				if (s > start) {
+					ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
+					x +=3D s - start + 1;
+					start =3D s + 1;
+				} else {
+					x++;
+					start++;
+				}
+
+			scr_writew(c, d);
+			console_conditional_schedule();
+			s++;
+			d++;
+		} while (s < le);
+		if (s > start)
+			ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
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
@@ -1789,7 +1844,6 @@ static int fbcon_scroll(struct vc_data *
 {
 	struct fb_info *info =3D registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p =3D &fb_display[vc->vc_num];
-	struct fbcon_ops *ops =3D info->fbcon_par;
 	int scroll_partial =3D info->flags & FBINFO_PARTIAL_PAN_OK;
=20
 	if (fbcon_is_inactive(vc, info))
@@ -1813,10 +1867,15 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			ops->bmove(vc, info, t + count, 0, t, 0,
-				    b - t - count, vc->vc_cols);
-			ops->clear(vc, info, b - count, 0, count,
-				  vc->vc_cols);
+			fbcon_redraw_blit(vc, info, p, t, b - t - count,
+				     count);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							(b - count)),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
 			break;
=20
 		case SCROLL_WRAP_MOVE:
@@ -1899,9 +1958,15 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_down;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			ops->bmove(vc, info, t, 0, t + count, 0,
-				    b - t - count, vc->vc_cols);
-			ops->clear(vc, info, t, 0, count, vc->vc_cols);
+			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
+				     -count);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							t),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
 			break;
=20
 		case SCROLL_WRAP_MOVE:


----------------------------------------------------
Morderstwa i krew ofiar na =B6cianach. Mroczne miasto=20
pogr=B1=BFone w chaosie. Sprawd=BC kto jest Przybywaj=B1cym!
Przybywaj=B1cy - thriller metafizyczny ju=BF w ksi=EAgarniach.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2=
Fksiazka.html%3Fkw%3D10414&sid=3D1128

--part4644106caf2b1
Content-Type: text/x-patch; name="video2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="video2.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5j
IGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZmJjb24uYwotLS0gbGludXgtMi42
LjIxLm9yaWcvZHJpdmVycy92aWRlby9jb25zb2xlL2ZiY29uLmMJMjAwNy0wNS0wOSAxNjo1Njow
Ny45MzY3NDQwNzYgKzAyMDAKKysrIGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUv
ZmJjb24uYwkyMDA3LTA1LTEwIDIxOjAwOjIyLjY4NTYzMzcwOSArMDIwMApAQCAtMTcwNCw2ICsx
NzA0LDYxIEBAIHN0YXRpYyB2b2lkIGZiY29uX3JlZHJhd19tb3ZlKHN0cnVjdCB2Y18KIAl9CiB9
CiAKK3N0YXRpYyB2b2lkIGZiY29uX3JlZHJhd19ibGl0KHN0cnVjdCB2Y19kYXRhICp2Yywgc3Ry
dWN0IGZiX2luZm8gKmluZm8sCisJCQlzdHJ1Y3QgZGlzcGxheSAqcCwgaW50IGxpbmUsIGludCBj
b3VudCwgaW50IHljb3VudCkKK3sKKwlpbnQgb2Zmc2V0ID0geWNvdW50ICogdmMtPnZjX2NvbHM7
CisJdW5zaWduZWQgc2hvcnQgKmQgPSAodW5zaWduZWQgc2hvcnQgKikKKwkgICAgKHZjLT52Y19v
cmlnaW4gKyB2Yy0+dmNfc2l6ZV9yb3cgKiBsaW5lKTsKKwl1bnNpZ25lZCBzaG9ydCAqcyA9IGQg
KyBvZmZzZXQ7CisJc3RydWN0IGZiY29uX29wcyAqb3BzID0gaW5mby0+ZmJjb25fcGFyOworCisJ
d2hpbGUgKGNvdW50LS0pIHsKKwkJdW5zaWduZWQgc2hvcnQgKnN0YXJ0ID0gczsKKwkJdW5zaWdu
ZWQgc2hvcnQgKmxlID0gYWR2YW5jZV9yb3cocywgMSk7CisJCXVuc2lnbmVkIHNob3J0IGM7CisJ
CWludCB4ID0gMDsKKwkJdW5zaWduZWQgc2hvcnQgYXR0ciA9IDE7CisKKwkJZG8geworCQkJYyA9
IHNjcl9yZWFkdyhzKTsKKwkJCWlmIChhdHRyICE9IChjICYgMHhmZjAwKSkgeworCQkJCWF0dHIg
PSBjICYgMHhmZjAwOworCQkJCWlmIChzID4gc3RhcnQpIHsKKwkJCQkJb3BzLT5ibW92ZSh2Yywg
aW5mbywgbGluZSArIHljb3VudCwgeCwgbGluZSwgeCwgMSwgcy1zdGFydCk7CisJCQkJCXggKz0g
cyAtIHN0YXJ0OworCQkJCQlzdGFydCA9IHM7CisJCQkJfQorCQkJfQorCQkJaWYgKGMgPT0gc2Ny
X3JlYWR3KGQpKQorCQkJCWlmIChzID4gc3RhcnQpIHsKKwkJCQkJb3BzLT5ibW92ZSh2YywgaW5m
bywgbGluZSArIHljb3VudCwgeCwgbGluZSwgeCwgMSwgcy1zdGFydCk7CisJCQkJCXggKz0gcyAt
IHN0YXJ0ICsgMTsKKwkJCQkJc3RhcnQgPSBzICsgMTsKKwkJCQl9IGVsc2UgeworCQkJCQl4Kys7
CisJCQkJCXN0YXJ0Kys7CisJCQkJfQorCisJCQlzY3Jfd3JpdGV3KGMsIGQpOworCQkJY29uc29s
ZV9jb25kaXRpb25hbF9zY2hlZHVsZSgpOworCQkJcysrOworCQkJZCsrOworCQl9IHdoaWxlIChz
IDwgbGUpOworCQlpZiAocyA+IHN0YXJ0KQorCQkJb3BzLT5ibW92ZSh2YywgaW5mbywgbGluZSAr
IHljb3VudCwgeCwgbGluZSwgeCwgMSwgcy1zdGFydCk7CisJCWNvbnNvbGVfY29uZGl0aW9uYWxf
c2NoZWR1bGUoKTsKKwkJaWYgKHljb3VudCA+IDApCisJCQlsaW5lKys7CisJCWVsc2UgeworCQkJ
bGluZS0tOworCQkJLyogTk9URTogV2Ugc3VidHJhY3QgdHdvIGxpbmVzIGZyb20gdGhlc2UgcG9p
bnRlcnMgKi8KKwkJCXMgLT0gdmMtPnZjX3NpemVfcm93OworCQkJZCAtPSB2Yy0+dmNfc2l6ZV9y
b3c7CisJCX0KKwl9Cit9CisKIHN0YXRpYyB2b2lkIGZiY29uX3JlZHJhdyhzdHJ1Y3QgdmNfZGF0
YSAqdmMsIHN0cnVjdCBkaXNwbGF5ICpwLAogCQkJIGludCBsaW5lLCBpbnQgY291bnQsIGludCBv
ZmZzZXQpCiB7CkBAIC0xNzg5LDcgKzE4NDQsNiBAQCBzdGF0aWMgaW50IGZiY29uX3Njcm9sbChz
dHJ1Y3QgdmNfZGF0YSAqCiB7CiAJc3RydWN0IGZiX2luZm8gKmluZm8gPSByZWdpc3RlcmVkX2Zi
W2NvbjJmYl9tYXBbdmMtPnZjX251bV1dOwogCXN0cnVjdCBkaXNwbGF5ICpwID0gJmZiX2Rpc3Bs
YXlbdmMtPnZjX251bV07Ci0Jc3RydWN0IGZiY29uX29wcyAqb3BzID0gaW5mby0+ZmJjb25fcGFy
OwogCWludCBzY3JvbGxfcGFydGlhbCA9IGluZm8tPmZsYWdzICYgRkJJTkZPX1BBUlRJQUxfUEFO
X09LOwogCiAJaWYgKGZiY29uX2lzX2luYWN0aXZlKHZjLCBpbmZvKSkKQEAgLTE4MTMsMTAgKzE4
NjcsMTUgQEAgc3RhdGljIGludCBmYmNvbl9zY3JvbGwoc3RydWN0IHZjX2RhdGEgKgogCQkJZ290
byByZWRyYXdfdXA7CiAJCXN3aXRjaCAocC0+c2Nyb2xsbW9kZSkgewogCQljYXNlIFNDUk9MTF9N
T1ZFOgotCQkJb3BzLT5ibW92ZSh2YywgaW5mbywgdCArIGNvdW50LCAwLCB0LCAwLAotCQkJCSAg
ICBiIC0gdCAtIGNvdW50LCB2Yy0+dmNfY29scyk7Ci0JCQlvcHMtPmNsZWFyKHZjLCBpbmZvLCBi
IC0gY291bnQsIDAsIGNvdW50LAotCQkJCSAgdmMtPnZjX2NvbHMpOworCQkJZmJjb25fcmVkcmF3
X2JsaXQodmMsIGluZm8sIHAsIHQsIGIgLSB0IC0gY291bnQsCisJCQkJICAgICBjb3VudCk7CisJ
CQlmYmNvbl9jbGVhcih2YywgYiAtIGNvdW50LCAwLCBjb3VudCwgdmMtPnZjX2NvbHMpOworCQkJ
c2NyX21lbXNldHcoKHVuc2lnbmVkIHNob3J0ICopICh2Yy0+dmNfb3JpZ2luICsKKwkJCQkJCQl2
Yy0+dmNfc2l6ZV9yb3cgKgorCQkJCQkJCShiIC0gY291bnQpKSwKKwkJCQkgICAgdmMtPnZjX3Zp
ZGVvX2VyYXNlX2NoYXIsCisJCQkJICAgIHZjLT52Y19zaXplX3JvdyAqIGNvdW50KTsKKwkJCXJl
dHVybiAxOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBTQ1JPTExfV1JBUF9NT1ZFOgpAQCAtMTg5OSw5
ICsxOTU4LDE1IEBAIHN0YXRpYyBpbnQgZmJjb25fc2Nyb2xsKHN0cnVjdCB2Y19kYXRhICoKIAkJ
CWdvdG8gcmVkcmF3X2Rvd247CiAJCXN3aXRjaCAocC0+c2Nyb2xsbW9kZSkgewogCQljYXNlIFND
Uk9MTF9NT1ZFOgotCQkJb3BzLT5ibW92ZSh2YywgaW5mbywgdCwgMCwgdCArIGNvdW50LCAwLAot
CQkJCSAgICBiIC0gdCAtIGNvdW50LCB2Yy0+dmNfY29scyk7Ci0JCQlvcHMtPmNsZWFyKHZjLCBp
bmZvLCB0LCAwLCBjb3VudCwgdmMtPnZjX2NvbHMpOworCQkJZmJjb25fcmVkcmF3X2JsaXQodmMs
IGluZm8sIHAsIGIgLSAxLCBiIC0gdCAtIGNvdW50LAorCQkJCSAgICAgLWNvdW50KTsKKwkJCWZi
Y29uX2NsZWFyKHZjLCB0LCAwLCBjb3VudCwgdmMtPnZjX2NvbHMpOworCQkJc2NyX21lbXNldHco
KHVuc2lnbmVkIHNob3J0ICopICh2Yy0+dmNfb3JpZ2luICsKKwkJCQkJCQl2Yy0+dmNfc2l6ZV9y
b3cgKgorCQkJCQkJCXQpLAorCQkJCSAgICB2Yy0+dmNfdmlkZW9fZXJhc2VfY2hhciwKKwkJCQkg
ICAgdmMtPnZjX3NpemVfcm93ICogY291bnQpOworCQkJcmV0dXJuIDE7CiAJCQlicmVhazsKIAog
CQljYXNlIFNDUk9MTF9XUkFQX01PVkU6Cg==

--part4644106caf2b1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4644106caf2b1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4644106caf2b1--
