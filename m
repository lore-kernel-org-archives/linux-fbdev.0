From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Mon, 10 May 2004 19:28:37 +0300
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040510162837.GA7544@sci.fi>
References: <1084150645.2909.4.camel@gaston> <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="iso-8859-1"
To: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, May 10, 2004 at 05:14:04PM +0100, James Simmons wrote:
>=20
> > You are mixing things. Mode setting has nothing to do with rendering.=
 OpenGL
> > is a rendering client. It produces commands sent to the low level ker=
nel
> > driver and provides a 3D API, but it's not the only one. In this rega=
rd,
> > fbcon is a client too and XFree 2D accel is another one.
>=20
> But we are rendering to draw fonts, clearing a area of the screen,copya=
rea.
> If we are to have a universal solution it needs to OpenGL. Either that =
or=20
> mode switching stays in the kernel. =20

Rendering and mode switching are completely separate issues.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
