From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Fri, 29 Aug 2008 09:07:13 +0200
Message-ID: <1219993633.4421.248.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>  <48B785DA.1030408@renesas.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYy4p-0007UU-Dn for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:07:23 -0700
Received: from fk-out-0910.google.com ([209.85.128.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYy4n-0002Zk-OZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:07:23 -0700
Received: by fk-out-0910.google.com with SMTP id 18so499170fkq.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 00:07:17 -0700 (PDT)
In-Reply-To: <48B785DA.1030408@renesas.com>
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
To: Takashi Yoshii <yoshii.takashi@renesas.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDE0OjE1ICswOTAwLCBUYWthc2hpIFlvc2hpaSB3cm90ZToK
PiAKPiAveW9zaGlpICMgUmVzdG9yaW5nIHBpeGNsb2NrIHdvdWxkIGJlIGEgd29ya2Fyb3VuZCBm
b3IgWG9yZyBpc3N1ZSA6KQoKV2hhdCAnWG9yZyBpc3N1ZSc/IEkndmUgb25seSBzZWVuIGEgbWlz
Y29uZmlndXJhdGlvbiBhbmQgYSBwaXhjbG9jayAwCmlzc3VlIHdoaWNoIGhhcyBiZWVuIGZpeGVk
IGluIFhvcmcuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgfCAgICAg
ICAgICBodHRwOi8vdHVuZ3N0ZW5ncmFwaGljcy5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgIHwgICAgICAgICAgRGViaWFuLCBYIGFuZCBEUkkgZGV2ZWxvcGVyCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpUaGlzIFNGLk5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIE1vYmxpbiBZ
b3VyIE1vdmUgRGV2ZWxvcGVyJ3MgY2hhbGxlbmdlCkJ1aWxkIHRoZSBjb29sZXN0IExpbnV4IGJh
c2VkIGFwcGxpY2F0aW9ucyB3aXRoIE1vYmxpbiBTREsgJiB3aW4gZ3JlYXQgcHJpemVzCkdyYW5k
IHByaXplIGlzIGEgdHJpcCBmb3IgdHdvIHRvIGFuIE9wZW4gU291cmNlIGV2ZW50IGFueXdoZXJl
IGluIHRoZSB3b3JsZApodHRwOi8vbW9ibGluLWNvbnRlc3Qub3JnL3JlZGlyZWN0LnBocD9iYW5u
ZXJfaWQ9MTAwJnVybD0vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWZiZGV2LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mYmRldi1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZmJkZXYtZGV2ZWwK
