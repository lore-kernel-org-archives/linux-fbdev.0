From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 13:00:36 +1100
Message-ID: <1111024836.15509.129.camel@gaston>
References: <20050315060138.GA13064@sci.fi> <4236C770.8020101@hispeed.ch>
	<1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
	<20050316210812.GA19937@sci.fi> <1111015801.15509.62.camel@gaston>
	<20050317004713.GB8081@sci.fi> <1111021978.15510.97.camel@gaston>
	<20050317012503.GA20844@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050317012503.GA20844@sci.fi>
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

On Thu, 2005-03-17 at 03:25 +0200, Ville Syrj=E4l=E4 wrote:
> On Thu, Mar 17, 2005 at 12:12:58PM +1100, Benjamin Herrenschmidt wrote:
> >=20
> > > I understand you can't have userspace program the accelerator while=
=20
> > > someone else is doing the same thing. Oh and I now understand that =
the=20
> > > same really applies to direct framebuffer access due to the swapper=
. =20
> >=20
> > And you can't have someone program the accelerator while somebody doe=
s
> > direct access neither. It's basically all exclusive.
>=20
> I haven't seen that happen on any hardware I own. Matrox specs explicit=
ly=20
> mention that there is no need to synchronize accelerator and direct=20
> framebuffer access.

You are lucky then :)

Ben.
