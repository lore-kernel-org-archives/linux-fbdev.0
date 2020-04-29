From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 29 Apr 2020 19:28:40 +0000
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <20200429192840.GA1022@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
In-Reply-To: <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, kbuild test robot <lkp@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej

On Wed, Apr 29, 2020 at 12:48:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> powerpc allyesconfig fails like this:
> 
> drivers/video/fbdev/controlfb.c: In function 'controlfb_mmap':
> drivers/video/fbdev/controlfb.c:756:23: error: implicit declaration of function 'pgprot_cached_wthru'; did you mean 'pgprot_cached'? [-Werror=implicit-function-declaration]
>   756 |   vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
>       |                       ^~~~~~~~~~~~~~~~~~~
>       |                       pgprot_cached
> drivers/video/fbdev/controlfb.c:756:23: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
> 
> Fix it by adding missing PPC32 dependency.
> 
> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I've updated my build script to include a few popwerpc 32 bit configs.
Patch looked correct, and my builds was OK.
So applied to drm-misc-next and pushed out.

If my prodding of Christoph will result in anything only time will tell.

	Sam

> ---
> v2: fix implicit btext_update_display() function declaration error
> 
>  drivers/video/fbdev/controlfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/controlfb.c
> =================================> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -55,7 +55,7 @@
>  #include "macmodes.h"
>  #include "controlfb.h"
>  
> -#ifndef CONFIG_PPC_PMAC
> +#if !defined(CONFIG_PPC_PMAC) || !defined(CONFIG_PPC32)
>  #define invalid_vram_cache(addr)
>  #undef in_8
>  #undef out_8
