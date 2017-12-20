From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 16:44:31 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <872ee7d0-ad33-f68a-c859-0865682faaea@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
 <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
 <CAA_Uwz+Px-+-b6TLtPBnSk9zMmayOAR5=Tv7Jd0xkXgkB6hE5w@mail.gmail.com>
In-Reply-To: <CAA_Uwz+Px-+-b6TLtPBnSk9zMmayOAR5=Tv7Jd0xkXgkB6hE5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ray Strode <halfline@gmail.com>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/20/2017 04:21 PM, Ray Strode wrote:
> If we've reached the scenario you're discussing above, the real
> failure is that the KMS
> driver took too long to load. DRM is the platform graphics api.  If
> it's not loading
> timely enough to show graphics then that's the problem!  It sounds
> like maybe in the
> above bug, you're just failing to load the drm driver in the initrd ?

This case needs to be handled.

Again, please read my bug report.

When the user changes graphics cards, the initrd does not contain the new driver. It's in the rootfs, if at all.

If it does happen to be on the rootfs, then it is potentially loaded after Plymouth has already opened /dev/fb0. And then the bug occurs.

Please don't say that I'm to blame for changing my graphics card. This is not fair.


And I have to admit, it's not even necessarily a bug. It's just the nature of the kernel/userspace split. All I know is that the boot failing due to this is not right, and horrible to debug the next time it happens to someone.


>> And then, if something causes Plymouth to sense a new device (such as Plymouth
>>  thinking that udev coldplug is complete), it will open the device, and as part of that,
>> call VT_SETMODE. This is unexpected, since "plymouth deactivate" should keep it
>> from doing this. And Plymouth's code architecture is such that this bug is hard to fix.
> If what you're describing is happening, this does sound like a bug. I
> don't think it
> should be hard to fix, if it's a problem. I'll look into it.

Thank you!

It'd be nice to see this bug fixed, as it happens only occasionally (as is the nature of a race condition), and was thus really hard to debug. I'm sure it can drive people insane, as they try to find out whether they've disabled Ctrl-Alt-Fx in their xorg.conf, but really it's Plymouth getting the system into a bad state. I probably owe a bald patch on my head to this bug.


>> [I] have decided to write a kernel-based replacement to simplify things and to show a
>> splash as early as possible. It just avoids all of this complexity.
> So, for the record, I don't actually have a problem with you doing a
> kernel based splash.

Thanks!

It's really just meant as an alternative. I've heard enough people who'd prefer it over Plymouth, but Plymouth is just as important as it is much more feature-rich.


>> This is the sleep that I mean.
>>
>> On the one hand, it is this delay that makes most users not notice the
>> "busy VRAM bug". If the DRM driver that replaces the FB driver is included in the
>> initramfs, then in most cases, it will be loaded before the 5 seconds are up. However,
>> if the driver is loaded after these 5 seconds have elapsed, then Plymouth will have
>> opened /dev/fb0 and the modprobe fails.
> Think of this from a user perspective.  If the screen is black for 15 seconds
> (or something) before a splash is shown, then we've already hit a
> problem! That's like 15
> seconds of time where the user is wondering if their system is broken.

This is exactly where the kernel bootsplash is useful. Since it starts even before any userspace program is loaded, it can close this gap.

I've even tried it in combination with Plymouth: Plymouth is just another graphical application, so it simply pops up "on top", just like X would. The two splashes integrate flawlessly.


> But I don't think that actually happens in practice.  I think (maybe?)
> the situation you're
> hitting is your drm driver isn't starting to get loaded until N
> seconds after boot has started,
> because it's not in the initrd.  So the fix is to put it in the initrd.
No. See above.

One could argue that one could put all DRM drivers into the initrd. Ubuntu does this, and the initrd is ~40 MB in size. Not nice.

And even then, the initrd could be outdated for some reason. Maybe it's a developer machine. Nobody would expect the boot to hang/fail because of this problem.


>> On the other hand, what is the motivation for this delay?
> As I said earlier, the motivation for the delay is to avoid showing a
> splash for systems that
> boot in 4 seconds or something. At that point a splash is just getting
> in the way.
> 
>>  If Plymouth were to display the splash instantly on a system that needs 0.5 seconds to
>> boot, then the splash would flash for 0.5 seconds.
> No, flashing a splash for half a second would be a bug. (again think
> of things from a user
> perpective).  Plymouth splashes have animations at the end to
> transition the user to the
>  login screen.  Normally those animations don't contribute to boot
> time, because we know
> when boot will finish from prior boot data.  But if boot were 0.5
> seconds long, then those
>  animations would contribute 2 to 3 seconds to boot time, and if boot
> is 0.5 seconds long
> showing a splash is pointless.
>> But with the delay, a system that needs 5.5 seconds to boot will also flash it for 0.5 seconds.
>> Either way, the splash will just flash for a moment.
> again, we don't blink the splash on and off. we have transition animations.
> 
>> The delay only changes which systems are affected. However, if you set the delay to 0,
>> you'll run into the bug I described above.
> Then put the drm driver in the initramfs so you fix your bug !
> 
>> This is a design problem, hidden by a needless delay.
> really don't see how it is.

Ah, I see. I admit I wasn't aware of such transitions and boot timings.

So let's take SUSE. They don't have a finishing transition, the splash simply stops and is hidden at once.
Such a splash makes sense to be shown instantly, right?

So the startup delay could be reduced to 0. Except that that would mean running into the initrd "bug".



Max
