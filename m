From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 03 Jul 2014 20:47:37 +0000
Subject: Re: [PATCH V2] video: fbdev: matrox: matroxfb_base.c:  Cleaning up a null pointer checks that could 
Message-Id: <alpine.LRH.2.02.1407031646450.19862@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404414974-9676-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404414974-9676-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Alexandru Juncu <alexj@rosedu.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

On Thu, 3 Jul 2014, Rickard Strandqvist wrote:

> Removal of null pointer checks that could never happen
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index 7116c53..cd9dc88 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1973,7 +1973,7 @@ static void matroxfb_register_device(struct matrox_fb_info* minfo) {
>  	for (drv = matroxfb_driver_l(matroxfb_driver_list.next);
>  	     drv != matroxfb_driver_l(&matroxfb_driver_list);
>  	     drv = matroxfb_driver_l(drv->node.next)) {
> -		if (drv && drv->probe) {
> +		if (drv->probe) {
>  			void *p = drv->probe(minfo);
>  			if (p) {
>  				minfo->drivers_data[i] = p;
> -- 
> 1.7.10.4
> 
