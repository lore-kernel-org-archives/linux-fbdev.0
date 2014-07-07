From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 07 Jul 2014 08:48:26 +0000
Subject: Re: [Intel-gfx] [PATCH 5/5] drm/i915: Kick out vga console
Message-Id: <20140707084826.GH5821@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401980308-5116-1-git-send-email-daniel.vetter@ffwll.ch>
 <1401980308-5116-5-git-send-email-daniel.vetter@ffwll.ch>
 <1602327.OGkKxHtt2b@grover> <3945293.Jtp4nyZMfX@grover>
 <20140630065955.GD7687@nuc-i3427.alporthouse.com>
In-Reply-To: <20140630065955.GD7687@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>, Ed Tomlinson <edt@aei.ca>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, David Herrmann <dh.herrmann@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Dave Airlie <airlied@linux.ie>

On Mon, Jun 30, 2014 at 07:59:55AM +0100, Chris Wilson wrote:
> On Sat, Jun 28, 2014 at 11:55:19PM -0400, Ed Tomlinson wrote:
> > On Saturday 28 June 2014 15:28:22 Ed Tomlinson wrote:
> > 
> > Resend without html krud which causes list to bounce the message.
> > 
> > > Hi
> > > 
> > > This commit ( a4de05268e674e8ed31df6348269e22d6c6a1803 ) hangs my boot with 3.16-git.  Reverting it lets the boot proceed. 
> > > 
> > > I have an i7 with a built-in i915 and an pcie r7 260x.  The R7 is the primary console.  The i915 is initialized
> > > but does not have a physical display attached.
> > > 
> > > With the patch applied the boot stops at the messages:
> > > 
> > > [drm] Memory usable by graphics device = 2048M
> > > [drm] Replacing VGA console driver
> 
> The issue looks like that we are ripping out the radeon fb_con whilst it
> is active and that upsets everyone. In which case, I think the
> compromise is:
> 
> 
> diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
> index 5f44581..4915f1d 100644
> --- a/drivers/gpu/drm/i915/i915_dma.c
> +++ b/drivers/gpu/drm/i915/i915_dma.c
> @@ -1439,18 +1439,20 @@ static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
>  #else
>  static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
>  {
> -       int ret;
> +       int ret = 0;
>  
>         DRM_INFO("Replacing VGA console driver\n");
>  
>         console_lock();
> -       ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
> -       if (ret = 0) {
> -               ret = do_unregister_con_driver(&vga_con);
> -
> -               /* Ignore "already unregistered". */
> -               if (ret = -ENODEV)
> -                       ret = 0;
> +       if (con_is_bound(&vga_con)) {
> +               ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
> +               if (ret = 0) {
> +                       ret = do_unregister_con_driver(&vga_con);

Hm, we should only conditionalize the take_over_console - unregistering
vga_con is kinda the point to make sure it's gone for real. Ed, can you
please retest with the if (con_is_bound) check just for the
do_take_over_console call?

Still puzzled wtf is going on here since as David says this should be a
no-op.

Thanks, Daniel
> +
> +                       /* Ignore "already unregistered". */
> +                       if (ret = -ENODEV)
> +                               ret = 0;
> +               }
>         }
>         console_unlock();
> 
> -Chris
> 
> -- 
> Chris Wilson, Intel Open Source Technology Centre
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
