From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2019 07:21:32 +0000
Subject: Re: [PATCH v2] Staging: fbtft: Fix GPIO handling
Message-Id: <20190725072132.GA18714@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715143003.12819-1-nsaenzjulienne@suse.de>
 <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
 <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
 <75ada52f-afa1-08bc-d0ce-966fc1110e70@jaseg.net>
In-Reply-To: <75ada52f-afa1-08bc-d0ce-966fc1110e70@jaseg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, dri-devel@lists.freedesktop.org, bhanusreemahesh@gmail.com, Phil Reid <preid@electromag.com.au>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

On Wed, Jul 17, 2019 at 11:41:37PM +0900, Jan Sebastian G=F6tte wrote:
> Commit c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
> interface") breaks GPIO handling. In several places, checks to only set
> a GPIO if it was configured ended up backwards.
> I have tested this fix. The fixed driver works with a ili9486
> display connected to a raspberry pi via SPI.
>=20
> Fixes: commit c440eee1a7a1d ("Staging: fbtft: Switch to the gpio descript=
or interface")
> Tested-by: Jan Sebastian G=F6tte <linux@jaseg.net>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Jan Sebastian G=F6tte <linux@jaseg.net>
> ---

Can this go on top of Phil's patches?  Or does it replace it?

I can't figure out what to do here, sorry.

thanks,

greg k-h
