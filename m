From: Ed Tomlinson <edt@aei.ca>
Date: Tue, 08 Jul 2014 02:53:16 +0000
Subject: Re: [Intel-gfx] [PATCH 5/5] drm/i915: Kick out vga console
Message-Id: <2319392.n3fnJUhemF@grover>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401980308-5116-1-git-send-email-daniel.vetter@ffwll.ch>
 <1974170.pJAPFfvtjC@grover> <20140707122654.GQ5821@phenom.ffwll.local>
In-Reply-To: <20140707122654.GQ5821@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, David Herrmann <dh.herrmann@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Dave Airlie <airlied@linux.ie>

Hi Daniel,

The patch below also works.  You can use my Tested By for it.

Thanks
Ed Tomlinson <edtoml@gmail.com>

PS. I _really_ need to get a serial console working on my i7 box.

On Monday 07 July 2014 14:26:54 Daniel Vetter wrote:
> On Mon, Jul 07, 2014 at 06:45:49AM -0400, Ed Tomlinson wrote:
> > Daniel,
> > 
> > I am not quite sure I understand what you want me to test?
> > Do you want me to try it without:
> > 
> > > > +               if (ret = 0) {
> > > > +                       ret = do_unregister_con_driver(&vga_con);
> 
> Below the diff of what I mean.
> -Daniel
> 
> 
> diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
> index 5e583a1838f8..bd8517151479 100644
> --- a/drivers/gpu/drm/i915/i915_dma.c
> +++ b/drivers/gpu/drm/i915/i915_dma.c
> @@ -1466,12 +1466,13 @@ static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
>  #else
>  static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	DRM_INFO("Replacing VGA console driver\n");
>  
>  	console_lock();
> -	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
> +	if (con_is_bound(&vga_con))
> +		ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
>  	if (ret = 0) {
>  		ret = do_unregister_con_driver(&vga_con);
>  
> 

