From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 09:29:22 -0500
Message-ID: <9e47339105031506292b1976b0@mail.gmail.com>
References: <1110696189.5787.100.camel@gaston>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<1110869983.29138.88.camel@gaston> <20050315140005.GB16051@sci.fi>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315140005.GB16051@sci.fi>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Tue, 15 Mar 2005 16:00:05 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrot=
e:
> DirectFB has it's own asbitration mechanism. It doesn't support using
> multiple framebuffer devices at the same time. For that to work DirectFB
> would just have to know if some of the framebuffer devices are actually
> different outputs of the same card so that it could associate both with
> the same lock and accelerator state.
>=20
> With the current system I don't see much chance of using accelerated fbco=
n
> on one head and accelerated DirectFB (or something else) on the other.

It looks to be like there needs to be new rules for framebuffer
access. X needs to change, why can't DirectFB change too? This is why
we have so much conflict in graphics. Everyone thinks they completely
own the hardware and can do whatever they want with it. It's obvious
to me, if we add universal aribtration everyone has to change and
follow the new rules.

Aonther approach would be to just say you have to choose to run one of
X, DirectFB, FBUI, XGL and you can't switch between them. Other than
developers I don't know if anyone really runs more than one of these
at a time.

Here's another one:
http://home.comcast.net/~plinius/fbui.html

--=20
Jon Smirl
jonsmirl@gmail.com
