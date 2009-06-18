From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_Disable_mach64_accelera?=
	=?utf-8?q?tor_if_stride_is_not_multiple_of_64?=
Date: 18 Jun 2009 12:17:00 +0200
Message-ID: <20090618101700.D192310824B8@f22.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MHEgA-0006Dz-Ez
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 10:17:10 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHEg4-0004LH-EN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 10:17:10 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Mikulas Patocka <mpatocka@redhat.com>, Ville =?UTF-8?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net, paulus@samba.org

Mikulas Patocka napisa=B3(a):
> =

> =

> BTW. why doesn't it use accelerator for screen scrolling? It seems to =

> redraw all non-empty characters, which is fast if most of the screen is =

> empty but gets slower if the screen is full of text.
> =


It uses the accelerater.. The screen redraw uses accelerated imageblit() fu=
nction =

if it exists.
In order to use the blitter one must define FBINFO_READS_FAST flag. However,
it may not end up faster. It is faster if the memory is fast while chip is =
not
so fast relatively (e.g. all new GeForce and Radeon chips, 3DFxx Voodoo3+ h=
ave =

very fast memory attached).
It  may vary for other chips, i.e. even if your ati card equiped with sgram=
 it is =

faster it may be slower for the same chip with sdram.

Also, if blitter is used for scrolling the crolling speed goes down with in=
creasing =

pixel depth which is not a case for the redraw method.

Regards,
Krzysztof

----------------------------------------------------------------------
Nowa akcja Pepsi - nagrody za kody spod nakretek. Zarejestruj sie!
http://link.interia.pl/f21cc =




---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
