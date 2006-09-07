From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: radeonfb: Add ATOM BIOS parsing
	v5b/v6	(rebased patch)
Date: Thu, 07 Sep 2006 10:26:30 +0200
Message-ID: <1157617593.16168.464.camel@thor.lorrainebruecke.local>
References: <20060905153713.GA22789@shaftnet.org>
	<20060906220027.GA30385@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GLFEJ-0003Oa-GE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Sep 2006 01:27:23 -0700
Received: from admin.zirkelwireless.com ([209.216.203.65])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GLFEI-0002C0-7i
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Sep 2006 01:27:23 -0700
Received: from [192.168.9.2] (84-74-130-83.dclient.hispeed.ch [84.74.130.83])
	(authenticated bits=0)
	by admin.zirkelwireless.com (8.12.10/8.12.10) with ESMTP id
	k878OJdM014854 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Sep 2006 02:24:49 -0600
In-Reply-To: <20060906220027.GA30385@shaftnet.org>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

T24gV2VkLCAyMDA2LTA5LTA2IGF0IDE4OjAwIC0wNDAwLCBTdHVmZmVkIENydXN0IHdyb3RlOgo+
IAo+ICAqIENhcCBWUkFNIHRvIDEyOE0gKE5vdCByZWFsbHkgc3VyZSB3aHkuLiByZWxhdGVkIHRv
IG1tYXAgYnVncz8pCgpUcmFkaXRpb25hbGx5LCB0aGUgQ1BVIGNvdWxkbid0IGFjY2VzcyBtb3Jl
IHRoYW4gMTI4TSBvbiBSYWRlb25zLiBTZWUKdGhlIGN1cnJlbnQgeGY4Ni12aWRlby1hdGkgY29k
ZSBmb3IgaG93IHRvIGRldGVjdCBob3cgbXVjaCBjYW4gcmVhbGx5IGJlCm1hcHBlZC4KCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICB8ICAgICAgICAgIGh0dHA6Ly90dW5n
c3RlbmdyYXBoaWNzLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgfCAgICAg
ICAgICBEZWJpYW4sIFggYW5kIERSSSBkZXZlbG9wZXIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClVzaW5n
IFRvbWNhdCBidXQgbmVlZCB0byBkbyBtb3JlPyBOZWVkIHRvIHN1cHBvcnQgd2ViIHNlcnZpY2Vz
LCBzZWN1cml0eT8KR2V0IHN0dWZmIGRvbmUgcXVpY2tseSB3aXRoIHByZS1pbnRlZ3JhdGVkIHRl
Y2hub2xvZ3kgdG8gbWFrZSB5b3VyIGpvYiBlYXNpZXIKRG93bmxvYWQgSUJNIFdlYlNwaGVyZSBB
cHBsaWNhdGlvbiBTZXJ2ZXIgdi4xLjAuMSBiYXNlZCBvbiBBcGFjaGUgR2Vyb25pbW8KaHR0cDov
L3NlbC5hcy11cy5mYWxrYWcubmV0L3NlbD9jbWQ9bG5rJmtpZD0xMjA3MDkmYmlkPTI2MzA1NyZk
YXQ9MTIxNjQyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWZiZGV2LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbGludXgtZmJkZXYtZGV2ZWwK
