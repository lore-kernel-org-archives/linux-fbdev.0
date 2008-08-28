From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Do set var
	even	if	no	fb_check_var() provided.
Date: Fri, 29 Aug 2008 00:18:47 +0200
Message-ID: <1219961927.4421.220.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<1219906414.4421.142.camel@thor.sulgenrain.local>
	<48B71C1D.9040908@gmx.de>
	<1219961318.4421.213.camel@thor.sulgenrain.local>
	<48B723B2.9060306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYppQ-0000zq-GC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:18:56 -0700
Received: from fk-out-0910.google.com ([209.85.128.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYppP-0004DH-3r
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:18:56 -0700
Received: by fk-out-0910.google.com with SMTP id 18so400316fkq.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 28 Aug 2008 15:18:52 -0700 (PDT)
In-Reply-To: <48B723B2.9060306@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDAwOjE2ICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gPiBPbiBUaHUsIDIwMDgtMDgtMjggYXQgMjM6NDMgKzAy
MDAsIEhlbGdlIERlbGxlciB3cm90ZToKPiA+PiBZb3VyIGlkZWEgYWJvdXQgdGVzdGluZyBhIGZl
dyBtb2RlIGxpbmVzIGlzIG5vcm1hbGx5IGEgZ29vZCBpZGVhLgo+ID4gCj4gPiBNeSBpZGVhIGlz
IHF1aXRlIHRoZSBvcHBvc2l0ZSAtIHRvIHRyeSAqd2l0aG91dCogZXZlbiB0aGUgTW9kZXMgbGlu
ZSBpbgo+ID4gU3ViU2VjdGlvbiAiRGlzcGxheSIuIENhbiB5b3UgdHJ5IHRoYXQgcGxlYXNlPwo+
IAo+IAo+IERvZXNuJ3Qgd29yayBlaXRoZXIuCj4gCj4gYSkgSWYgSSBkcm9wIHRoZSAibW9uaXRv
ciIgbGluZSBpbiB0aGUgU2NyZWVuIHNlY3Rpb24gaXQgY2hvb3NlcyBhIAoKWy4uLl0KCj4gYikg
SWYgSSBqdXN0IGRyb3AgdGhlIEhvcml6U3luYyBhbmQgVmVydFJlZnJlc2ggZW50cmllcywgaXQg
ZmFpbHMgYXMgd2VsbDoKClsuLi5dCgpXaGljaCBwYXJ0IG9mICd0aGUgTW9kZXMgbGluZSBpbiBT
dWJTZWN0aW9uICJEaXNwbGF5IicgaXMgc28gaGFyZCB0bwp1bmRlcnN0YW5kPyAqc2hydWcqCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgfCAgICAgICAgICBodHRwOi8v
dHVuZ3N0ZW5ncmFwaGljcy5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgIHwg
ICAgICAgICAgRGViaWFuLCBYIGFuZCBEUkkgZGV2ZWxvcGVyCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpU
aGlzIFNGLk5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIE1vYmxpbiBZb3VyIE1vdmUgRGV2
ZWxvcGVyJ3MgY2hhbGxlbmdlCkJ1aWxkIHRoZSBjb29sZXN0IExpbnV4IGJhc2VkIGFwcGxpY2F0
aW9ucyB3aXRoIE1vYmxpbiBTREsgJiB3aW4gZ3JlYXQgcHJpemVzCkdyYW5kIHByaXplIGlzIGEg
dHJpcCBmb3IgdHdvIHRvIGFuIE9wZW4gU291cmNlIGV2ZW50IGFueXdoZXJlIGluIHRoZSB3b3Js
ZApodHRwOi8vbW9ibGluLWNvbnRlc3Qub3JnL3JlZGlyZWN0LnBocD9iYW5uZXJfaWQ9MTAwJnVy
bD0vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWZiZGV2LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZmJkZXYtZGV2ZWwK
