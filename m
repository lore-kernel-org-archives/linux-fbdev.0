From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: New FBDev patch
Date: Thu, 8 Jan 2004 18:05:33 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040108230533.GA20713@linux-sh.org>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AejDj-0004iW-HA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 15:05:43 -0800
Received: from smtp.golden.net ([199.166.210.31] helo=newsmtp.golden.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AejDj-00005y-7K
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 15:05:43 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons wrote:
> This is the latest patch against 2.6.0-rc3. Give it a try.
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
> Here are the changes.
>=20
>  drivers/video/pvr2fb.c                |  846 -
[snip]
> <jsimmons@maxwell.earthlink.net> (03/05/14 1.1046.73.2)
>    [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.
>=20
Please drop this from your patch, it re-introduces a number of parse
errors that I already fixed in the 2.6 tree.

On another note, I do have some more pvr2fb updates pending, but I'll send
these to you seperately.


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE//eI91K+teJFxZ9wRAmaBAJsF/NmKb8BqQQNiztX8XPxqNs/JWQCfcv5U
3cgWdlqdMbuAAT5IkBXyBLY=
=wXei
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
