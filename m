From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Radeonfb hsync fudge factor?
Date: Thu, 25 Dec 2003 00:00:03 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031224210003.GB2377@sirius.home>
References: <3FE8D315.1000904@undead.cc> <20031224091824.GB11706@master.mivlgu.local> <Pine.GSO.4.58.0312241310520.1638@waterleaf.sonytel.be> <3FE9FCA9.3070107@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZG7h-0003Qa-4J
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 13:00:53 -0800
Received: from [213.177.124.23] (helo=sirius.home)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AZG7g-0006Pi-GA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 13:00:52 -0800
Content-Disposition: inline
In-Reply-To: <3FE9FCA9.3070107@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: John Zielinski <grim@undead.cc>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2003 at 03:52:57PM -0500, John Zielinski wrote:
> Geert Uytterhoeven wrote:
> 
> >On Wed, 24 Dec 2003, Sergey Vlasov wrote:
> > 
> >
> >>Probably this fudge factor was needed for some early chips?
> >>   
> >>
> >
> >Yep, Mach64 needs one (but atyfb doesn't take care of it yet). So if you 
> >switch
> >between depths, the display may shift horizontally. I guess this is due to
> >different lengths of the dataflow paths for different color depths.
> > 
> >
> 
> How many cards handled by radeonfb need it?   That way we can add a 
> fudge or nofudge driver option.  Or put it in the card database if the 
> numbers are roughly equal.

I suspect that either none of these cards need it (if this is really a
leftover from Mach64 days), or maybe some of the oldest (R100) cards
need it.  Radeon VE QY (RV100) and 8500 QL (R200) certainly don't need
this fudge factor.

Does someone have an old R100-based card to test this?

> I need to see if that's what's causing the sync problems with my friends 
> HDTV....

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6f5TW82GfkQfsqIRArqAAJ4kkEUnnI2WPT4OQbdIzTdr+EmFFACaA2ha
V0USQsKTs1ORJKDukXTgxOg=
=7rir
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
