From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 01:27:35 +0200
Message-ID: <20050313232735.GA19781@sci.fi>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi>
	<1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	<1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <9e47339105031315002a444f00@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, Mar 13, 2005 at 06:00:01PM -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 09:20:01 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Though the flushes may be fast if there is no actual hit in the cache=
, I
> > agree. Again, that should be benched.
> >=20
> > In fact, i would _love_ to be able to mark AGP memory as cacheable on
> > ppc, even if there is no performance benefit in the end. The issue is
> > that currently, we end up having both a cacheable and a non-cacheable
> > mapping for those pages (the kernel linear mapping still maps those
> > pages cacheable, and it's almost impossible to get rid of that unless
> > you are prepared to disable the large pages mapping of kernel space o=
r
> > the BATs on ppc32, which would harm kernel performances significantly=
).
> >=20
> > It works, but it's illegal. That means that the CPU might well specul=
ate
> > a load from one of these pages in kernel-land just because it happens=
 to
> > be next to a page where you are iterating an array, and may then brin=
g a
> > bit in the cache from that page.
>=20
> That shouldn't matter the page brought in would be for a speculative
> read and never accessed. It should just fall out of the cache and not
> be written back. There is only one cachable mapping. In this model
> writes are always followed by a flush before telling the GPU to access
> the memory that has just been written.

What about this scenario?

Speculative read -> AGP master writes new data -> CPU has invalid data in=
=20
cache :(

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
