From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH] radeonfb: copyarea() "memmove()" problem
Date: Mon, 29 Mar 2004 17:13:58 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403291709020.2356@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1081179398.a664d4@theboonies.us>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="98048-1558035670-1080573238=:2356"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7yob-0001lc-KA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 07:36:41 -0800
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B7yoa-0001Rr-5J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 07:36:40 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--98048-1558035670-1080573238=:2356
Content-Type: TEXT/PLAIN; charset=US-ASCII


Now that my local kernel actually calls copyarea(), I see that my code was
buggy... That is, the hardware needs to be told which way to do its memory
copies if areas overlap.  Think of memmove() versus memcpy().  
Attached is the fix.

Unfortunately, I think the fbcon layer is also buggy... 
(try opening a file with vim, and typing "5ddP"  the copyarea()'s that 
get sent to the fb driver seem totally bogus...)

-dte
--98048-1558035670-1080573238=:2356
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.6-radeon-memmove.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403291713580.2356@rosencrantz.theboonies.us>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.6-radeon-memmove.diff"

LS0tIGJrLWxpbnV4cHBjLTIuNi1iZW5oL2RyaXZlcnMvdmlkZW8vYXR5L3Jh
ZGVvbl9hY2NlbC5jCTIwMDQtMDMtMjkgMTY6Mzc6NDEuMDAwMDAwMDAwICsw
MjAwDQorKysgbGludXgvZHJpdmVycy92aWRlby9hdHkvcmFkZW9uX2FjY2Vs
LmMJMjAwNC0wMy0yOSAxNzowNjo0My4wMDAwMDAwMDAgKzAyMDANCkBAIC01
MywxNCArNTMsMjcgQEANCiBzdGF0aWMgdm9pZCByYWRlb25mYl9wcmltX2Nv
cHlhcmVhKHN0cnVjdCByYWRlb25mYl9pbmZvICpyaW5mbywgDQogCQkJCSAg
IGNvbnN0IHN0cnVjdCBmYl9jb3B5YXJlYSAqYXJlYSkNCiB7DQorCWludCB4
ZGlyLCB5ZGlyOw0KKwl1MzIgc3gsIHN5LCBkeCwgZHksIHcsIGg7DQorDQor
CXcgPSBhcmVhLT53aWR0aDsgaCA9IGFyZWEtPmhlaWdodDsNCisJZHggPSBh
cmVhLT5keDsgZHkgPSBhcmVhLT5keTsNCisJc3ggPSBhcmVhLT5zeDsgc3kg
PSBhcmVhLT5zeTsNCisJeGRpciA9IHN4IC0gZHg7DQorCXlkaXIgPSBzeSAt
IGR5Ow0KKw0KKwlpZiAoIHhkaXIgPCAwICkgeyBzeCArPSB3LTE7IGR4ICs9
IHctMTsgfQ0KKwlpZiAoIHlkaXIgPCAwICkgeyBzeSArPSBoLTE7IGR5ICs9
IGgtMTsgfQ0KKw0KIAlyYWRlb25fZmlmb193YWl0KDMpOw0KIAlPVVRSRUco
RFBfR1VJX01BU1RFUl9DTlRMLA0KIAkJcmluZm8tPmRwX2d1aV9tYXN0ZXJf
Y250bCAvKiBpLmUuIEdNQ19EU1RfMzJCUFAgKi8NCiAJCXwgR01DX1NSQ19E
U1RDT0xPUg0KIAkJfCBST1AzX1MgDQogCQl8IERQX1NSQ19SRUNUICk7DQot
CU9VVFJFRyhEUF9XUklURV9NU0ssIDB4ZmZmZmZmZmYpOw0KLQlPVVRSRUco
RFBfQ05UTCwgKERTVF9YX0xFRlRfVE9fUklHSFQgfCBEU1RfWV9UT1BfVE9f
Qk9UVE9NKSk7DQorCU9VVFJFRyhEUF9DTlRMLCANCisJICAgICAgICAoeGRp
cj49MCA/IERTVF9YX0xFRlRfVE9fUklHSFQgOiAwKQ0KKwkJCXwgKHlkaXI+
PTAgPyBEU1RfWV9UT1BfVE9fQk9UVE9NIDogMCkpOw0KIA0KIAlyYWRlb25f
Zmlmb193YWl0KDMpOw0KIAlPVVRSRUcoU1JDX1lfWCwgKGFyZWEtPnN5IDw8
IDE2KSB8IGFyZWEtPnN4KTsNCg==

--98048-1558035670-1080573238=:2356--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
