From: Ray Strode <halfline@gmail.com>
Date: Wed, 20 Dec 2017 15:21:53 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <CAA_Uwz+Px-+-b6TLtPBnSk9zMmayOAR5=Tv7Jd0xkXgkB6hE5w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
 <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
In-Reply-To: <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=C3=A4nzer?= <bernhard.rosenkranzer@linaro.org>

Hi,

> The problem that I am stumbling upon is different:
>  - the system starts with an FB driver
>  - after the ShowDelay time, Plymouth opens /dev/fb0
>  - the system finally loads the DRM driver, which tries to kick the previous FB driver
>  - loading the DRM driver fails because Plymouth still has the previous /dev/fb0 open
So the thing to realize is, that using /dev/fb is a last ditch effort
by plymouth to make
things work. It's basically a compat hack to keep vga=0x318 working
and also a nod
to embedded systems that just have /dev/fb and don't have a kms driver.  If we
fall back to /dev/fb we lose, as mentioned before, multi-monitor
support. And it's a
legacy, deprecated api.

If we've reached the scenario you're discussing above, the real
failure is that the KMS
driver took too long to load. DRM is the platform graphics api.  If
it's not loading
timely enough to show graphics then that's the problem!  It sounds
like maybe in the
above bug, you're just failing to load the drm driver in the initrd ?

> If you have a better way of calling it, I'd be glad to learn.
> Maybe "grabbing the VT", "taking ownership of the VT", ...?
I don't care what we call it, I just didn't understand what you were
saying before.
I think i'd say "manages vt switching", but whatever.

> And then, if something causes Plymouth to sense a new device (such as Plymouth
>  thinking that udev coldplug is complete), it will open the device, and as part of that,
> call VT_SETMODE. This is unexpected, since "plymouth deactivate" should keep it
> from doing this. And Plymouth's code architecture is such that this bug is hard to fix.
If what you're describing is happening, this does sound like a bug. I
don't think it
should be hard to fix, if it's a problem. I'll look into it.

> [I] have decided to write a kernel-based replacement to simplify things and to show a
> splash as early as possible. It just avoids all of this complexity.
So, for the record, I don't actually have a problem with you doing a
kernel based splash.
(though it should use drm subsystem apis not graphics subsystem apis,
/dev/fb is going
the way of the dodo)

> This is the sleep that I mean.
>
> On the one hand, it is this delay that makes most users not notice the
> "busy VRAM bug". If the DRM driver that replaces the FB driver is included in the
> initramfs, then in most cases, it will be loaded before the 5 seconds are up. However,
> if the driver is loaded after these 5 seconds have elapsed, then Plymouth will have
> opened /dev/fb0 and the modprobe fails.
Think of this from a user perspective.  If the screen is black for 15 seconds
(or something) before a splash is shown, then we've already hit a
problem! That's like 15
seconds of time where the user is wondering if their system is broken.
But I don't think that actually happens in practice.  I think (maybe?)
the situation you're
hitting is your drm driver isn't starting to get loaded until N
seconds after boot has started,
because it's not in the initrd.  So the fix is to put it in the initrd.

> On the other hand, what is the motivation for this delay?
As I said earlier, the motivation for the delay is to avoid showing a
splash for systems that
boot in 4 seconds or something. At that point a splash is just getting
in the way.

>  If Plymouth were to display the splash instantly on a system that needs 0.5 seconds to
> boot, then the splash would flash for 0.5 seconds.
No, flashing a splash for half a second would be a bug. (again think
of things from a user
perpective).  Plymouth splashes have animations at the end to
transition the user to the
 login screen.  Normally those animations don't contribute to boot
time, because we know
when boot will finish from prior boot data.  But if boot were 0.5
seconds long, then those
 animations would contribute 2 to 3 seconds to boot time, and if boot
is 0.5 seconds long
showing a splash is pointless.
> But with the delay, a system that needs 5.5 seconds to boot will also flash it for 0.5 seconds.
> Either way, the splash will just flash for a moment.
again, we don't blink the splash on and off. we have transition animations.

> The delay only changes which systems are affected. However, if you set the delay to 0,
> you'll run into the bug I described above.
Then put the drm driver in the initramfs so you fix your bug !

> This is a design problem, hidden by a needless delay.
really don't see how it is.

--Ray
