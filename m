From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Radeonfb hsync fudge factor?
Date: Wed, 24 Dec 2003 12:18:24 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031224091824.GB11706@master.mivlgu.local>
References: <3FE8D315.1000904@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ59w-00049z-SQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 01:18:28 -0800
Received: from mivlgu.ru ([81.18.140.87] helo=master.mivlgu.local)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ59w-0003eL-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 01:18:28 -0800
Content-Disposition: inline
In-Reply-To: <3FE8D315.1000904@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2003 at 06:43:17PM -0500, John Zielinski wrote:
> What's the hsync fudge factor used for?
> 
> I noticed that the left edged of my screen moved a bit when I was 
> switching between 32/16/8 bpp modes and tracked it down to this.

The same thing here - both with Radeon VE QY and 8500LE (don't remember
the exact chip version).  Adding the opposite value to the fbset
parameters puts the image back into the place - so it looks like the hsync
fudge is unneeded at least with these chipsets.

Probably this fudge factor was needed for some early chips?

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6VngW82GfkQfsqIRAl8LAJoCX8VI75blufJGSktdxbwCVev1+gCfWwGI
SL6j3JWca02Bw3EVwnVijmQ=
=kpNV
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
