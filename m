From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: waitforVBlank, how does this even work?
Date: Sat, 05 Mar 2005 09:35:00 +1100
Message-ID: <1109975700.5679.301.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <1109806955.5610.129.camel@gaston>
	 <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com>
	 <1109816602.5610.153.camel@gaston>
	 <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
	 <20050303075559.GA7469@sci.fi> <1109887707.5679.214.camel@gaston>
	 <20050304131858.GA18821@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050304131858.GA18821@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Vladimir Dergachev <volodya@mindspring.com>, Jon Smirl <jonsmirl@gmail.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Fri, 2005-03-04 at 15:18 +0200, Ville Syrj=E4l=E4 wrote:
> On Fri, Mar 04, 2005 at 09:08:27AM +1100, Benjamin Herrenschmidt wrote:
> >=20
> > > > Oh, but I was not suggesting that. I just meant that interrupt ha=
ndling=20
> > > > code is self-contained and can easily serve several consumers.
> > >=20
> > > I'm with you here. And the same should IMHO hold for DMA handling. =
And for=20
> > > memory management of course.
> >=20
> > DMA handling is the main piece of what the DRM does,
>=20
> The actual bits that feed DMA buffers to the hardware are very small. A=
nd=20
> I just meant that like the IRQ code those need to be easily accessible=20
> from other components (fbdev, video capture module etc.)

"Feeding DMA buffers" in what sense ? The buffers are matches with
various functions. For AGP buffers, you have to get into the whole
allocation mecanism, pure PCI DMA isn't always possible on some hosts.

Also, those buffers are what ? Data for blits ? textures ? they always
belong to some sort of command, which we want to eventually validate in
a way by the kernel unless you want your client to be root...

No, honestly, I don't see the point in breaking up our current DRM/fbdev
thing.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
