From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits	resources
	on 32 bits archs
Date: Wed, 23 Apr 2008 11:32:07 +0200
Message-ID: <1208943127.5632.324.camel@thor.sulgenrain.local>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JobL4-0002Zo-QT for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:32:31 -0700
Received: from fg-out-1718.google.com ([72.14.220.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JobL0-0006qr-0n
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:32:30 -0700
Received: by fg-out-1718.google.com with SMTP id d23so9832188fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 02:32:23 -0700 (PDT)
In-Reply-To: <1208902903.9640.138.camel@pasglop>
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
Content-Type: text/plain; charset="iso-8859-1"
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>, Wolfgang Denk <wd@denx.de>

T24gV2VkLCAyMDA4LTA0LTIzIGF0IDA4OjIxICsxMDAwLCBCZW5qYW1pbiBIZXJyZW5zY2htaWR0
IHdyb3RlOgo+IE9uIFR1ZSwgMjAwOC0wNC0yMiBhdCAxNzo1NSArMDIwMCwgQ2hyaXN0aWFuIEVo
cmhhcmR0IHdyb3RlOgo+ID4gSSB3YW50ZWQgdG8gYXNrIGlmIHRoZXJlIGFyZSBhbnkga25vd24g
d29ya2Fyb3VuZHMgYXRtIHRoYXQgd291bGQKPiA+IGFsbG93IG1lIHRvIHVzZSBteSBYMTEgZm9y
IG5vdz8KPiAKPiBYIGlzIGRvaW5nIGEgbW1hcCBvZiAvZGV2L21lbSBpbnN0ZWFkIG9mIC9kZXYv
ZmIgPwo+IAo+IFlvdSBjYW4gbm9ybWFsbHkgbWFwIHRoZSBmYiBtYXBwaW5nIC9kZXYvZmIgYW5k
IHRoZW4gbWFwIHRoZSByZWdpc3RlcnMKPiB1c2luZyAvZGV2L2ZiIGF0IGFuIG9mZnNldCBiZXlv
bmQgdGhlIGZyYW1lYnVmZmVyIChmaXgtPnNtZW1fbGVuKS4KPiAKPiBJZiBYIGlzIHVzaW5nIC9k
ZXYvbWVtIGluc3RlYWQsIHRoZW4gaXQncyBiZWluZyBzdHVwaWQgYW5kIG5lZWRzIHRvIGJlCj4g
Zml4ZWQuLi4KCkl0J3MgdXAgdG8gdGhlIGRyaXZlciwgYW5kIGFnYWluLCB0aGUgY3VycmVudCBy
YWRlb24gZHJpdmVyIGRvZXNuJ3QgdXNlCnJhZGVvbmZiIGF0IGFsbCBhbnltb3JlLi4uCgoKLS0g
CkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgfCAgICAgICAgICBodHRwOi8vdHVu
Z3N0ZW5ncmFwaGljcy5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgIHwgICAg
ICAgICAgRGViaWFuLCBYIGFuZCBEUkkgZGV2ZWxvcGVyCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlz
IFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIDIwMDggSmF2YU9uZShTTSkgQ29uZmVy
ZW5jZSAKRG9uJ3QgbWlzcyB0aGlzIHllYXIncyBleGNpdGluZyBldmVudC4gVGhlcmUncyBzdGls
bCB0aW1lIHRvIHNhdmUgJDEwMC4gClVzZSBwcmlvcml0eSBjb2RlIEo4VEwyRDIuIApodHRwOi8v
YWQuZG91YmxlY2xpY2submV0L2NsazsxOTg3NTc2NzM7MTM1MDMwMzg7cD9odHRwOi8vamF2YS5z
dW4uY29tL2phdmFvbmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
