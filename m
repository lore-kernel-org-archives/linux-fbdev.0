From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: waitforVBlank, how does this even work?
Date: Sat, 5 Mar 2005 08:30:31 +0200
Message-ID: <20050305063031.GA5776@sci.fi>
References: <9e473391050301215019081bce@mail.gmail.com> <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com> <1109806955.5610.129.camel@gaston> <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com> <1109816602.5610.153.camel@gaston> <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com> <20050303075559.GA7469@sci.fi> <1109887707.5679.214.camel@gaston> <20050304131858.GA18821@sci.fi> <1109975700.5679.301.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1109975700.5679.301.camel@gaston>
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
Cc: Vladimir Dergachev <volodya@mindspring.com>, Jon Smirl <jonsmirl@gmail.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Sat, Mar 05, 2005 at 09:35:00AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-03-04 at 15:18 +0200, Ville Syrj=E4l=E4 wrote:
> > On Fri, Mar 04, 2005 at 09:08:27AM +1100, Benjamin Herrenschmidt wrot=
e:
> > >=20
> > > > > Oh, but I was not suggesting that. I just meant that interrupt =
handling=20
> > > > > code is self-contained and can easily serve several consumers.
> > > >=20
> > > > I'm with you here. And the same should IMHO hold for DMA handling=
. And for=20
> > > > memory management of course.
> > >=20
> > > DMA handling is the main piece of what the DRM does,
> >=20
> > The actual bits that feed DMA buffers to the hardware are very small.=
 And=20
> > I just meant that like the IRQ code those need to be easily accessibl=
e=20
> > from other components (fbdev, video capture module etc.)
>=20
> "Feeding DMA buffers" in what sense ? The buffers are matches with
> various functions. For AGP buffers, you have to get into the whole
> allocation mecanism, pure PCI DMA isn't always possible on some hosts.

Allocating buffers should IMO belong to the memory management part.

If DMA isn't possible then I suppose the comammands/data would have to fe=
d=20
via MMIO. But that is a detail only the DMA component would have to know.

> Also, those buffers are what ? Data for blits ? textures ? they always
> belong to some sort of command, which we want to eventually validate in
> a way by the kernel unless you want your client to be root...

Usually the buffers are series of commands. And they don't need to=20
validated when they come from the kernel. Validating buffers from=20
userspace is done by the DRM.

> No, honestly, I don't see the point in breaking up our current DRM/fbde=
v
> thing.

From the userspace perspective nothing should change.


For the memory management I have some rough ideas but I'm not an expert=20
here so let me know if I'm talking out of my ass...

The GART (be it AGP, PCI or some other mechanism) should be only used by=20
the memory management part to dynamically map required bits of system RAM=
=20
for the graphics hardware to access. Clients of the memory management=20
system should only have to ask thing like "give me a buffer of size x wit=
h=20
priority y". Those buffers could then exist in system or video memory and=
=20
the memory manager could actaully dynamically move them around without th=
e=20
clients even knowing about it. At one point the buffer could be in video=20
memory and in system memory the next. If the hardware can render to syste=
m=20
RAM then it could be totally transparent to the user. With hardware that=20
can't render to system RAM I suppose the best idea would be to always mov=
e=20
the buffers to system RAM when software access is required. That way the=20
software could lock the buffer for any period of time without disturbing=20
the memory managers work.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
