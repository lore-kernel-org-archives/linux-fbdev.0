From: <WolfSt.External@qimonda.com>
Subject: Re: Radeonfb doesn't work on Radeon Xpress 200M
	(RS485) (fwd)
Date: Thu, 26 Apr 2007 10:08:36 +0200
Message-ID: <BFB8162493C31249AA1B625A18CD62FF01505494@drsse603.eu.infineon.com>
References: <Pine.LNX.4.64.0704251340470.2730@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C787DA.18A48A5C"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgz20-0006Gu-Fn for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 01:08:48 -0700
Received: from smtp2.infineon.com ([217.10.60.23])
	by mail.sourceforge.net with esmtps (TLSv1:RC4-SHA:128) (Exim 4.44)
	id 1Hgz1y-0004VD-P0 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 01:08:48 -0700
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0704251340470.2730@anakin>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C787DA.18A48A5C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I bought a notebook HP nx6325 where a ATI Radeon Xpress 200M=20
chipset is build in. I just add the pci ids of this card to=20
get the radeonfb working. Please find the attached patch. I=20
only add the patch against the 2.6.20 kernel tree. But it=20
also works for the 2.6.21 which I tested it first.


Regards,

Stephan Wolf
AIS Automation Dresden GmbH
Softwaredesigner

Qimonda AG:
Office:         D412
Phone:          +49 (0)351 / 886-7696
mailto: WolfSt.External@qimonda.com

Tel. / Phone: +49 (0)351 / 2166-136
Fax:              +49 (0)351 / 2166-336
mailto:wolf@ais-dresden.de
http://www.ais-automation.com
Otto-Mohr-Stra=DFe 6
01237 Dresden
Germany

Sitz der Gesellschaft: Dresden
Registergericht: Amtsgericht Dresden, HRB 126
Gesch=E4ftsf=FChrer: Dipl.-Ing. Eckhard Sch=F6bel, Dipl.-Ing.=20
Gottfried Gerlach, Dipl.-Ing. Rainer Strau=DF

------_=_NextPart_001_01C787DA.18A48A5C
Content-Type: application/octet-stream;
	name="radeonfb-Xpress200M.patch"
Content-Transfer-Encoding: base64
Content-Description: radeonfb-Xpress200M.patch
Content-Disposition: attachment;
	filename="radeonfb-Xpress200M.patch"

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

------_=_NextPart_001_01C787DA.18A48A5C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C787DA.18A48A5C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------_=_NextPart_001_01C787DA.18A48A5C--
