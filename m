From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 02:39:18 +0200
Message-ID: <20050314003918.GA20886@sci.fi>
References: <20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston> <9e473391050313081937cde207@mail.gmail.com> <1110750553.5787.155.camel@gaston> <9e47339105031314101c89e50e@mail.gmail.com> <1110752401.19810.177.camel@gaston> <9e47339105031315002a444f00@mail.gmail.com> <20050313232735.GA19781@sci.fi> <1110757699.5787.196.camel@gaston> <9e47339105031316254524f72@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <9e47339105031316254524f72@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Sun, Mar 13, 2005 at 07:25:15PM -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 10:48:19 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >=20
> > > > That shouldn't matter the page brought in would be for a speculat=
ive
> > > > read and never accessed. It should just fall out of the cache and=
 not
> > > > be written back. There is only one cachable mapping. In this mode=
l
> > > > writes are always followed by a flush before telling the GPU to a=
ccess
> > > > the memory that has just been written.
> > >
> > > What about this scenario?
> > >
> > > Speculative read -> AGP master writes new data -> CPU has invalid d=
ata in
> > > cache :(
> >=20
>=20
> You need to reverse the cache flush process if you are going to read
> data written by the GPU.
>=20
> 1) Make sure GPU is finished writing
> 2) flush your cache
> 3) read AGP memory like normal RAM.

Oh right. The CPU shouldn't write back the cached data since it hasn't=20
changed.

I think you'd also need the GPU to issue an AGP flush command between=20
steps 1 and 2.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
