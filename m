From: Johan Bolmsjo <johan@nocrew.org>
Subject: Re: Re: status
Date: 25 Nov 2002 22:35:52 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1038260153.1027.26.camel@skalman>
References: <Pine.LNX.4.44.0211251832200.22897-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from c-c91d70d5.027-12-67626717.cust.bredbandsbolaget.se ([213.112.29.201] helo=skalman)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GR11-0004tp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 13:43:39 -0800
Received: from skalman ([127.0.0.1] helo=localhost.localdomain)
	by skalman with esmtp (Exim 3.36 #1 (Debian))
	id 18GQtV-00037M-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 22:35:53 +0100
In-Reply-To: <Pine.LNX.4.44.0211251832200.22897-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

m=E5n 2002-11-25 klockan 19.47 skrev James Simmons:
>=20
> > > Geert is busy porting the Amigia driver to the new api. That means al=
l the=20
> > > ilbm, iplan stuff will go away :-)=20
> >=20
> > I have first code for amifb, but it doesn't work yet, due to other prob=
lems
> > with 2.5.x on Amiga. I hope to fix these tomorrow...
>=20
> Yeah!!!
>=20
> > Besides, we still need someone to take care of the Atari 2-byte interle=
aved
> > bitplanes (iplan2p*), since I don't have the hardware, and am not 100% =
sure=20
> > how they work. But reviving 2.5.x on Atari will be even harder...

For what it's worth, the interleaved modes on atari works like this:

The bitplanes are interleaved on 16 bit big-endian word basis so if you
have two bitplanes, bit 0 of the first 16 pixels would be in the first
16 bit word in the display memory, bit 1 of the first 16 pixels would be
in the second word. With bit 0 I mean as masked out by & 0x0001 in C,
and bit 1 as masked out by 0x0002.

The Atari ST line support three resolutions by default:
320x200 4 bit planes
640x200 2 bit planes
640x400 1 bit plane

The Atari Falcon has a programmable clock so many resolutions are
possible and it also features a 8 bit planes mode and 16 bit high colour
mode.

P.S.
I don't have any Atari hardware myself anymore.

>    Me neither. But there is a way to find out. A trick I used to figure=20
> out the hga framebuffer lay out. Build just the fbdev layer without fbcon=
.=20
> Then do a write to /dev/fbX to see what happens.=20
>    The way I have fbdev now is when you open /dev/fb0 the hardware mode i=
s=20
> set. When you close the /dev/fb the hardware goes back to text mode. I di=
d=20
> it this way so you could insmod the driver and NOT change the hardware=20
> state. Also fb_open is the function register_framebuffer needs just befor=
e=20
> take_over_console happens. The other benifiet is if X dies that uses=20
> /dev/fb to set it modes then the file will be closed automatically and te=
h=20
> hardware state will be set to a sane state. This is for the case of vgaco=
n=20
> with fbdev. WHat about from fbco? Well that is easy since fb_open passes =
a=20
> falg to let us knwo if it is from userland for fbcon.
>=20
> P.S
>    It appears fbcon is totally broken in BK. I'm using the above trick to=
=20
> test the code. Tonight I'm going to work on making fbcon completely=20
> modular. Yeah!!!!
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Get the new Palm Tungsten T=20
> handheld. Power & Color in a compact size!=20
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
