From: Ray Strode <halfline@gmail.com>
Date: Thu, 21 Dec 2017 14:51:45 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <CAA_Uwz+3d_iEUje3M4LPTg-cWTmDwWZLonZAe1pUHn6sWEKBJw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
 <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
 <CAA_Uwz+Px-+-b6TLtPBnSk9zMmayOAR5=Tv7Jd0xkXgkB6hE5w@mail.gmail.com>
 <872ee7d0-ad33-f68a-c859-0865682faaea@suse.de>
In-Reply-To: <872ee7d0-ad33-f68a-c859-0865682faaea@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=C3=A4nzer?= <bernhard.rosenkranzer@linaro.org>

Hi,

On Wed, Dec 20, 2017 at 11:44 AM Max Staudt <mstaudt@suse.de> wrote:
> It'd be nice to see this bug fixed, as it happens only occasionally (as is the nature of a
> race condition), and was thus really hard to debug. I'm sure it can drive people insane,
> as they try to find out whether they've disabled Ctrl-Alt-Fx in their xorg.conf, but really
> it's Plymouth getting the system into a bad state. I probably owe a bald patch on my
> head to this bug.
Okay, reading through the code I do see how what you're describing could happen.

I sketched out a patch here:

https://cgit.freedesktop.org/plymouth/commit/?h=fix-vt-management-on-deactivate&id=0b5b790d628f4c96e3ab9fbc0daba67a29b850da

that I think should fix it.  I need to do some testing with it (ideally rig up
a reproducer) before I push it.

> This is exactly where the kernel bootsplash is useful. Since it starts even before any
> userspace program is loaded, it can close this gap.
>
> I've even tried it in combination with Plymouth: Plymouth is just another graphical
> application, so it simply pops up "on top", just like X would. The two splashes
> integrate flawlessly.
I just wish it used our modern graphics platform instead of the
deprecated subsystem.

> One could argue that one could put all DRM drivers into the initrd. Ubuntu does this,
> and the initrd is ~40 MB in size. Not nice.
well, that 40mb isn't just graphics drivers...
╎❯ du -sh /lib/modules/`uname -r`/kernel/drivers/gpu
2.7M /lib/modules/4.14.6-300.fc27.x86_64/kernel/drivers/gpu

3M isn't too awful.

But really you have two choices as I see it:

1) make the initrd support new hardware
2) make the initrd be taylored to a specific configuration.

I actually think ubuntu has it right by doing 1. it's going to give
the best user experience.
(not just with graphics but other new hardware too).

But if you do 2) then it's not unreasonable if things break with new
hardware. Now
ideally, the breakage would be as isolated as possible.  I mean maybe
it's okay if the
boot splash breaks (or shows a text splash), but it's not okay if the
bootsplash sort of
works using /dev/fb, but then causes Xorg to break.  So we should
probably change
plymouth to avoid falling back to /dev/fb in the case where new
hardware got added.
Could probably fix this by detecting if kms is around when the initrd
is generated,
and adding a config option to skip fb renderer in that case.  or
something like that.

But the easy answer is to just fix the initrd to have the graphics drivers.

> And even then, the initrd could be outdated for some reason. Maybe it's a developer
> machine. Nobody would expect the boot to hang/fail because of this problem.
Right, ideally boot splash problems should never stop boot from proceeding.

> So let's take SUSE. They don't have a finishing transition, the splash simply stops
> and is hidden at once. Such a splash makes sense to be shown instantly, right?
I don't think it makes sense for animations to lack transitions.
animations without
transitions look buggy or unfinished. they should fade out or finish
the loop, or
whatever.  If it's a static image it should fade to black or the
background color.

(going to be away from the computer for a few days after this message
so probably won't reply for a while to further discussion)
--Ray
