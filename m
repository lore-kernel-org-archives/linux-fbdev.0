From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: waitforVBlank, how does this even work?
Date: Fri, 4 Mar 2005 15:18:58 +0200
Message-ID: <20050304131858.GA18821@sci.fi>
References: <9e473391050301215019081bce@mail.gmail.com> <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com> <1109806955.5610.129.camel@gaston> <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com> <1109816602.5610.153.camel@gaston> <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com> <20050303075559.GA7469@sci.fi> <1109887707.5679.214.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1109887707.5679.214.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vladimir Dergachev <volodya@mindspring.com>, Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Fri, Mar 04, 2005 at 09:08:27AM +1100, Benjamin Herrenschmidt wrote:
>=20
> > > Oh, but I was not suggesting that. I just meant that interrupt hand=
ling=20
> > > code is self-contained and can easily serve several consumers.
> >=20
> > I'm with you here. And the same should IMHO hold for DMA handling. An=
d for=20
> > memory management of course.
>=20
> DMA handling is the main piece of what the DRM does,

The actual bits that feed DMA buffers to the hardware are very small. And=
=20
I just meant that like the IRQ code those need to be easily accessible=20
from other components (fbdev, video capture module etc.)

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
