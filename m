From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:30:01 +1100
Message-ID: <1111015801.15509.62.camel@gaston>
References: <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
	<20050316210812.GA19937@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316210812.GA19937@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

On Wed, 2005-03-16 at 23:08 +0200, Ville Syrj=E4l=E4 wrote:
> On Wed, Mar 16, 2005 at 03:58:07PM -0500, Alex Deucher wrote:

> I haven't seen anyone coming forward with a design/code for the memory=20
> manager.
>=20
> In the meantime I'm assuming that people might want to make some use of=
=20
> their dualhead cards...

Are you aware that with the current fbdev API, there will simply be no
working use of dual head ? As soon as somebody will try to do 2
different things on the 2 heads, it will either lockup due to lack of
engine arbitration, or have wrong endianness, or whatever ...

Ben.
