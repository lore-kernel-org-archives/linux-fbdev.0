From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:26:57 +1100
Message-ID: <1111015617.15509.56.camel@gaston>
References: <1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston>  <20050316200808.GB6651@sci.fi>
	<1111005770.5535.63.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1111005770.5535.63.camel@localhost>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Wed, 2005-03-16 at 15:42 -0500, Michel D=E4nzer wrote:
> On Wed, 2005-03-16 at 22:08 +0200, Ville Syrj=E4l=E4 wrote:
> >=20
> > I don't see the current system slowly evolving into some superb futur=
e=20
> > system with an in kernel memory manager. The current APIs just have t=
oo=20
> > many limitations. I think the memory manager must be the foundation o=
f=20
> > everything and after it's in place the fbdev API should be able to us=
e it.=20
> > The only change to simple fbdev apps would be that they can't get acc=
ess=20
> > to any offscreen memory as they do now. Something like DirectFB would=
 need=20
> > to change to accomodate the new system but I don't see that as a prob=
lem.
>=20
> I agree on this.

Ok, ok, I'll do crap since that's what everybody wants.

Ben.
