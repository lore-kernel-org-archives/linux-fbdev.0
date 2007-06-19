From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 02/17] OMAP: Add TI OMAP1610 accelerator
	entry.
Date: Tue, 19 Jun 2007 17:18:15 +0530
Message-ID: <5d5443650706190448t5c979963m783547b91d7fbc17@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_98295_10648271.1182253695338"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I0cC1-000829-OU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 04:48:17 -0700
Received: from nz-out-0506.google.com ([64.233.162.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I0cC0-00066E-EU
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 04:48:17 -0700
Received: by nz-out-0506.google.com with SMTP id 18so1135049nzp
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 19 Jun 2007 04:48:15 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com
Cc: imre.deak@nokia.com, Dirk Behme <dirk.behme@googlemail.com>, juha.yrjola@solidboot.com

------=_Part_98295_10648271.1182253695338
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
--Trilok Soni

------=_Part_98295_10648271.1182253695338
Content-Type: text/x-patch; 
	name=0002-OMAP-Add-TI-OMAP1610-accelerator-entry.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f34bbbgt
Content-Disposition: attachment;
	filename="0002-OMAP-Add-TI-OMAP1610-accelerator-entry.patch"

RnJvbSBmMjY4MTkyYzY1YjZiY2FiYmVhYmU3MmQ5ODZkNTFhYjYyN2Y0ZjI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbXJlIERlYWsgPGltcmUuZGVha0Bzb2xpZGJvb3QuY29tPgpE
YXRlOiBTYXQsIDI2IE1heSAyMDA3IDE5OjE5OjE5ICswNTMwClN1YmplY3Q6IFtQQVRDSCAwMi8x
N10gT01BUDogQWRkIFRJIE9NQVAxNjEwIGFjY2VsZXJhdG9yIGVudHJ5LgoKU2lnbmVkLW9mZi1i
eTogVHJpbG9rIFNvbmkgPHNvbmkudHJpbG9rQGdtYWlsLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4
L2ZiLmggfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmIuaCBiL2luY2x1ZGUvbGludXgv
ZmIuaAppbmRleCA2NjIyNjgyLi5jYjQwMjUwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zi
LmgKKysrIGIvaW5jbHVkZS9saW51eC9mYi5oCkBAIC0xMTksNiArMTE5LDcgQEAgc3RydWN0IGRl
bnRyeTsKICNkZWZpbmUgRkJfQUNDRUxfTlZfNDAgICAgICAgICAgNDYgICAgICAvKiBuVmlkaWEg
QXJjaCA0MCAgICAgICAgICAgICAgICovCiAjZGVmaW5lIEZCX0FDQ0VMX1hHSV9WT0xBUklfVgk0
NwkvKiBYR0kgVm9sYXJpIFYzWFQsIFY1LCBWOCAgICAgICovCiAjZGVmaW5lIEZCX0FDQ0VMX1hH
SV9WT0xBUklfWgk0OAkvKiBYR0kgVm9sYXJpIFo3ICAgICAgICAgICAgICAgICovCisjZGVmaW5l
IEZCX0FDQ0VMX09NQVAxNjEwCTQ5CS8qIFRJIE9NQVAxNnh4ICAgICAgICAgICAgICAgICAgKi8K
ICNkZWZpbmUgRkJfQUNDRUxfTkVPTUFHSUNfTk0yMDcwIDkwCS8qIE5lb01hZ2ljIE5NMjA3MCAg
ICAgICAgICAgICAgKi8KICNkZWZpbmUgRkJfQUNDRUxfTkVPTUFHSUNfTk0yMDkwIDkxCS8qIE5l
b01hZ2ljIE5NMjA5MCAgICAgICAgICAgICAgKi8KICNkZWZpbmUgRkJfQUNDRUxfTkVPTUFHSUNf
Tk0yMDkzIDkyCS8qIE5lb01hZ2ljIE5NMjA5MyAgICAgICAgICAgICAgKi8KLS0gCjEuNS4wCgo=

------=_Part_98295_10648271.1182253695338
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_Part_98295_10648271.1182253695338
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------=_Part_98295_10648271.1182253695338--
