From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 15:58:07 -0500
Message-ID: <a728f9f90503161258181977fa@mail.gmail.com>
References: <1110784327.5787.288.camel@gaston>
	<1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316200808.GB6651@sci.fi>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Wed, 16 Mar 2005 22:08:08 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrot=
e:
> On Wed, Mar 16, 2005 at 02:09:18PM +1100, Benjamin Herrenschmidt wrote:
> >
> > > It's ugly, but that's not the point. The point is that all deployed
> > > versions of X (and even current X.org CVS head still, in fact) make t=
his
> > > assumption.
> >
> > Oh, that's fine and that's not a problem. I will only repaint the
> > framebuffer on bit depth or line lenght changes. I'm trying to talk
> > about the _future_ here. That is support for dual head at the fbdev
> > level and other niceties.
>=20
> I don't see the current system slowly evolving into some superb future
> system with an in kernel memory manager. The current APIs just have too
> many limitations. I think the memory manager must be the foundation of
> everything and after it's in place the fbdev API should be able to use it=
.
> The only change to simple fbdev apps would be that they can't get access
> to any offscreen memory as they do now. Something like DirectFB would nee=
d
> to change to accomodate the new system but I don't see that as a problem.
>=20
> I think the best short term option for radeonfb is to simply follow
> matroxfb's example and cut the memory into two parts. The cutoff point
> should probably be configurable via a module option.
>=20

if we are going to go through the trouble to do it at all why not do
it "the right way"?  We could also work on updating the fbdev drivers
to the "new version" out of tree until they have stabilized and then
we can work on merging them into the kernel.  that should give
GUI/driver developers time to adapt their respecitve projects.

Alex

> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
