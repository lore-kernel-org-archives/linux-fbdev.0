From: Nicolas Souchu <nsouch@free.fr>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Mon, 10 May 2004 22:42:43 +0000
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040510224243.C2268@armor.freesurf.fr>
References: <1084150645.2909.4.camel@gaston> <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org> <20040510162837.GA7544@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040510162837.GA7544@sci.fi>; from syrjala@sci.fi on Mon, May 10, 2004 at 07:28:37PM +0300
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

On Mon, May 10, 2004 at 07:28:37PM +0300, Ville Syrj=E4l=E4 wrote:
[...]
>=20
> Rendering and mode switching are completely separate issues.

Indeed and I guess we can even use the VESA mode setting and the HW
engine of recent graphic boards "concurrently".

The console system is responsible for modesetting regarding the
needs of text apps vs graphic apps vs kernel and the current focus.

--=20
Nicholas Souchu - nsouch@free.fr - nsouch@FreeBSD.org
http://www.freebsd.org/~nsouch/kgi4BSD


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
