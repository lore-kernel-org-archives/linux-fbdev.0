From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: vblank irq support
Date: Mon, 26 Jul 2004 02:36:16 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040725233616.GA25090@sci.fi>
References: <20040722184937.GA11361@sci.fi> <200407250112.18689.alex.kern@gmx.de> <20040725101601.GA15233@sci.fi> <200407252029.10373.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BosXS-0004pv-VX
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 16:36:18 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BosXS-0000bS-HA
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 16:36:18 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id B833245AB5
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 26 Jul 2004 02:36:16 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200407252029.10373.alex.kern@gmx.de>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, Jul 25, 2004 at 08:29:10PM +0200, Alexander Kern wrote:
> Am Sonntag, 25. Juli 2004 12:16 schrieb Ville Syrj=E4l=E4:
> > On Sun, Jul 25, 2004 at 01:12:18AM +0200, Alexander Kern wrote:
> > > Issue with 24bpp mode and fbtest, yellow parts of pinguin image are
> > > blue!!!
> >
> > I've never tried 24bpp because of limited acceleration support. I hav=
en't
> > even bothered implenenting 24bpp acceleration in the DirectFB driver.
> Interesting, I thought 24bpp hardware acceleration is complete? What is=
=20
> missed?

For fbcon probably nothing. But I think mach64 can't draw besenham lines=20
or use the front end scaler/3D pipe with 24bpp. Those two are enough to=20
keep me from using it and maybe there were some additional limitations as=
=20
well.

PS.
The cursor code appears to be working quite well. One small problem: The=20
cursor is invisble it's while moving. But that's probably a problem with=20
the generic cursor code. And it may have been fixed already (I'm still=20
running 2.6.5-mm6 + quite a bit of patches).

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
