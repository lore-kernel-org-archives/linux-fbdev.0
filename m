From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb (2.6): Add RGB565 support
Date: Thu, 13 May 2004 22:19:48 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040513191948.GA25590@sci.fi>
References: <20040511213607.GB6854@sci.fi> <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be> <20040512185724.GA825@sci.fi> <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOLkG-0003QV-AL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 12:19:52 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOLkF-00018W-TT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 12:19:52 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id A728B4E4F
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 May 2004 22:19:48 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be>
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

On Thu, May 13, 2004 at 11:22:01AM +0200, Geert Uytterhoeven wrote:
> 	Hi Ville,
>=20
> On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > On Wed, May 12, 2004 at 11:11:21AM +0200, Geert Uytterhoeven wrote:
> > > On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > > > This patch adds RGB565 support to atyfb.
> > >
> > > Nice! Have you tried fbtest on it?
> > >
> > > I once tried to implement it myself, but it didn't work reliably.
> >
> > I just tried fbtest and most tests look ok. The penguin images are wr=
ong
> > (green instead of white stuff aroung the penguin) and the test009 loo=
ks
> > wrong too. Are you sure fbtest is doing the right thing with rgb565
> > directcolor visuals? DirectFB or mplayer don't have any problems.
>=20
> It's always possible there's a bug in fbtest w.r.t. 565 handling, but I=
 didn't
> see it.

It has the same problems on aty128fb so either that driver is broken too=20
or the fault lies with fbtest. On matroxfb RGB565 is fine but matroxfb=20
uses a truecolor visual.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
