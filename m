From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 07:37:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408010737.53996.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200408010519.58517.adaplas@hotpop.com> <200408010019.41627.alex.kern@gmx.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br3QW-0003Uo-Hl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 16:38:08 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61] helo=babyruth.hotpop.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br3QW-0007rO-4B
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 16:38:08 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 11A39742FD1
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Jul 2004 22:46:58 +0000 (UTC)
In-Reply-To: <200408010019.41627.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>, linux-fbdev-devel@lists.sourceforge.net
Cc: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Sunday 01 August 2004 06:19, Alexander Kern wrote:
> Am Samstag, 31. Juli 2004 23:19 schrieb Antonino A. Daplas:
> > On Saturday 31 July 2004 21:31, Ville Syrj=E4l=E4 wrote:
> > > > red_reg[index * 8] =3D red
> > > > green_reg[index * 8] =3D green
> > > > blue_reg[index * 8] =3D blue
> > > >
> > > > Some hardware require that all 8 entries needs to be filled up.
> > >
> > > I noticed you do this in i810fb. What happens if you don't do this?
> >
> > =A0
> > Wrong colors.
> >
> > > AFAIK mach64 doesn't need this.
> >
> > Yes, it's hardware dependent. When I decided to add directcolor support,
> > I initially copied the mach64's setcolreg function but I got wrong
> > colors at bpp16.  Found out by experimentation that I need to set all
> > 256 entries of the CLUT.
> >
> > Tony
>
> Very scurry, even mach64 give wrong colors for me ;-))
>
> Here are the pics, that demonstrate my errors.

Actually, this is one of the nuances that affect DirectColor at < 24 bpp.
Since RGB565 has only at the most 64 entries (based on the depth of
the green channel), a 224-color logo will be drawn incorrectly. 16-bit
Directcolor actually needs a 16-color logo. Unfortuanately, the logo
drawing code will choose a 224-color logo for Directcolor 16-bit.  This is
problem that I pointed out to James a long time ago when he rewrote the=20
logo drawing code.=20

It's a little bit surprising that 8-bit pseudocolor can actually draw a
224-color logo correctly, while 16-bit directcolor cannot :-)

Workaround:
	Force fbdev to use 16-color linux logo in the "Boot Logo" option
	of your kernel config.

I'll see if I can find a way for a more definitive fix.

Tony

P.S. This problem might be unique to the logo drawing code.




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
