From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 23:08:12 +0200
Message-ID: <20050316210812.GA19937@sci.fi>
References: <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost>
	<20050315060138.GA13064@sci.fi> <4236C770.8020101@hispeed.ch>
	<1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <a728f9f90503161258181977fa@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, dri-devel@lists.sourceforge.net

On Wed, Mar 16, 2005 at 03:58:07PM -0500, Alex Deucher wrote:
> On Wed, 16 Mar 2005 22:08:08 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> =
wrote:
> > On Wed, Mar 16, 2005 at 02:09:18PM +1100, Benjamin Herrenschmidt wrot=
e:
> > >
> > > > It's ugly, but that's not the point. The point is that all deploy=
ed
> > > > versions of X (and even current X.org CVS head still, in fact) ma=
ke this
> > > > assumption.
> > >
> > > Oh, that's fine and that's not a problem. I will only repaint the
> > > framebuffer on bit depth or line lenght changes. I'm trying to talk
> > > about the _future_ here. That is support for dual head at the fbdev
> > > level and other niceties.
> >=20
> > I don't see the current system slowly evolving into some superb futur=
e
> > system with an in kernel memory manager. The current APIs just have t=
oo
> > many limitations. I think the memory manager must be the foundation o=
f
> > everything and after it's in place the fbdev API should be able to us=
e it.
> > The only change to simple fbdev apps would be that they can't get acc=
ess
> > to any offscreen memory as they do now. Something like DirectFB would=
 need
> > to change to accomodate the new system but I don't see that as a prob=
lem.
> >=20
> > I think the best short term option for radeonfb is to simply follow
> > matroxfb's example and cut the memory into two parts. The cutoff poin=
t
> > should probably be configurable via a module option.
> >=20
>=20
> if we are going to go through the trouble to do it at all why not do
> it "the right way"?

I haven't seen anyone coming forward with a design/code for the memory=20
manager.

In the meantime I'm assuming that people might want to make some use of=20
their dualhead cards...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
