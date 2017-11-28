From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 28 Nov 2017 08:13:42 +0000
Subject: Re: [PATCH V3 24/29] backlight: deprecate pci_get_bus_and_slot()
Message-Id: <20171128081342.qvylfa6p5rvqoyxk@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-25-git-send-email-okaya@codeaurora.org>
 <000001d367b8$726bd7f0$574387d0$@gmail.com>
In-Reply-To: <000001d367b8$726bd7f0$574387d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Sinan Kaya' <okaya@codeaurora.org>, linux-pci@vger.kernel.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 'Daniel Thompson' <daniel.thompson@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>, 'open list' <linux-kernel@vger.kernel.org>

On Mon, 27 Nov 2017, Jingoo Han wrote:
> On Monday, November 27, 2017 11:58 AM, Sinan Kaya wrote:
> >=20
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=3D0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
>=20
> I think that this will be useful. I introduced multi domains into
> ARM-based PCIe driver. (e.g. domain 0, and domain 1) So, APIs to choose
> domain will be used later.
>=20
> >=20
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> >=20
> > Hard-coding the domain as 0.
> >=20
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>=20
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

I can't apply this.

It looks like I was missing from the list of addressees.

Please resend v3 with all the Acks you've acquired.

> > ---
> >  drivers/video/backlight/apple_bl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/backlight/apple_bl.c
> > b/drivers/video/backlight/apple_bl.c
> > index d843296..6a34ab9 100644
> > --- a/drivers/video/backlight/apple_bl.c
> > +++ b/drivers/video/backlight/apple_bl.c
> > @@ -143,7 +143,7 @@ static int apple_bl_add(struct acpi_device *dev)
> >  	struct pci_dev *host;
> >  	int intensity;
> >=20
> > -	host =3D pci_get_bus_and_slot(0, 0);
> > +	host =3D pci_get_domain_bus_and_slot(0, 0, 0);
> >=20
> >  	if (!host) {
> >  		pr_err("unable to find PCI host\n");
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
