From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 02:56:13 +0200
Message-ID: <20050314005613.GA21434@sci.fi>
References: <20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<16948.56755.114690.200854@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <16948.56755.114690.200854@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, dri-devel@lists.sourceforge.net

On Mon, Mar 14, 2005 at 11:41:23AM +1100, Paul Mackerras wrote:
> Jon Smirl writes:
>=20
> > > It works, but it's illegal. That means that the CPU might well spec=
ulate
> > > a load from one of these pages in kernel-land just because it happe=
ns to
> > > be next to a page where you are iterating an array, and may then br=
ing a
> > > bit in the cache from that page.
> >=20
> > That shouldn't matter the page brought in would be for a speculative
> > read and never accessed. It should just fall out of the cache and not
> > be written back. There is only one cachable mapping. In this model
> > writes are always followed by a flush before telling the GPU to acces=
s
> > the memory that has just been written.
>=20
> That would be fine, but it would mean making sure that every time any
> code in the DRI, DRM or X server writes to the AGP memory, it does the
> flush as well.  Sounds like a maintenance nightmare to me...

It should be the responsibility of the memory manager. If anything wants=20
to access the memory it would call lock() and when it's done with the=20
memory it calls unlock(). That's exactly how DirectFB's memory manager=20
works.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
