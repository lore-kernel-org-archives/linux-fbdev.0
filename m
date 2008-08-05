From: Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH] au1200fb: fixup PM support.
Date: Tue, 05 Aug 2008 11:02:17 -0500
Message-ID: <1217952137.23188.2.camel__38034.6660888337$1218049188$gmane$org@kh-ubuntu.razamicroelectronics.com>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQOzE-0004SL-Qv for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:02:12 -0700
Received: from mx1.razamicroelectronics.com ([63.111.213.197]
	helo=hq-ex-mb01.razamicroelectronics.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQOzC-0004JA-Ed
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:02:12 -0700
In-Reply-To: <20080805124221.GA27469@roarinelk.homelinux.net>
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
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: L-M-O <linux-mips@linux-mips.org>, linux-fbdev-devel@lists.sf.net

T24gVHVlLCAyMDA4LTA4LTA1IGF0IDE0OjQyICswMjAwLCBNYW51ZWwgTGF1c3Mgd3JvdGU6Cj4g
UmVtb3ZlIGxhc3QgdHJhY2VzIG9mIHRoZSBjdXN0b20gQWxjaGVteSBsaW51eC0yLjQgUE0gY29k
ZSwgaW1wbGVtZW50Cj4gc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2tzLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IE1hbnVlbCBMYXVzcyA8bWFub0Byb2FyaW5lbGsuaG9tZWxpbnV4Lm5ldD4KPiAtLS0KPiAg
ZHJpdmVycy92aWRlby9hdTEyMDBmYi5jIHwgIDE2NCArKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgMTIzIGRlbGV0aW9ucygtKQo+IApUaGlzIGxvb2tzIGdvb2QuICBJdCBhcHBsaWVkIHRvIG15
IHRyZWUgYW5kIGFwcGVhcnMgZnVuY3Rpb25hbCBvbiBteQpib2FyZC4gIE9uZSBxdWVzdGlvbjog
d2hhdCBhYm91dCBkeW5hbWljIGJyaWdodG5lc3M/ICBJdCB3YXMgcGFydCBvZiB0aGUKb2xkIFBN
IGludGVyZmFjZSBhbmQgeW91IHNlZW0gdG8gaGF2ZSByZW1vdmVkIGl0LiAgQW55IGlkZWFzIGFi
b3V0CnJlLWludGVncmF0aW5nIHRoYXQgaW50byB0aGUgY3VycmVudCBQTSBtb2RlbD8KCkFja2Vk
LWJ5OiBLZXZpbiBIaWNrZXkgPGtoaWNrZXlAcm1pY29ycC5jb20+CgotLSAKS2V2aW4gSGlja2V5
Cu+7v0FsY2hlbXkgU29sdXRpb25zClJNSSBDb3Jwb3JhdGlvbgpraGlja2V5QFJNSUNvcnAuY29t
ClA6IDUxMi42OTEuODA0NAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLk5ldCBlbWFpbCBpcyBz
cG9uc29yZWQgYnkgdGhlIE1vYmxpbiBZb3VyIE1vdmUgRGV2ZWxvcGVyJ3MgY2hhbGxlbmdlCkJ1
aWxkIHRoZSBjb29sZXN0IExpbnV4IGJhc2VkIGFwcGxpY2F0aW9ucyB3aXRoIE1vYmxpbiBTREsg
JiB3aW4gZ3JlYXQgcHJpemVzCkdyYW5kIHByaXplIGlzIGEgdHJpcCBmb3IgdHdvIHRvIGFuIE9w
ZW4gU291cmNlIGV2ZW50IGFueXdoZXJlIGluIHRoZSB3b3JsZApodHRwOi8vbW9ibGluLWNvbnRl
c3Qub3JnL3JlZGlyZWN0LnBocD9iYW5uZXJfaWQ9MTAwJnVybD0vCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWZiZGV2LWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZmJkZXYtZGV2ZWwK
