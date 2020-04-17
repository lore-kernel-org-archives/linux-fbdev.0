From: Andrzej Hajda <a.hajda@samsung.com>
Date: Fri, 17 Apr 2020 16:52:49 +0000
Subject: Re: [PATCH 8/8] drm/bridge/sii8620: fix extcon dependency
Message-Id: <8c653a2f-abf1-906e-49d1-b2ab09c99c88@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <CGME20200417155658eucas1p261d88a51a524547e61bfe79d0a29a7f1@eucas1p2.samsung.com>
 <20200417155553.675905-9-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, Jason Gunthorpe <jgg@ziepe.ca>, thellstrom@vmware.com, dsd@laptop.org, Nicolas Pitre <nico@fluxnic.net>, airlied@linux.ie, masahiroy@kernel.org, jfrederich@gmail.com, haojian.zhuang@gmail.com, linux-renesas-soc@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>, kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org, Laurent.pinchart@ideasonboard.com, linux-graphics-maintainer@vmware.com, robert.jarzmik@free.fr, daniel@zonque.org

On 17.04.2020 17:55, Arnd Bergmann wrote:
> Using 'imply' does not work here, it still cause the same build
> failure:
>
> arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `=
sii8620_remove':
> sil-sii8620.c:(.text+0x1b8): undefined reference to `extcon_unregister_no=
tifier'
> arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `=
sii8620_probe':
> sil-sii8620.c:(.text+0x27e8): undefined reference to `extcon_find_edev_by=
_node'
> arm-linux-gnueabi-ld: sil-sii8620.c:(.text+0x2870): undefined reference t=
o `extcon_register_notifier'
> arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `=
sii8620_extcon_work':
> sil-sii8620.c:(.text+0x2908): undefined reference to `extcon_get_state'
>
> Now that the framebuffer configuration is cleaned up, we can use the
> usual 'depends on EXTCON || !EXTCON' trick.
>
> Fixes: 7a109673899b ("drm/bridge/sii8620: add Kconfig dependency on extco=
n")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for taking care of it.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

=C2=A0--
Regards
Andrzej


> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index aaed2347ace9..29c837625f03 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -90,7 +90,7 @@ config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
>  	select DRM_KMS_HELPER
> -	imply EXTCON
> +	depends on EXTCON || !EXTCON
>  	depends on RC_CORE || !RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
