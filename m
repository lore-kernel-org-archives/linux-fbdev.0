From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_Disable_mach64_accelera?=
	=?utf-8?q?tor_if_stride_is_not_multiple_of_64?=
Date: Thu, 18 Jun 2009 08:38:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0906180832400.32677@hs20-bc2-1.build.redhat.com>
References: <20090618101700.D192310824B8@f22.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279731514-27309845-1245328700=:32677"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1MHHB8-00066D-4K
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 12:57:18 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHHB5-0002b6-Ha for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jun 2009 12:57:16 +0000
In-Reply-To: <20090618101700.D192310824B8@f22.poczta.interia.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: paulus@samba.org, Ville =?UTF-8?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279731514-27309845-1245328700=:32677
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Jun 2009, krzysztof.h1@poczta.fm wrote:

> > Mikulas Patocka napisa=B3(a):
> >=20
> >=20
> > BTW. why doesn't it use accelerator for screen scrolling? It seems to=
=20
> > redraw all non-empty characters, which is fast if most of the screen is=
=20
> > empty but gets slower if the screen is full of text.
> >=20
>=20
> It uses the accelerater.. The screen redraw uses accelerated imageblit() =
function=20
> if it exists.
> In order to use the blitter one must define FBINFO_READS_FAST flag. Howev=
er,
> it may not end up faster. It is faster if the memory is fast while chip i=
s not
> so fast relatively (e.g. all new GeForce and Radeon chips, 3DFxx Voodoo3+=
 have=20
> very fast memory attached).
> It  may vary for other chips, i.e. even if your ati card equiped with sgr=
am it is=20
> faster it may be slower for the same chip with sdram.
>=20
> Also, if blitter is used for scrolling the crolling speed goes down with =
increasing=20
> pixel depth which is not a case for the redraw method.
>=20
> Regards,
> Krzysztof

I tried to define FBINFO_READS_FAST. At some tests it was as fast as=20
without it, at some it was about 20% faster.

So the only way how to avoid this slow-scroll annoyance would be to batch=
=20
the updates --- i.e. don't scroll after each line of output but scroll=20
after for example 5 lines. But it would mean major code redesign...

Mikulas
--279731514-27309845-1245328700=:32677
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--279731514-27309845-1245328700=:32677
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--279731514-27309845-1245328700=:32677--
