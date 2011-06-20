From: David Rientjes <rientjes@google.com>
Date: Mon, 20 Jun 2011 23:03:37 +0000
Subject: Re: Regression in panic
Message-Id: <alpine.DEB.2.00.1106201601220.15259@chino.kir.corp.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTingstCoWk0H20nN1J7t3H=mndSdnL2YpeW2R46fhL2kpA@mail.gmail.com>
In-Reply-To: <BANLkTingstCoWk0H20nN1J7t3H=mndSdnL2YpeW2R46fhL2kpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mandeep Singh Baines <msb@chromium.org>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olof Johansson <olofj@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Chris Fowler <cfowler@opsdc.com>

On Mon, 20 Jun 2011, Mandeep Singh Baines wrote:

> Hi Dave,
> 
> I think this change is causing a regression I'm seeing in panic.
> Before this change, I'd get a
> reboot on panic (we've configured as such).
> 
> With this change, my machine gets wedged if the machine is running in
> X when the panic occurs.
> 
> I traced the code flow to this:
> 
> bust_spinlocks(0);
>  ->unblank_screen();
>    ->do_unblank_screen(0);
>      ->vc->vc_sw->con_blank(vc, 0, 0);
>        ->fbcon_blank(vc, 0, 0);
>          ->update_screen(vc);
>            ->redraw_screen(vc, 0);
>              ->vc->vc_sw->con_switch(vc);
>                ->fbcon_switch(vc);
>                  ->ops->update_start(info);
>                    ->bit_update_start(info);
>                     ->fb_pan_display(info, &ops->var);
>                       ->info->fbops->fb_pan_display(var, info);
>                         ->drm_fb_helper_pan_display(var, info);
>                           ->mutex_lock(&dev->mode_config.mutex); *this blocks*
> 
> With this change, there is now a lot going on in the panic path. Stuff
> that I'm not sure is safe when panicking. In addition to the
> mutex_lock, there is also a del_timer_sync()
> now happening in the context of panic().
> 
> I see this bug with a 2.6.38 kernel but did a quick scan of a newer
> kernels and did not see anything that changed in this path so I
> suspect its still there.
> 
> Reverting this change fixes the regression.
> 

Chris Fowler reports something similar when running 2.6.38 by inducing a 
kernel panic via the oom killer -- see 
http://marc.info/?l=linux-kernel&m0805985022791.  I've added him to the 
cc so he can participate in the thread and cherry-pick any fixes (last 
status update was that he was going to be trying 2.6.38.8).
