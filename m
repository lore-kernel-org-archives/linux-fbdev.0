From: Adam Jackson <ajax@nwnk.net>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 11:48:54 -0500
Message-ID: <200503161148.58067.ajax@nwnk.net>
References: <1110837171.5863.16.camel@gaston> <1110954676.5271.2.camel@gaston>
	<20050316140948.GA20074@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1463445705=="
In-Reply-To: <20050316140948.GA20074@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: dri-devel@lists.sourceforge.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>

--===============1463445705==
Content-Type: multipart/signed; boundary="nextPart3125869.inGpYOEELP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3125869.inGpYOEELP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 16 March 2005 09:09, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Wed, Mar 16, 2005 at 05:31:16PM +1100, Benjamin Herrenschmidt wrote:
> > Well, do they "revert" it after atyfb/aty128fb/radeonfb set it then ?
> > it's definitely set on mode switch.
>
> The point is that there can be offscreen surfaces with different depth
> than the fbdev surface.

_Will_ be.  Otherwise GL and Render performance drops through the floor.

=2D ajax

--nextPart3125869.inGpYOEELP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCOGN5W4otUKDs0NMRAuaCAKCRhf7dRLOUWv0Hcy+z1glmKsQRdgCfWyDR
557W3Ozpg+2aA6Be77d/QR0=
=nyQ/
-----END PGP SIGNATURE-----

--nextPart3125869.inGpYOEELP--

--===============1463445705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg

--===============1463445705==--
