From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 19 Dec 2017 08:51:25 +0000
Subject: Re: [PATCH V4 21/26] backlight: deprecate pci_get_bus_and_slot()
Message-Id: <20171219085125.55qsifnhh7u57ucv@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Tue, 19 Dec 2017, Sinan Kaya wrote:

> pci_get_bus_and_slot() is restrictive such that it assumes domain=3D0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
>=20
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
>=20
> Hard-coding the domain as 0.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/apple_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

--=20
Lee Jones
Linaro Services Technical Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
