From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb (2.6): Add RGB565 support
Date: Wed, 12 May 2004 21:57:24 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040512185724.GA825@sci.fi>
References: <20040511213607.GB6854@sci.fi> <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNyv2-0004SD-PK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 11:57:28 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNyv2-0003sT-Jf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 11:57:28 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 0FA361147D0A
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 May 2004 21:57:25 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, May 12, 2004 at 11:11:21AM +0200, Geert Uytterhoeven wrote:
> On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > This patch adds RGB565 support to atyfb.
>=20
> Nice! Have you tried fbtest on it?
>=20
> I once tried to implement it myself, but it didn't work reliably.

I just tried fbtest and most tests look ok. The penguin images are wrong=20
(green instead of white stuff aroung the penguin) and the test009 looks=20
wrong too. Are you sure fbtest is doing the right thing with rgb565=20
directcolor visuals? DirectFB or mplayer don't have any problems.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
