From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Wed, 23 Apr 2008 08:23:22 +1000
Message-ID: <1208903002.9640.140.camel@pasglop>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
	<20080422184141.GI16619@sci.fi>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoQuy-0001RO-Oo for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:24:52 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/uaYiKWTHyQ4MAckRGqqlC0Xne0fJfP7s=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JoQux-0000LY-98
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:24:52 -0700
In-Reply-To: <20080422184141.GI16619@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

Ck9uIFR1ZSwgMjAwOC0wNC0yMiBhdCAyMTo0MSArMDMwMCwgVmlsbGUgU3lyasOkbMOkIHdyb3Rl
Ogo+IERpcmVjdEZCIHVzZXMgYm90aC4KPiAKPiBzbWVtX3N0YXJ0IGlzIHVzZWQgdG8gZ2V0IHRo
ZSBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBmcmFtYnVmZmVyIGZvciB2NGwKPiBjYXB0dXJlIHB1
cnBvc2VzIGF0IGxlYXN0LiBJdCdzIGFsc28gdXNlZCBieSBzZXZlcmFsIG9mIHRoZSBodyBzcGVj
aWZpYwo+IGdmeGRyaXZlcnMgZm9yIHZhcmlvdXMgcmVhc29ucy4gRm9yIGV4YW1wbGUgdGhlIG1h
dHJveCBkcml2ZXIgdXNlcyBpdCB0bwo+IGZpZ3VyZSBvdXQgdGhlIG9mZnNldCBmcm9tIHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIHZpZGVvIG1lbW9yeSB0byB0aGUKPiBwb3J0aW9uIGFsbG9jYXRlZCBm
b3IgQ1JUQzIgYnkgbWF0cm94ZmIuIFRoaXMgb25seSBhcHBsaWVzIHdoZW4gbWF0cm94ZmIKPiBp
cyBsZWZ0IGluIGNvbnRyb2wgb2YgQ1JUQzIuIEkgZG91YnQgbWF5IHBlb3BsZSB1c2UgRGlyZWN0
RkIgdGhpcyB3YXkKPiBzaW5jZSBEaXJlY3RGQiBjYW4gZHJpdmUgQ1JUQzIrVFZvdXQgaXRzZWxm
IGFuZCBtYW5hZ2UgdGhlIGZ1bGwgbWVtb3J5Cj4gZm9yIGJvdGggaGVhZHMuIEJ1dCB0aGUgc3Vw
cG9ydCBpcyBzdGlsbCB0aGVyZSBpbiB0aGUgY29kZSBGV0lXLiBJJ20KPiBub3QgYWN0dWFsbHkg
c3VyZSB3aGF0IHRoZSBvdGhlciBnZnhkcml2ZXJzIHVzZSBpdCBmb3IgYnV0IEkgc2VlIHNldmVy
YWwKPiByZWZlcmVuY2VzIHdoZW4gSSBncmVwIGZvciBpdC4KPiAKPiBtbWlvX3N0YXJ0IGlzIHVz
ZWQgdG8gZmlndXJlIG91dCB3aGVyZSB0aGUgcmVnaXN0ZXJzIGFjdHVhbGx5IGxpZSB3aXRoaW4K
PiB0aGUgbW1hcHBlZCBNTUlPIGFyZWEuIGF0eWZiIGlzIHRoZSBvbmx5IGZiIGRyaXZlciB0aGF0
IEkga25vdyB0byBuZWVkCj4gdGhpcy4gVGhlIHByb2JsZW0gaXMgdGhhdCB3aXRoIG5ldyBjaGlw
cyB0aGUgYXV4IHJlZ2lzdGVyIGFwZXJ0dXJlIGlzCj4gdXNlZCBhbmQgdGhlIHJlZ2lzdGVycyBh
cmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGF0IGFwZXJ0dXJlIGJ1dCB3aGVuIHRoZQo+IGF1eCBy
ZWdpc3RlciBhcGVydHVyZSBpcyBub3QgdXNlZCB0aGUgcmVnaXN0ZXJzIG9jY3VweSB0aGUgbGFz
dCAySwo+IG9mIHRoZSBmcmFtZWJ1ZmZlci4gVGhhdCBtZWFucyBhbiBvZmZzZXQgb2YgMksgb24g
dHlwaWNhbCBzeXN0ZW1zLgoKU28gRGlyZWN0RkIgY2FuIGJlIGZpeGVkIHRvIHVzZSB0aGUgIm5l
dyIgc3RydWN0dXJlIHdpdGggNjQgYml0cyBvZmZzZXRzCmlmIHdlIGRlZmluZSBzdWNoIGEgdGhp
bmcgcmlnaHQgPyAod2l0aCBuZXcgaW9jdGwncyB0byBhY2Nlc3MgaXQpLgoKQ2hlZXJzLApCZW4u
CgoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YubmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0
aGUgMjAwOCBKYXZhT25lKFNNKSBDb25mZXJlbmNlIApEb24ndCBtaXNzIHRoaXMgeWVhcidzIGV4
Y2l0aW5nIGV2ZW50LiBUaGVyZSdzIHN0aWxsIHRpbWUgdG8gc2F2ZSAkMTAwLiAKVXNlIHByaW9y
aXR5IGNvZGUgSjhUTDJEMi4gCmh0dHA6Ly9hZC5kb3VibGVjbGljay5uZXQvY2xrOzE5ODc1NzY3
MzsxMzUwMzAzODtwP2h0dHA6Ly9qYXZhLnN1bi5jb20vamF2YW9uZQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRldmVsCg==
