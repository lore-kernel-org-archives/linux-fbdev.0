From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [Linux-fbdev-devel] Matrox G550, dual head, 1680x1050
Date: Mon, 05 Mar 2007 09:09:58 +0100
Message-ID: <1173082199.28557.149.camel@thor.sulgenrain.local>
References: <200703021053.00955.hjk@linutronix.de>
	<200703021610.58188.hjk@linutronix.de>
	<20070302152414.GC907@code-monkey.de>
	<200703042247.21590.hjk@linutronix.de> <45EBA3B6.3060701@vc.cvut.cz>
	<Pine.LNX.4.62.0703050732340.15476@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <Pine.LNX.4.62.0703050732340.15476@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: xorg@lists.freedesktop.org

On Mon, 2007-03-05 at 07:33 +0100, Geert Uytterhoeven wrote:
> On Sun, 4 Mar 2007, Petr Vandrovec wrote:
> > Hans-Jrgen Koch wrote:
> > > Am Freitag, 2. Mrz 2007 16:24 schrieb Tilman Sauerbeck:
> > > Meanwhile I doubt this explanation. Here's what fbset has to say:
> > >=20
> > > $ fbset -fb /dev/fb1 --show
> > >=20
> > > mode "1680x1050-60"
> > >     # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
> > >     geometry 1680 1050 1680 1050 32
> > >     timings 7380 32 224 32 4 136 4
> > >     rgba 8/16,8/8,8/0,8/24
> > > endmode
> > >=20
> > > So, even fbset thinks it's 1680x1050. But where does the distortion=
 come=20
> > > from???
> >=20
> > Can you try setting vxres for second head from 1680 to 1696, or 1728?=
=20
> > Maybe X look at vxres and not at framebuffer line length (what fbset =
-i=20
> > reports for line length?)
>=20
> These days at least the X server in Debian looks correctly at the frame=
 buffer
> line length, else it wouldn't work on PS3 with non-fullscreen modes.

It depends on the driver. The fbdev and radeon drivers should handle it
correctly, not sure about others.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphics=
.com
Libre software enthusiast         |          Debian, X and DRI developer
