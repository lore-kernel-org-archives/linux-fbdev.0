From: Hans Oischinger <hans.oischinger@h3c.de>
Subject: Re: [Bugme-new] [Bug 4295] New: Garbage all over the screen when using radeonfb
Date: Tue, 22 Mar 2005 17:37:18 +0100
Message-ID: <200503221737.22355.hans.oischinger@h3c.de>
References: <200503051635.j25GZrLN023650@fire-1.osdl.org> <20050321145439.0cb26989.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1495328.aulD9jzDro";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDmNm-0001B1-5e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 08:37:30 -0800
Received: from rfhs0023.fh-regensburg.de ([194.95.104.23])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DDmNk-0004YX-BV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 08:37:30 -0800
In-Reply-To: <20050321145439.0cb26989.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

--nextPart1495328.aulD9jzDro
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 21 March 2005 23:54, Andrew Morton wrote:
> bugme-daemon@osdl.org wrote:
> > http://bugme.osdl.org/show_bug.cgi?id=3D4295
>
> Hans, could you please test 2.6.12-rc1, adn even 2.6.12-rc1-mm1?

kernel 2.6.12-rc1 works fine for me (although ati-drivers do not compile=20
anymore). No more garbage.

Thanks for the fix :)
 Hans

--nextPart1495328.aulD9jzDro
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCQEnCxj5iiDKg1wQRAgnXAJ9Jd60L5azM6mZ7TRd6S0OIBXmr3QCdF6Op
w+FsUPljy28ngHblg4WTzN8=
=B2Y5
-----END PGP SIGNATURE-----

--nextPart1495328.aulD9jzDro--


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
