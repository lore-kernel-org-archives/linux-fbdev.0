From: Joshua Kwan <joshk@ludicrus.ath.cx>
Subject: Re: Radeonfb in 2.5.54bk
Date: Tue, 7 Jan 2003 15:41:41 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030107154141.259f84c3.joshk@ludicrus.ath.cx>
References: <20030107161954.GB15405@kanoe.ludicrus.net>
	<Pine.LNX.4.44.0301072224350.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.x'6xu,NYmPd7De"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100] helo=localhost)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W3OX-0007uq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 15:44:29 -0800
In-Reply-To: <Pine.LNX.4.44.0301072224350.17129-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

--=.x'6xu,NYmPd7De
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Latest patch? If it's the one you pushed to BK a day or two ago, that is
what I used in the compilation of my kernel. Hence it doesn't quite
work.

(to be precise, i issued:
bk clone http://linux.bkbits.net:8080/linux-2.5
bk -r get
bk pull http://fbdev.bkbits.net:8080/fbdev-2.5)

Anything wrong there? Do I have to bk -r get again?

Looks like I am subscribing to this list then. Sigh... too many lists to
take care of!! :(

Regards
Josh

Rabid cheeseburgers forced
James Simmons<jsimmons@infradead.org> to write this on Tue, 7 Jan 2003
22:26:09 +0000(GMT):	

> 
> > My 2.5.54 build instantly switches to the right res, 1024x768.
> > However I do see all the initial junk on the screen. Everything else
> > seems to work well, however. Does the initial junk show up on other
> > fb devices? The same junk would show up in 2.5.54 release but it
> > would switch resolutions and kill init.
> 
> Hm. I never ran into the intial junk stuff. I have had issues when
> going from vgacon at 80x30 to neofb at 160x48. The resize didn't
> change the data in struct vc_data. The latest patch shoudl fix that.
> 
> 
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest.

--=.x'6xu,NYmPd7De
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+G2W36TRUxq22Mx4RAhEiAKCNDWqGKP6hMF1PFwZcjH0XrJK25gCgjzrg
VN7jaJooQflncvxOK4FtpBA=
=9rw1
-----END PGP SIGNATURE-----

--=.x'6xu,NYmPd7De--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
