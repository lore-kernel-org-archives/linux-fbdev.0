From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Radeonfb doesn't work on Radeon Xpress 200M
	(RS485) (fwd)
Date: Wed, 25 Apr 2007 13:41:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704251340470.2730@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="----_=_NextPart_001_01C78729.795C7AE3"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgfsC-0001DU-G4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 04:41:24 -0700
Received: from assei2bl6.telenet-ops.be ([195.130.133.69])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgfsA-00089e-TV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 04:41:24 -0700
Content-ID: <Pine.LNX.4.64.0704251340471.2730@anakin>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, WolfSt.External@qimonda.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

------_=_NextPart_001_01C78729.795C7AE3
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.4.64.0704251340472.2730@anakin>
Content-Transfer-Encoding: quoted-printable


linux-fbdev-devel@lists.sourceforge.net is the correct address!

---------- Forwarded message ----------
Date: Wed, 25 Apr 2007 13:04:17 +0200
From: WolfSt.External@qimonda.com
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: Radeonfb doesn't work on Radeon Xpress 200M (RS485)

Hi,

I bought a notebook HP nx6325 where a ATI Radeon Xpress 200M chipset is b=
uild in. I just add the pci ids of this card to get the radeonfb working.=
 Please find the attached patch. I only add the patch against the 2.6.20 =
kernel tree. But it also works for the 2.6.21 which I tested it first.


Regards,

Stephan Wolf
AIS Automation Dresden GmbH=20
Softwaredesigner

Qimonda AG:
Office:         D412
Phone:          +49 (0)351 / 886-7696
mailto: WolfSt.External@qimonda.com

Tel. / Phone: +49 (0)351 / 2166-136
Fax:              +49 (0)351 / 2166-336
mailto:wolf@ais-dresden.de
http://www.ais-automation.com
Otto-Mohr-Stra=DFe 6=20
01237 Dresden=20
Germany

Sitz der Gesellschaft: Dresden
Registergericht: Amtsgericht Dresden, HRB 126
Gesch=E4ftsf=FChrer: Dipl.-Ing. Eckhard Sch=F6bel,
Dipl.-Ing. Gottfried Gerlach, Dipl.-Ing. Rainer Strau=DF

------_=_NextPart_001_01C78729.795C7AE3
Content-Type: APPLICATION/OCTET-STREAM; NAME=radeonfb-Xpress200M.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0704251340473.2730@anakin>
Content-Description: radeonfb-Xpress200M.patch
Content-Disposition: ATTACHMENT; FILENAME=radeonfb-Xpress200M.patch

ZGlmZiAtdSBsaW51eC0yLjYuMjEtcmMzLW1tMi9kcml2ZXJzL3ZpZGVvL2F0eS9hdGlfaWRzLmgg
bGludXgvZHJpdmVycy92aWRlby9hdHkvYXRpX2lkcy5oDQotLS0gbGludXgtMi42LjIxLXJjMy1t
bTIvZHJpdmVycy92aWRlby9hdHkvYXRpX2lkcy5oCTIwMDctMDMtMTEgMDc6NDY6NTAuMDAwMDAw
MDAwICswMTAwDQorKysgbGludXgvZHJpdmVycy92aWRlby9hdHkvYXRpX2lkcy5oCTIwMDctMDMt
MDcgMjE6MjY6MDMuMDAwMDAwMDAwICswMTAwDQpAQCAtMjA0LDYgKzIwNCw3IEBADQogI2RlZmlu
ZSBQQ0lfQ0hJUF9SVjI4MF81OTYxCQkweDU5NjENCiAjZGVmaW5lIFBDSV9DSElQX1JWMjgwXzU5
NjIJCTB4NTk2Mg0KICNkZWZpbmUgUENJX0NISVBfUlYyODBfNTk2NAkJMHg1OTY0DQorI2RlZmlu
ZSBQQ0lfQ0hJUF9SUzQ4NV81OTc1CQkweDU5NzUNCiAjZGVmaW5lIFBDSV9DSElQX1JWMjgwXzVD
NjEJCTB4NUM2MQ0KICNkZWZpbmUgUENJX0NISVBfUlYyODBfNUM2MwkJMHg1QzYzDQogI2RlZmlu
ZSBQQ0lfQ0hJUF9SNDIzXzVENTcgICAgICAgICAgICAgIDB4NUQ1Nw0KZGlmZiAtdSBsaW51eC0y
LjYuMjEtcmMzLW1tMi9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fYmFzZS5jIGxpbnV4L2RyaXZl
cnMvdmlkZW8vYXR5L3JhZGVvbl9iYXNlLmMNCi0tLSBsaW51eC0yLjYuMjEtcmMzLW1tMi9kcml2
ZXJzL3ZpZGVvL2F0eS9yYWRlb25fYmFzZS5jCTIwMDctMDMtMTEgMDc6NDY6NTAuMDAwMDAwMDAw
ICswMTAwDQorKysgbGludXgvZHJpdmVycy92aWRlby9hdHkvcmFkZW9uX2Jhc2UuYwkyMDA3LTAz
LTA3IDIxOjMwOjEyLjAwMDAwMDAwMCArMDEwMA0KQEAgLTE1MSw2ICsxNTEsOCBAQA0KIAkvKiBN
b2JpbGl0eSA5MjAwIChNOSspICovDQogCUNISVBfREVGKFBDSV9DSElQX1JWMjgwXzVDNjEsCVJW
MjgwLAlDSElQX0hBU19DUlRDMiB8IENISVBfSVNfTU9CSUxJVFkpLA0KIAlDSElQX0RFRihQQ0lf
Q0hJUF9SVjI4MF81QzYzLAlSVjI4MCwJQ0hJUF9IQVNfQ1JUQzIgfCBDSElQX0lTX01PQklMSVRZ
KSwNCisJLypNb2JpbGl0eSBYcHJlc3MgMjAwICovDQorCUNISVBfREVGKFBDSV9DSElQX1JTNDg1
XzU5NzUsCVIzMDAsCUNISVBfSEFTX0NSVEMyIHwgQ0hJUF9JU19JR1AgfCBDSElQX0lTX01PQklM
SVRZKSwNCiAJLyogOTIwMCAqLw0KIAlDSElQX0RFRihQQ0lfQ0hJUF9SVjI4MF81OTYwLAlSVjI4
MCwJQ0hJUF9IQVNfQ1JUQzIpLA0KIAlDSElQX0RFRihQQ0lfQ0hJUF9SVjI4MF81OTYxLAlSVjI4
MCwJQ0hJUF9IQVNfQ1JUQzIpLA0KDQo=

------_=_NextPart_001_01C78729.795C7AE3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C78729.795C7AE3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------_=_NextPart_001_01C78729.795C7AE3--
