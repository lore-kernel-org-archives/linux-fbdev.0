From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 02:08:35 +0200
Message-ID: <20050314000835.GA20393@sci.fi>
References: <1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston> <9e473391050313081937cde207@mail.gmail.com> <1110750553.5787.155.camel@gaston> <9e47339105031314101c89e50e@mail.gmail.com> <1110752401.19810.177.camel@gaston> <9e47339105031315002a444f00@mail.gmail.com> <20050313232735.GA19781@sci.fi> <1110757699.5787.196.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110757699.5787.196.camel@gaston>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Mon, Mar 14, 2005 at 10:48:19AM +1100, Benjamin Herrenschmidt wrote:
>=20
> > > That shouldn't matter the page brought in would be for a speculativ=
e
> > > read and never accessed. It should just fall out of the cache and n=
ot
> > > be written back. There is only one cachable mapping. In this model
> > > writes are always followed by a flush before telling the GPU to acc=
ess
> > > the memory that has just been written.
> >=20
> > What about this scenario?
> >=20
> > Speculative read -> AGP master writes new data -> CPU has invalid dat=
a in=20
> > cache :(
>=20
> First, we must be very careful with AGP master writes. I don't know if
> we do a lot of them currently, but I know a collection of north bridges
> that do not support them.

I don't think "normal" drivers do them at all. I did experiment with=20
DirectFB at one point and had it place all offscreen surfaces to AGP=20
memory. It worked really well on my hardware (G400 + VIA KT133=20
northbridge). I also tried it with PCI transfers and that too worked but=20
was naturally slower. I'd like to make DirectFB use AGP again since 32MB=20
of video memory isn't always enough.

> (Which is interesting, that means that if we want to copy something out
> of video memory, we can't write it to AGP memory and then read it, we
> need to actually do the blit from the CPU, good to know for our memory
> manager. That also means that we have a problem if the video memory
> isn't entirely accessible by the CPU ...)

What about PCI master writes? Are there bridges that don't support even=20
those?

> That's something we should probably think about doing properly: Have a
> list of AGP "issues" (errata ?) bits that are communicated by the AGP
> host driver to the DRM.
>=20
> At least all the early Apple AGP bridges don't do writes, and I remembe=
r
> we have trouble with a few x86 ones as well. There are also issues when
> a single AGP burst crosses a page boundary, and other things like that.

:(

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
