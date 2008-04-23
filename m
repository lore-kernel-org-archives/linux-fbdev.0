From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits	resources
	on 32 bits archs
Date: Wed, 23 Apr 2008 19:40:33 +1000
Message-ID: <1208943633.9060.26.camel@pasglop>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JobUy-0003bR-Gi for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:42:44 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+tHqhphvhehJ042PZIbr+suaNm+xJ34bE=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JobUw-0002iz-7Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:42:43 -0700
In-Reply-To: <1208943127.5632.324.camel@thor.sulgenrain.local>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>, Wolfgang Denk <wd@denx.de>

Ck9uIFdlZCwgMjAwOC0wNC0yMyBhdCAxMTozMiArMDIwMCwgTWljaGVsIETDpG56ZXIgd3JvdGU6
Cj4gPiBYIGlzIGRvaW5nIGEgbW1hcCBvZiAvZGV2L21lbSBpbnN0ZWFkIG9mIC9kZXYvZmIgPwo+
ID4gCj4gPiBZb3UgY2FuIG5vcm1hbGx5IG1hcCB0aGUgZmIgbWFwcGluZyAvZGV2L2ZiIGFuZCB0
aGVuIG1hcCB0aGUKPiByZWdpc3RlcnMKPiA+IHVzaW5nIC9kZXYvZmIgYXQgYW4gb2Zmc2V0IGJl
eW9uZCB0aGUgZnJhbWVidWZmZXIgKGZpeC0+c21lbV9sZW4pLgo+ID4gCj4gPiBJZiBYIGlzIHVz
aW5nIC9kZXYvbWVtIGluc3RlYWQsIHRoZW4gaXQncyBiZWluZyBzdHVwaWQgYW5kIG5lZWRzIHRv
Cj4gYmUKPiA+IGZpeGVkLi4uCj4gCj4gSXQncyB1cCB0byB0aGUgZHJpdmVyLCBhbmQgYWdhaW4s
IHRoZSBjdXJyZW50IHJhZGVvbiBkcml2ZXIgZG9lc24ndAo+IHVzZQo+IHJhZGVvbmZiIGF0IGFs
bCBhbnltb3JlLi4uCgpSaWdodC4gQW5kIEknbSBoYXBweSB0byBnbyBmaXggd2hhdCByZW1haW5z
LCBkb24ndCBnZXQgbWUgd3JvbmcgaGVyZSA6LSkKV2UgYWxsIGtub3cgaG93IHN0dXBpZCBsZWdh
Y3kgY29kZSBjYW4gYmUgIQoKSSdsbCB0cnkgdG8gZ2V0IHNvbWUgcGF0Y2hlcyB0byBleHBvc2Ug
YSBuZXcgdmVyc2lvbiBvZiB0aGUgc3RydWN0dXJlCnNvbWV0aW1lcyBpbiB0aGUgdXBjb21pbmcg
d2VlayBvciB0d28gKHdlJ2xsIHNlZSB3aGF0IHRpbWUgcGVybWl0cykgYW5kCnRoZW4gc2VlIGFi
b3V0IGZpeGluZyBYIGRyaXZlcnMgdGhhdCBuZWVkIGZpeGluZywgdGhvdWdoIGhvcGVmdWxseSB3
aXRoCnBjaS1yZXdvcmsgYmVpbmcgdXBzdHJlYW0gbm93LCB0aGF0IHNob3VsZG4ndCBiZSBtYW55
LgoKVGhlIG1haW4gaXNzdWUgaXMgZGlyZWN0ZmIuIEkgaG9wZSB0aGV5J2xsIGNhdGNoIHVwIHdp
dGggdGhlIG5ldyBpb2N0bHMuCgpCZW4uCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQg
ZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSAyMDA4IEphdmFPbmUoU00pIENvbmZlcmVuY2UgCkRv
bid0IG1pc3MgdGhpcyB5ZWFyJ3MgZXhjaXRpbmcgZXZlbnQuIFRoZXJlJ3Mgc3RpbGwgdGltZSB0
byBzYXZlICQxMDAuIApVc2UgcHJpb3JpdHkgY29kZSBKOFRMMkQyLiAKaHR0cDovL2FkLmRvdWJs
ZWNsaWNrLm5ldC9jbGs7MTk4NzU3NjczOzEzNTAzMDM4O3A/aHR0cDovL2phdmEuc3VuLmNvbS9q
YXZhb25lCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWZiZGV2LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZmJkZXYtZGV2ZWwK
