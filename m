From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Framebuffers and VC setup (via fbcon.c)
Date: Wed, 10 Mar 2004 23:02:22 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040310220222.GG17857@lug-owl.de>
References: <20040309143950.GS17857@lug-owl.de> <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3y/CVJp2vtgPOhvS"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1C3m-0002Ng-7T
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 14:20:18 -0800
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B1BNT-0003yb-LE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 13:36:35 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradead.org>
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


--3y/CVJp2vtgPOhvS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-03-10 18:15:57 +0000, James Simmons <jsimmons@infradead.org>
wrote in message <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradea=
d.org>:
> > 	- Despite the fact that (quite late in the boot process)
> > 	  vc_init() is called (with correct looking arguments), I think
> > 	  it should have been called quite some time earlier. With other
> > 	  (PC based) graphic cards, the machine just switches to FB mode
> > 	  after the FB driver is initialized. All further output is put
> > 	  there. But not here...
> >=20
> > I haven't yet really understood how FB and console code work together,
> > so it would be nice to have some hints there :)

In the meantime, another VAX hacker (who initially worked on the 2.4.x
code base) hinted me: in the arch_setup function, I was missing a=20

	conswitchp =3D &dummy_con;

After adding these, I got a penguin and a login prompt. However, the
console output (during further boot-up) didn't show up. But I'll get
there:)

>     I'm going to have to look at your driver. Normally one of two things=
=20
> happen. Some driver have there hardware modes set by firmware and they=20
> can't be changed. For example VESA fbdev. In this case you lack a=20
> xxxfb_check_var and xxxfb_set_par function. Then fbcon doesn't attempt to=
=20
> change the hardware state but use the current one.=20
>   The other case is that your driver sets the hardware state. You have a=
=20
> set_check_var and a set_par function hook in struct fb_info->fbops. So th=
e=20
> fbcon layer will call set_par directly for you.

Well, as I know today, there are more variants of this hardware, some of
them capable of changing screen resolution. So I think I'd add those two
functions (after I figured out how to actually change modes, or even how
to properly detect the available hardware at all:)

Thanks for these valuable hints! Oh, just another question: the largest
of theses framebuffer devices can handle four CRTs. Just need to
register four framebuffers, then?

After all, I've had my very first local login last night, at 00:42:23
CET with local monitor and keyboard on a VAX. Right, I waited some
seconds to get that nice time on my watch:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--3y/CVJp2vtgPOhvS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAT5BuHb1edYOZ4bsRAvXRAJ9xHQoDLuQ34hrNRAJ1olv6C4UvWACeO3FK
Rwm5zOhPkfhdKDbm4C3zA10=
=yAoc
-----END PGP SIGNATURE-----

--3y/CVJp2vtgPOhvS--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
