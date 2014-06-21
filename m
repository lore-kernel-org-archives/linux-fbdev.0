From: Joe Perches <joe@perches.com>
Date: Sat, 21 Jun 2014 13:58:36 +0000
Subject: Re: [PATCH] video: fbdev: skeletonfb.c:  Adding code to managing allocation error
Message-Id: <1403359116.4076.44.camel@joe-AO725>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403356646-29443-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1403356646-29443-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

(Adding Geert, who probably wrote most of this
 and likely might have forgotten all of it)

On Sat, 2014-06-21 at 15:17 +0200, Rickard Strandqvist wrote:
> Adding missing code for managing a memory allocation error that may occur.
> 
> This was partly found using a static code analysis program called cppcheck.

skeletonfb.c is not meant to be compiled.
It's a sample driver template.

Those /* goto error path */ lines are for
driver writers that use this to figure out
what to do.

The second return is not correct as it would
not free the first alloc'd block.

> diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
[]
> @@ -692,6 +692,7 @@ static int xxxfb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>  
>      if (!info) {
>  	    /* goto error path */
> +	    return -ENOMEM;
>      }
>  
>      par = info->par;
> @@ -746,6 +747,7 @@ static int xxxfb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>      info->pixmap.addr = kmalloc(PIXMAP_SIZE, GFP_KERNEL);
>      if (!info->pixmap.addr) {
>  	    /* goto error */
> +	    return -ENOMEM;
>      }
>  
>      info->pixmap.size = PIXMAP_SIZE;
> 


