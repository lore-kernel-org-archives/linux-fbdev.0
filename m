From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 16:11:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1077808260.2677.98.camel@thor.asgaard.local>
References: <1077497593.5960.28.camel@gaston>
	 <200402241657.37382.sgy-lkml@amc.com.au>
	 <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
	 <200402251812.26624.sgy-lkml@amc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200402251812.26624.sgy-lkml@amc.com.au>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Stuart Young <sgy-lkml@amc.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, 2004-02-25 at 08:14, Stuart Young wrote:=20
> On Tue, 24 Feb 2004 07:36 pm, Geert Uytterhoeven wrote:
> >
> > There should be an ANSI escape sequence for resetting the scroll re=
gion.
> > Just send that to the console.
>=20
> Yup there is. It's Esc [r , however this also returns the cursor to t=
he top of=20
> the screen. You can use Esc [s & Esc [u to save and restore the curre=
nt=20
> cursor position, so it's just a matter of putting them around it thus=
:
>  Esc [s Esc [r Esc [u
>=20
> Or with echo (in a bash script - \\'s to escape it from the shell):
>  echo -ne \\033[s\\033[r\\033[u
>=20
> Now there is a problem with this solution: This leaves the logo (and =
any=20
> boot-time drawn graphics in the unscrollable region) on the screen.

Should it? :)


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI dev=
eloper
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaen=
zer
