From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [RFC] allow for PAL/SCART video timings
Date: Tue, 10 Mar 2009 17:17:16 +0100
Message-ID: <1236701836.4068.85.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2555767973537020369=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Lh4e5-0006zP-Ig for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 16:17:33 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Lh4dw-0005Qg-Vd
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 16:17:33 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Petric Frank <pfrank@gmx.de>, sparkie@crashme.cx


--===============2555767973537020369==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mFd7s+RIEPyiKfVxn2QQ"


--=-mFd7s+RIEPyiKfVxn2QQ
Content-Type: multipart/mixed; boundary="=-Q2gGpzPJS7J0oz+OD8WT"


--=-Q2gGpzPJS7J0oz+OD8WT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear developers,


using for example a VGA-to-SCART-adapter the VGA2SCART=C2=B9 project [1]
tries to drive for example a TV set by the graphic card.

To get a picture right from the beginning, Thomas Hilber wrote some
patches, we would like to get merged upstream. Unfortunately this is my
first contact to the kernel and I do not know if what I am doing is the
adheres to the standard procedure.

The patch [2] would be for radeon and intel cards, but for starters I am
just including directly those for the intel one. It is adapted by Petric
Frank for Gentoo.

I guess additional modelines to modedb.c should not be a problem. How
about the other changes? Could a new kernel option be introduced to
disable DPLL_A VCO and to lower MIN_CLOCK, or should 12000 be safe?

After your response, we would clean up the patch and resubmit. I=E2=80=99m
afraid, I did not find clear instructions how to do it. The DRI website
[3] mostly still talks about CVS. Is this message from Dave [4] the up
to date one?

What repository should I use for cloning drm-intel [5] or drm-2.6 from
Dave?

If you could give me or point me to some instructions I would be very
thankful.


Thanks a lot,

Paul


=C2=B9 This name is just temporary.

[1] http://vga2scart.gw90.de/
[2] http://git.hellersdorfer-jugendchor.de/?p=3Dvga2scart.git;a=3Dblob;f=3D=
patches/fb-radeon-intel.patch;h=3D6292c031f8ab67ac0fc7f2d031870fe994eed57a;=
hb=3Df560a83274cf13f7fe99a9f4d9e9ef1ccf69b0c4
[3] http://dri.freedesktop.org/wiki/Development
[4] http://git.kernel.org/?p=3Dlinux/kernel/git/airlied/drm-2.6.git;a=3Dsum=
mary
[5] http://intellinuxgraphics.org/download.html


diff -urN linux-2.6.27-gentoo-r8.org/drivers/video/intelfb/intelfbdrv.c lin=
ux-2.6.27-gentoo-r8/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.27-gentoo-r8.org/drivers/video/intelfb/intelfbdrv.c       200=
8-10-10 00:13:53.000000000 +0200
+++ linux-2.6.27-gentoo-r8/drivers/video/intelfb/intelfbdrv.c   2009-03-09 =
18:09:09.000000000 +0100
@@ -1359,6 +1359,9 @@
        DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
                info->var.yres, info->var.bits_per_pixel);
=20
+       WRN_MSG("disabled DPLL_A VCO for interlaced mode 800x520@50i\n");
+       OUTREG(DPLL_A, INREG(DPLL_A) & ~DPLL_VCO_ENABLE);
+
        intelfb_blank(FB_BLANK_POWERDOWN, info);
=20
        if (ACCEL(dinfo, info))
diff -urN linux-2.6.27-gentoo-r8.org/drivers/video/intelfb/intelfbhw.c linu=
x-2.6.27-gentoo-r8/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.27-gentoo-r8.org/drivers/video/intelfb/intelfbhw.c        200=
8-10-10 00:13:53.000000000 +0200
+++ linux-2.6.27-gentoo-r8/drivers/video/intelfb/intelfbhw.c    2009-03-09 =
18:11:31.000000000 +0100
@@ -353,6 +353,12 @@
=20
        /* Check if clock is OK. */
        tmp =3D 1000000000 / var->pixclock;
+
+       WRN_MSG("lowered MIN_CLOCK from %d MHz -> ", MIN_CLOCK / 1000);
+#undef MIN_CLOCK
+#define MIN_CLOCK 12000
+       printk("%d MHz\n", MIN_CLOCK / 1000);
+
        if (tmp < MIN_CLOCK) {
                WRN_MSG("Pixel clock is too low (%d MHz vs %d MHz).\n",
                        (tmp + 500) / 1000, MIN_CLOCK / 1000);
diff -urN linux-2.6.27-gentoo-r8.org/drivers/video/modedb.c linux-2.6.27-ge=
ntoo-r8/drivers/video/modedb.c
--- linux-2.6.27-gentoo-r8.org/drivers/video/modedb.c   2008-10-10 00:13:53=
.000000000 +0200
+++ linux-2.6.27-gentoo-r8/drivers/video/modedb.c       2009-03-09 18:15:17=
.000000000 +0100
@@ -264,6 +264,14 @@
        /* 1280x800, 60 Hz, 47.403 kHz hsync, WXGA 16:10 aspect ratio */
        NULL, 60, 1280, 800, 12048, 200, 64, 24, 1, 136, 3,
        0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 720x576i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
+       NULL, 50, 720, 576, 74074, 64, 16, 39, 5, 64, 5,
+       0, FB_VMODE_INTERLACED
+    }, {
+       /* 800x520i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
+       NULL, 50, 800, 520, 58823, 144, 64, 72, 28, 80, 5,
+       0, FB_VMODE_INTERLACED
     },
 };

--=-Q2gGpzPJS7J0oz+OD8WT
Content-Disposition: attachment; filename=linux-2.6.27-gentoo-r8-interlace.diff
Content-Type: text/x-patch; name=linux-2.6.27-gentoo-r8-interlace.diff;
	charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGxpbnV4LTIuNi4yNy1nZW50b28tcjgub3JnL2RyaXZlcnMvdmlkZW8vaW50ZWxm
Yi9pbnRlbGZiZHJ2LmMgbGludXgtMi42LjI3LWdlbnRvby1yOC9kcml2ZXJzL3ZpZGVvL2ludGVs
ZmIvaW50ZWxmYmRydi5jDQotLS0gbGludXgtMi42LjI3LWdlbnRvby1yOC5vcmcvZHJpdmVycy92
aWRlby9pbnRlbGZiL2ludGVsZmJkcnYuYwkyMDA4LTEwLTEwIDAwOjEzOjUzLjAwMDAwMDAwMCAr
MDIwMA0KKysrIGxpbnV4LTIuNi4yNy1nZW50b28tcjgvZHJpdmVycy92aWRlby9pbnRlbGZiL2lu
dGVsZmJkcnYuYwkyMDA5LTAzLTA5IDE4OjA5OjA5LjAwMDAwMDAwMCArMDEwMA0KQEAgLTEzNTks
NiArMTM1OSw5IEBADQogCURCR19NU0coImludGVsZmJfc2V0X3BhciAoJWR4JWQtJWQpXG4iLCBp
bmZvLT52YXIueHJlcywNCiAJCWluZm8tPnZhci55cmVzLCBpbmZvLT52YXIuYml0c19wZXJfcGl4
ZWwpOw0KIA0KKwlXUk5fTVNHKCJkaXNhYmxlZCBEUExMX0EgVkNPIGZvciBpbnRlcmxhY2VkIG1v
ZGUgODAweDUyMEA1MGlcbiIpOw0KKwlPVVRSRUcoRFBMTF9BLCBJTlJFRyhEUExMX0EpICYgfkRQ
TExfVkNPX0VOQUJMRSk7DQorDQogCWludGVsZmJfYmxhbmsoRkJfQkxBTktfUE9XRVJET1dOLCBp
bmZvKTsNCiANCiAJaWYgKEFDQ0VMKGRpbmZvLCBpbmZvKSkNCmRpZmYgLXVyTiBsaW51eC0yLjYu
MjctZ2VudG9vLXI4Lm9yZy9kcml2ZXJzL3ZpZGVvL2ludGVsZmIvaW50ZWxmYmh3LmMgbGludXgt
Mi42LjI3LWdlbnRvby1yOC9kcml2ZXJzL3ZpZGVvL2ludGVsZmIvaW50ZWxmYmh3LmMNCi0tLSBs
aW51eC0yLjYuMjctZ2VudG9vLXI4Lm9yZy9kcml2ZXJzL3ZpZGVvL2ludGVsZmIvaW50ZWxmYmh3
LmMJMjAwOC0xMC0xMCAwMDoxMzo1My4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuMjct
Z2VudG9vLXI4L2RyaXZlcnMvdmlkZW8vaW50ZWxmYi9pbnRlbGZiaHcuYwkyMDA5LTAzLTA5IDE4
OjExOjMxLjAwMDAwMDAwMCArMDEwMA0KQEAgLTM1Myw2ICszNTMsMTIgQEANCiANCiAJLyogQ2hl
Y2sgaWYgY2xvY2sgaXMgT0suICovDQogCXRtcCA9IDEwMDAwMDAwMDAgLyB2YXItPnBpeGNsb2Nr
Ow0KKw0KKwlXUk5fTVNHKCJsb3dlcmVkIE1JTl9DTE9DSyBmcm9tICVkIE1IeiAtPiAiLCBNSU5f
Q0xPQ0sgLyAxMDAwKTsNCisjdW5kZWYgTUlOX0NMT0NLDQorI2RlZmluZSBNSU5fQ0xPQ0sgMTIw
MDANCisJcHJpbnRrKCIlZCBNSHpcbiIsIE1JTl9DTE9DSyAvIDEwMDApOw0KKw0KIAlpZiAodG1w
IDwgTUlOX0NMT0NLKSB7DQogCQlXUk5fTVNHKCJQaXhlbCBjbG9jayBpcyB0b28gbG93ICglZCBN
SHogdnMgJWQgTUh6KS5cbiIsDQogCQkJKHRtcCArIDUwMCkgLyAxMDAwLCBNSU5fQ0xPQ0sgLyAx
MDAwKTsNCmRpZmYgLXVyTiBsaW51eC0yLjYuMjctZ2VudG9vLXI4Lm9yZy9kcml2ZXJzL3ZpZGVv
L21vZGVkYi5jIGxpbnV4LTIuNi4yNy1nZW50b28tcjgvZHJpdmVycy92aWRlby9tb2RlZGIuYw0K
LS0tIGxpbnV4LTIuNi4yNy1nZW50b28tcjgub3JnL2RyaXZlcnMvdmlkZW8vbW9kZWRiLmMJMjAw
OC0xMC0xMCAwMDoxMzo1My4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuMjctZ2VudG9v
LXI4L2RyaXZlcnMvdmlkZW8vbW9kZWRiLmMJMjAwOS0wMy0wOSAxODoxNToxNy4wMDAwMDAwMDAg
KzAxMDANCkBAIC0yNjQsNiArMjY0LDE0IEBADQogCS8qIDEyODB4ODAwLCA2MCBIeiwgNDcuNDAz
IGtIeiBoc3luYywgV1hHQSAxNjoxMCBhc3BlY3QgcmF0aW8gKi8NCiAJTlVMTCwgNjAsIDEyODAs
IDgwMCwgMTIwNDgsIDIwMCwgNjQsIDI0LCAxLCAxMzYsIDMsDQogCTAsIEZCX1ZNT0RFX05PTklO
VEVSTEFDRUQNCisgICAgfSwgew0KKwkvKiA3MjB4NTc2aSBAIDUwIEh6LCAxNS42MjUga0h6IGhz
eW5jIChQQUwgUkdCKSAqLw0KKwlOVUxMLCA1MCwgNzIwLCA1NzYsIDc0MDc0LCA2NCwgMTYsIDM5
LCA1LCA2NCwgNSwNCisJMCwgRkJfVk1PREVfSU5URVJMQUNFRA0KKyAgICB9LCB7DQorCS8qIDgw
MHg1MjBpIEAgNTAgSHosIDE1LjYyNSBrSHogaHN5bmMgKFBBTCBSR0IpICovDQorCU5VTEwsIDUw
LCA4MDAsIDUyMCwgNTg4MjMsIDE0NCwgNjQsIDcyLCAyOCwgODAsIDUsDQorCTAsIEZCX1ZNT0RF
X0lOVEVSTEFDRUQNCiAgICAgfSwNCiB9Ow0KIA0K


--=-Q2gGpzPJS7J0oz+OD8WT--

--=-mFd7s+RIEPyiKfVxn2QQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm2kowACgkQPX1aK2wOHVgCTwCeKCnuBxgsfpaEvyf7EpBA43Qq
xWsAn39rfVt+1x+GfHEGAfMzPAyM5YnQ
=aLQY
-----END PGP SIGNATURE-----

--=-mFd7s+RIEPyiKfVxn2QQ--



--===============2555767973537020369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2555767973537020369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2555767973537020369==--
