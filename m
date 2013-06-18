From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2013 14:53:14 +0000
Subject: Re: [PATCH 2/2] i915: i915_gem: Print a size_t with %z
Message-Id: <CAMuHMdU9tJLDFsDi3AQ49AyJ5=dh_Cer4YUYQHZnbt=WLVNTFA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371561988-30989-1-git-send-email-fabio.estevam@freescale.com>
	<1371561988-30989-2-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371561988-30989-2-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Fabio Estevam <festevam@gmail.com>

On Tue, Jun 18, 2013 at 3:26 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> drivers/gpu/drm/i915/i915_gem.c:3129:3: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' [-Wformat]

> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -3126,7 +3126,7 @@ i915_gem_object_bind_to_gtt(struct drm_i915_gem_object *obj,
>          * before evicting everything in a vain attempt to find space.
>          */
>         if (obj->base.size > gtt_max) {
> -               DRM_ERROR("Attempting to bind an object larger than the aperture: object=%zd > %s aperture=%ld\n",
> +               DRM_ERROR("Attempting to bind an object larger than the aperture: object=%zd > %s aperture=%zd\n",

size_t is unsigned, so you better change it to %zu.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
