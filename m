From: Michal Cihar <cihar@liten.cz>
Subject: radeonfb patch
Date: Mon, 11 Nov 2002 10:35:57 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211111022500.4877-200000@ns.liten.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-456998801-2081512122-1037007357=:4877"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.liten.cz ([194.228.111.192])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18BAzH-0007mp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Nov 2002 01:36:07 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---456998801-2081512122-1037007357=:4877
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

Current radeonfb causes to switch off monitor when I change video mode
(eg. using fbset), but changing vts corrected it (calling 'fbset
something; chvt 2; chvt 1;' worked fine). I took a look into radeonfb
source and attempted to make quick fix for this issue. I saw there some
"absurd hack" that seemed to me like thing that could solve my problem so
I moved it into other place and it now works. I have Radeon 7500 QW and
the patched radeonfb seems to work for me, but I'm not really sure if I
moving that "absurd hack" doesn't cause any problems with other cards
elsewhere. If you thing it won't please apply it, it you thing it would,
then probably just adding that code should work (= apply just + part of my
patch).

I'm not on linux-fbdev-devel list, so please CC me the replies...

Regards
	Michal Cihar
	http://cihar.liten.cz

---456998801-2081512122-1037007357=:4877
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="radeonfb.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0211111035570.4877@ns.liten.cz>
Content-Description: 
Content-Disposition: attachment; filename="radeonfb.patch"

LS0tIC4uL2tlcm5lbC1zb3VyY2UtMi40LjE4Lm9sZC9kcml2ZXJzL3ZpZGVv
L3JhZGVvbmZiLmMJMjAwMi0wMi0yNSAyMDozODowNy4wMDAwMDAwMDAgKzAx
MDANCisrKyBkcml2ZXJzL3ZpZGVvL3JhZGVvbmZiLmMJMjAwMi0xMS0xMCAw
MTowODozNy4wMDAwMDAwMDAgKzAxMDANCkBAIC0yMDM0LDYgKzIwMzQsMTMg
QEANCiAgICAgICAgIHJhZGVvbl9sb2FkX3ZpZGVvX21vZGUgKHJpbmZvLCAm
dik7DQogICAgICAgICAgICAgICAgIA0KICAgICAgICAgZG9faW5zdGFsbF9j
bWFwKGNvbiwgaW5mbyk7DQorDQorICAgICAgICAvKiBYWFggYWJzdXJkIGhh
Y2sgZm9yIFggdG8gcmVzdG9yZSBjb25zb2xlICovDQorICAgICAgICB7ICAg
DQorCQlPVVRSRUdQKENSVENfRVhUX0NOVEwsIHJpbmZvLT5oYWNrX2NydGNf
ZXh0X2NudGwsDQorCQkJQ1JUQ19IU1lOQ19ESVMgfCBDUlRDX1ZTWU5DX0RJ
UyB8IENSVENfRElTUExBWV9ESVMpOw0KKyAgICAgICAgICAgICAgICBPVVRS
RUcoQ1JUQ19WX1NZTkNfU1RSVF9XSUQsIHJpbmZvLT5oYWNrX2NydGNfdl9z
eW5jX3N0cnRfd2lkKTsNCisgICAgICAgIH0NCiAgIA0KICAgICAgICAgcmV0
dXJuIDA7DQogfQ0KQEAgLTIxNDQsMTMgKzIxNTEsNiBAQA0KICAgICAgICAg
ICAgICAgICBkb19pbnN0YWxsX2NtYXAoY29uLCBpbmZvKTsNCiAgICAgICAg
IH0gICAgICAgDQogDQotICAgICAgICAvKiBYWFggYWJzdXJkIGhhY2sgZm9y
IFggdG8gcmVzdG9yZSBjb25zb2xlICovDQotICAgICAgICB7ICAgDQotCQlP
VVRSRUdQKENSVENfRVhUX0NOVEwsIHJpbmZvLT5oYWNrX2NydGNfZXh0X2Nu
dGwsDQotCQkJQ1JUQ19IU1lOQ19ESVMgfCBDUlRDX1ZTWU5DX0RJUyB8IENS
VENfRElTUExBWV9ESVMpOw0KLSAgICAgICAgICAgICAgICBPVVRSRUcoQ1JU
Q19WX1NZTkNfU1RSVF9XSUQsIHJpbmZvLT5oYWNrX2NydGNfdl9zeW5jX3N0
cnRfd2lkKTsNCi0gICAgICAgIH0NCi0NCiAgICAgICAgIHJldHVybiAwOw0K
IH0NCiANCg==
---456998801-2081512122-1037007357=:4877--


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
