From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 12:02:18 +1100
Message-ID: <1110762138.5787.206.camel@gaston>
References: <20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<20050313232735.GA19781@sci.fi> <1110757699.5787.196.camel@gaston>
	<9e47339105031316254524f72@mail.gmail.com>
	<20050314003918.GA20886@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050314003918.GA20886@sci.fi>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Mon, 2005-03-14 at 02:39 +0200, Ville Syrj=E4l=E4 wrote:
> On Sun, Mar 13, 2005 at 07:25:15PM -0500, Jon Smirl wrote:
> > On Mon, 14 Mar 2005 10:48:19 +1100, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > >=20
> > > > > That shouldn't matter the page brought in would be for a specul=
ative
> > > > > read and never accessed. It should just fall out of the cache a=
nd not
> > > > > be written back. There is only one cachable mapping. In this mo=
del
> > > > > writes are always followed by a flush before telling the GPU to=
 access
> > > > > the memory that has just been written.
> > > >
> > > > What about this scenario?
> > > >
> > > > Speculative read -> AGP master writes new data -> CPU has invalid=
 data in
> > > > cache :(
> > >=20
> >=20
> > You need to reverse the cache flush process if you are going to read
> > data written by the GPU.
> >=20
> > 1) Make sure GPU is finished writing
> > 2) flush your cache
> > 3) read AGP memory like normal RAM.
>=20
> Oh right. The CPU shouldn't write back the cached data since it hasn't=20
> changed.
>=20
> I think you'd also need the GPU to issue an AGP flush command between=20
> steps 1 and 2.

Not exactly, it could wait before 3) in fact. Step 2 will just
"invalidate" the cache.

Ben.
