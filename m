From: Felipe Balbi <balbi@kernel.org>
Date: Fri, 01 Feb 2019 13:19:41 +0000
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
Message-Id: <87d0obodci.fsf@linux.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de>
In-Reply-To: <20190201084801.10983-13-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> writes:

> dma_map_single already transfers ownership to the device.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do you want me to take the USB bits or will you take the entire series?
In case you're taking the entire series:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

> ---
>  drivers/usb/gadget/udc/fotg210-udc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/ud=
c/fotg210-udc.c
> index bc6abaea907d..fe9cf415f2f1 100644
> --- a/drivers/usb/gadget/udc/fotg210-udc.c
> +++ b/drivers/usb/gadget/udc/fotg210-udc.c
> @@ -356,10 +356,6 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
>  		return;
>  	}
>=20=20
> -	dma_sync_single_for_device(NULL, d, length,
> -				   ep->dir_in ? DMA_TO_DEVICE :
> -					DMA_FROM_DEVICE);
> -
>  	fotg210_enable_dma(ep, d, length);
>=20=20
>  	/* check if dma is done */
> --=20
> 2.20.1
>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxUR24ACgkQzL64meEa
mQahHA//UqW4f00GsiqzttL+A0YT71T+D9qtJhSfF7M0knMpZzdyOqcirQVm3TRT
tpK0gC37IQGcT8NcrX75EtASdv/SBDJKhi5H1bCOEc5H00YxYUvujAdut+D25tJi
SzfffbgIDcmkdit869qdzHmH565AGYZY6RG0lPoIS+7o1EGlO4AMM7RfF0y84VmY
46M4Ch6WtjDVuFAEUhHdZi9Q4hXxT46Kz6gKyzB/aB5h1OGxeHpUl5HUkF0jZmts
E6m3SZb/vUrfQINJ69erIJH4qqap0TbQ509i0M1cx9X1TYiI/ou4C8bSk/8895K0
Js67kpVD/OXAyTmf/nVl4rtkhuDugyfEC+2bGUohpICCVd9ubg85B/1Yi/qQafYs
sOt7bISdGgLiiSAxw9FWtVlezCW/8xuyC4hn0knkoAd9iIOO1LhfdNvfz0PPaVeW
JnmCbx6syBAwlaEFem/M4uxp0Lq02WggiTNtTTUJw78N/MAl3CzDyyvRF0K1VpIR
eGT71Gcrge3Utw8G8Tm0rzlBJntsXh7PLD63ga6nwirPxtq3ScPh3yjjdODRjc62
T4dch1AT9BSKqqbFeQuMaeEV5ml3SJF3+DvIQ3LRz22lP65oSPHYvmdWHYOXW++W
FGuEo7SIciykLAFxBDq4MjuIqn5uMMERmOqGGElHqdZsQE+0SVg=
=byNX
-----END PGP SIGNATURE-----
--=-=-=--
