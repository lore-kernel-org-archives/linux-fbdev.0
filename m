From: timofonic timofonic <timofonic@gmail.com>
Date: Mon, 21 Mar 2011 19:19:43 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
In-Reply-To: <20110321110040.6f1ea6d3@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, wayland-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Hello.

I have some rants and questions about fbdev, KMS and graphics stuff to
Linux. I'm just a mere user and occasional system administrator (and
going to start computer programming soon), but I hope to be able to
understand this situation better.

So if KMS is so cool and provides many advantages over fbdev and
such... Why isn't more widely used intead of still relying on fbdev?
Why still using fbdev emulation (that is partial and somewhat broken,
it seems) instead using KMS directly?

I know the graphic driver situation is quite bad on Linux, especially
on the embedded world. Fbdev seems is still quite used there by binary
blob drivers.

I was a fan of projects like DirectFB and such, but it seems they lack
the manpower or fuel to keep the project relevant. Maybe Wayland can
be their substitute and even have a broader usage too.

I hope KMS gets stronger and the graphic drivers get more into the
open source world (instead violating GPL and doing an attitude I think
should be illegal), that news about open source PowerVR SGX drivers
seems very positive (and surprising, because Imagination Technologies
seems quite against FOSS).

I hope all this gets to suck a bit less. Linux graphics stack
foundation based on KMS, TTM/GEM, advanced hardware accelerated video
decoding of most formats (by using OpenCL plus FFMpeg/LibAV, for
example), Gallium3D and full OpenGL 4.x support could make me very
happy as user and future developer...

Sadly, stuff like S3TC and such makes me very sad. I hope it gets
resolved sucessfully, patents are the nightmare of the technology...


Regards.

On Mon, Mar 21, 2011 at 6:00 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Sat, 19 Mar 2011 12:20:24 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> As noone responded to my question in
>> http://www.spinics.net/lists/dri-devel/msg08851.html
>> (yes, it was a bit hidden in a thread), I'm asking it here again (and
>> also on the Wayland
>> mailing list).
>>
>> Basically I'm still puzzled about this KMS thing. If the name "Kernel
>> Mode Setting"
>> covers it, then how does it compare to plain fbdev? Just additional frame buffer
>> memory management?
>> Also, some people may remember we did have kernel messages (e.g. oops, panic)
>> on graphical consoles with fbdev, until people started not liking them
>> showing up
>> on their X desktops...
>
> We support panic these days as well, but people still don't like seeing
> them. :)
>
> The DRM KMS APIs provide everything fbdev provides, plus memory
> management, a way to expose acceleration (via GEM or TTM), and a way to
> manage multiple outputs reasonably.
>
>> Furthermore, everybody states that "future desktop" (that's
>> http://wayland.freedesktop.org/)
>> will require KMS drivers.
>> How do/will we handle this on dumb frame buffers? It's not like we can't do
>> "advanced" things like compositing using the CPU. Transparency may stretch
>> it a bit on lower end CPUs, but you don't always need that.
>
> There's nothing in DRM that precludes doing simple fbdev-like drivers
> as well, though for many embedded uses I wouldn't expect it to provide
> a whole lot of benefit.
>
> --
> Jesse Barnes, Intel Open Source Technology Center
> _______________________________________________
> wayland-devel mailing list
> wayland-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/wayland-devel
>
