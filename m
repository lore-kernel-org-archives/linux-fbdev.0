From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 05:19:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408010519.58517.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200407311826.27332.adaplas@hotpop.com> <20040731133129.GA12797@sci.fi>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br1H7-0000O8-9Z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 14:20:17 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Br1H6-0007tY-Vy
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 14:20:17 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id D4CBE74E8E2
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Jul 2004 20:29:12 +0000 (UTC)
In-Reply-To: <20040731133129.GA12797@sci.fi>
Content-Disposition: inline
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
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Saturday 31 July 2004 21:31, Ville Syrj=E4l=E4 wrote:
> >
> > red_reg[index * 8] =3D red
> > green_reg[index * 8] =3D green
> > blue_reg[index * 8] =3D blue
> >
> > Some hardware require that all 8 entries needs to be filled up.
>
> I noticed you do this in i810fb. What happens if you don't do this?
=A0
Wrong colors. =20

>
> AFAIK mach64 doesn't need this.

Yes, it's hardware dependent. When I decided to add directcolor support,
I initially copied the mach64's setcolreg function but I got wrong
colors at bpp16.  Found out by experimentation that I need to set all
256 entries of the CLUT.

Tony =20




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
