From: Thibaut VARENE <varenet@esiee.fr>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 14:34:27 +0100
Message-ID: <20050314133427.56F31365905@mail.esiee.fr>
References: <Pine.LNX.4.62.0503141425000.4784@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DApiM-0000yj-53
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:34:34 -0800
Received: from mail.esiee.fr ([147.215.1.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DApiL-0006In-IO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:34:33 -0800
In-Reply-To: <Pine.LNX.4.62.0503141425000.4784@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <T-Bone@parisc-linux.org>, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

-------------------
> On Mon, 14 Mar 2005, Paul Mundt wrote:
> > On Mon, Mar 14, 2005 at 08:15:13PM +0800, Antonino A. Daplas
wrote:
> > > 3. You can use pci_resource_len()/pci_resource_start() instead
of
> > >=20
> > > +	info->fix.mmio_start =3D pdev->resource[1].start;
> > > +	info->fix.mmio_len =3D pdev->resource[1].end -
pdev->resource[1].start;
>=20
> +1?
>=20
> > > +	info->fix.smem_start =3D pdev->resource[0].start;
> > > +	info->fix.smem_len =3D pdev->resource[0].end -
pdev->resource[0].start;
>=20
> +1?
>=20
> > > +
> > >=20
> > No, the pdev here refers to a platform device, not a pci device.
> >=20
> > While the pci_resource_xxx() routines would still technically do
the
> > right thing, this is purely coincidental.
>=20
> Nah, they would work better here, since they do include the +1 ;-)

Good point. Actually that's a bad thing we did on our platform: we
didn't add the '-1' to the platform device ranges, so there was no
need for the '+1'.

I guess it's The Good Thing to do to add a '+1' here, I'll take care
of changing our platform specific bits to match this.

Thanks for pointing that out.

Let me know if I should resubmit the patch.

Thibaut VARENE


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
