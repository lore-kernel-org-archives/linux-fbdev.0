From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 22 Jan 2016 08:34:58 +0000
Subject: Re: Whats missing in my new FB DRM driver... "No connectors reported connected with modes"?
Message-Id: <CAPj87rNCbTXJv-h4UQe1be2RG8gTTQ3z3dY+ir55Z23pmZbKEg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5684268E.2000607@synopsys.com>
 <CAGd==071hzpQKjLU715tc004NN0d8Z01XdLAhg-DBx1FxtWb2w@mail.gmail.com>
 <569CF78F.7050303@synopsys.com> <569CFA9B.4060108@synopsys.com>
 <CAGd==07ffJAfAtzirALR3OF7f4UDVu_fJbbZ0ZiEa3F5-hLfyw@mail.gmail.com>
 <569E5E51.8000303@synopsys.com> <569E69EB.3010003@synopsys.com>
 <CAGd==04VMKUvb6hZkeNw3kAQt04y0d_Ry7oCtC8=2SWcfWG25A@mail.gmail.com>
 <56A11EF1.3070004@synopsys.com>
 <CAKMK7uFxPvZhAio59yqbQLv_JPBPeRkmF6bnknc3Gh1mA=9LiA@mail.gmail.com>
In-Reply-To: <CAKMK7uFxPvZhAio59yqbQLv_JPBPeRkmF6bnknc3Gh1mA=9LiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hey,

On 22 January 2016 at 07:41, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jan 21, 2016 at 7:09 PM, Carlos Palminha
> <CARLOS.PALMINHA@synopsys.com> wrote:
>> i made some progress in identifying the issue...
>> When my driver calls drm_fb_helper_initial_config it seems DRM blocks waiting for register_framebuffer to return.
>> The sequence is drm_fb_helper_initial_config->drm_fb_helper_single_fb_probe->register_framebuffer.
>>
>> Its strange because register_framebuffer function is just a mutex around do_register_framebuffer.
>>
>> Any clue?!
>
> Ah, the curse of console_lock. drm_fb_helper_initial_config also does
> the initial modeset if you have fbcon enabled. But because of locking
> stupidity we must do _all_ that code (which means pretty much your
> entire driver) under the console_lock, which means no log output until
> console_unlock. Not even on serial port.
>
> https://patchwork.freedesktop.org/patch/57951/ is the usual hack to
> use to get rid of console_lock while booting, so that you can see
> where your driver crashes. I guess we should explain this in the
> kerneldoc ...

Didn't spot this at the time, but that should probably quash the
WARN_ON_CONSOLE_UNLOCKED warnings as well ...

Cheers,
Dan
