From: Mandeep Singh Baines <msb@chromium.org>
Date: Mon, 20 Jun 2011 23:20:16 +0000
Subject: Re: Regression in panic
Message-Id: <BANLkTimVL-PyOc31J5A54A=4gFggM91PDB3g79bxSxn92-Es8Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTingstCoWk0H20nN1J7t3H=mndSdnL2YpeW2R46fhL2kpA@mail.gmail.com>
	<alpine.DEB.2.00.1106201601220.15259@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1106201601220.15259@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Rientjes <rientjes@google.com>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olof Johansson <olofj@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Chris Fowler <cfowler@opsdc.com>

On Mon, Jun 20, 2011 at 4:03 PM, David Rientjes <rientjes@google.com> wrote:
> On Mon, 20 Jun 2011, Mandeep Singh Baines wrote:
>
>> Hi Dave,
>>
>> I think this change is causing a regression I'm seeing in panic.
>> Before this change, I'd get a
>> reboot on panic (we've configured as such).
>>
>> With this change, my machine gets wedged if the machine is running in
>> X when the panic occurs.
>>
>> I traced the code flow to this:
>>
>> bust_spinlocks(0);
>> =A0->unblank_screen();
>> =A0 =A0->do_unblank_screen(0);
>> =A0 =A0 =A0->vc->vc_sw->con_blank(vc, 0, 0);
>> =A0 =A0 =A0 =A0->fbcon_blank(vc, 0, 0);
>> =A0 =A0 =A0 =A0 =A0->update_screen(vc);
>> =A0 =A0 =A0 =A0 =A0 =A0->redraw_screen(vc, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0->vc->vc_sw->con_switch(vc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0->fbcon_switch(vc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0->ops->update_start(info);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0->bit_update_start(info);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ->fb_pan_display(info, &ops->var=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ->info->fbops->fb_pan_displa=
y(var, info);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ->drm_fb_helper_pan_disp=
lay(var, info);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ->mutex_lock(&dev->m=
ode_config.mutex); *this blocks*
>>
>> With this change, there is now a lot going on in the panic path. Stuff
>> that I'm not sure is safe when panicking. In addition to the
>> mutex_lock, there is also a del_timer_sync()
>> now happening in the context of panic().
>>
>> I see this bug with a 2.6.38 kernel but did a quick scan of a newer
>> kernels and did not see anything that changed in this path so I
>> suspect its still there.
>>
>> Reverting this change fixes the regression.
>>
>
> Chris Fowler reports something similar when running 2.6.38 by inducing a
> kernel panic via the oom killer -- see
> http://marc.info/?l=3Dlinux-kernel&m=130805985022791. =A0I've added him t=
o the
> cc so he can participate in the thread and cherry-pick any fixes (last
> status update was that he was going to be trying 2.6.38.8).
>

One potential fix might be to convert the mutex_lock to a try if
oops_in_progress but
I suspect oops_in_progress checks may be needed in a bunch of other places =
in
the screen_unblank code path.
