From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 19:47:14 +0200
Message-ID: <20050313174714.GA15871@sci.fi>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston> <9e473391050313081937cde207@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <9e473391050313081937cde207@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, Mar 13, 2005 at 11:19:35AM -0500, Jon Smirl wrote:
> On Sun, 13 Mar 2005 23:04:59 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >=20
> > > AGP as it's currently used is pretty much pointless for software fa=
llbacks
> > > since reading from AGP memory is nearly as slow as reading from vid=
eo
> > > memory.
> >=20
> > Hrm.. I wouldn't expect _that_ slow. It's uncacheable, right, but sti=
ll
> > on a faster bus. Especially if we use it the way we do on ppc where w=
e
> > actually map the RAM pages directly instead of having processes go
> > through the GART.
>=20
> I asked at the Xdev conference if there were page table tricks that
> would work for accessing GART memory.  Everybody said no but I'm still
> wondering if there are any.
>=20
> For example the ppc has an instruction for flushing specific pages
> from cache, unlike the x86 where you can only flush everything.
>=20
> So on the ppc you could leave the GART memory mapped normally and
> cached. Do all of your fallback calculations, then flush the address
> range from cache. Now tell the GPU to go use it.
>=20
> Can't GART memory be normally cached RAM as long as we flush the cache
> before telling the GPU to use it?
>=20
> If you are doing fallback calculations in a 6MB buffer that is 1,500
> pages. Accessing all of this effectively flushes the data cache. Once
> you are done with it you probably don't want those pages in the cache
> anyway.

I don't understand why we have "GART memory" anyway. It's just main memor=
y=20
and I don't see any point going through the GART to access it with the=20
CPU. Only the graphics card needs to use the GART.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
