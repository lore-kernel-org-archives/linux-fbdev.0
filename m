From: Max Staudt <mstaudt@suse.de>
Date: Thu, 21 Dec 2017 16:32:42 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <9d89a924-2e43-01df-5211-0fb69a6b1a0c@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
 <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
 <CAA_Uwz+Px-+-b6TLtPBnSk9zMmayOAR5=Tv7Jd0xkXgkB6hE5w@mail.gmail.com>
 <872ee7d0-ad33-f68a-c859-0865682faaea@suse.de>
 <CAA_Uwz+3d_iEUje3M4LPTg-cWTmDwWZLonZAe1pUHn6sWEKBJw@mail.gmail.com>
In-Reply-To: <CAA_Uwz+3d_iEUje3M4LPTg-cWTmDwWZLonZAe1pUHn6sWEKBJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ray Strode <halfline@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>, philm@manjaro.org

On 12/21/2017 03:51 PM, Ray Strode wrote:
> Hi,
> 
> On Wed, Dec 20, 2017 at 11:44 AM Max Staudt <mstaudt@suse.de> wrote:
>> It'd be nice to see this bug fixed, as it happens only occasionally (as is the nature of a
>> race condition), and was thus really hard to debug. I'm sure it can drive people insane,
>> as they try to find out whether they've disabled Ctrl-Alt-Fx in their xorg.conf, but really
>> it's Plymouth getting the system into a bad state. I probably owe a bald patch on my
>> head to this bug.
> Okay, reading through the code I do see how what you're describing could happen.
> 
> I sketched out a patch here:
> 
> https://cgit.freedesktop.org/plymouth/commit/?h=fix-vt-management-on-deactivate&id5b790d628f4c96e3ab9fbc0daba67a29b850da
> 
> that I think should fix it.  I need to do some testing with it (ideally rig up
> a reproducer) before I push it.

Hmm, I haven't looked at what manager->renderers_activated means, but from just looking at the diff, it looks like it could solve the problem. Please do test it though! I'm afraid I can't really tell you how to rig up a reproducer, since it's a race condition. Maybe a sleep() in gdm, and then forcefully emptying the udev queue?

Are you sure that process_udev_event (manager) will do the right thing?
Will it keep a list of events not processed?

What if a card is plugged in, then unplugged? Would Plymouth then handle the plugin first, see that the card isn't there, and fail gracefully? And will it handle the unplug gracefully if the card wasn't there in the first place?

Or what if I plug in two cards - it needs to keep a list of events for this case, otherwise it will only detect one card when it resumes udev processing.

Maybe these concerns are unnecessary - I haven't looked at the full Plymouth code since. Just ideas to keep in mind when rigging up the patch.


Thanks for looking into a fix!


>> This is exactly where the kernel bootsplash is useful. Since it starts even before any
>> userspace program is loaded, it can close this gap.
>>
>> I've even tried it in combination with Plymouth: Plymouth is just another graphical
>> application, so it simply pops up "on top", just like X would. The two splashes
>> integrate flawlessly.
> I just wish it used our modern graphics platform instead of the
> deprecated subsystem.

I see, and I share your concern that legacy interfaces should die.
But with the current architecture in the kernel, building it on DRM wouldn't make sense, sorry.
Also, it would exclude the efifb case, which is decidedly a design requirement.


>> One could argue that one could put all DRM drivers into the initrd. Ubuntu does this,
>> and the initrd is ~40 MB in size. Not nice.
> well, that 40mb isn't just graphics drivers...
> ╎❯ du -sh /lib/modules/`uname -r`/kernel/drivers/gpu
> 2.7M /lib/modules/4.14.6-300.fc27.x86_64/kernel/drivers/gpu
> 
> 3M isn't too awful.

Oh, true. Weird, then I must have gotten something mixed up. That means there's truly tons of stuff in that initrd.


> But really you have two choices as I see it:
> 
> 1) make the initrd support new hardware
> 2) make the initrd be taylored to a specific configuration.
> 
> I actually think ubuntu has it right by doing 1. it's going to give
> the best user experience.
> (not just with graphics but other new hardware too).

Yes. Except when the mechanism fails.

And it doesn't cover the time before the driver is loaded.


> But if you do 2) then it's not unreasonable if things break with new
> hardware.

Agreed.


> Now
> ideally, the breakage would be as isolated as possible.  I mean maybe
> it's okay if the
> boot splash breaks (or shows a text splash),

Yup.


> but it's not okay if the
> bootsplash sort of
> works using /dev/fb, but then causes Xorg to break.  So we should
> probably change
> plymouth to avoid falling back to /dev/fb in the case where new
> hardware got added.
> Could probably fix this by detecting if kms is around when the initrd
> is generated,
> and adding a config option to skip fb renderer in that case.  or
> something like that.

That's not possible. When generating the initrd, you don't know where it will actually be booted next.

Practical example: Last year's installation media on next year's hardware.


> But the easy answer is to just fix the initrd to have the graphics drivers.

See above - you can't guarantee that I'm afraid.

Unless the distro decides to not care about vesafb/efifb, and just show the text mode plymouth splash in case no KMS driver has been loaded until then. That's what Fedora does when booted on non-EFI machines, since it boots in VGA text (non-graphics) mode. But ideally, we'd have a graphical splash in as many cases as possible. If you boot your Fedora machine in a framebuffer mode, or in EFI mode, you'll unleash these issues.


>> So let's take SUSE. They don't have a finishing transition, the splash simply stops
>> and is hidden at once. Such a splash makes sense to be shown instantly, right?
> I don't think it makes sense for animations to lack transitions.
> animations without
> transitions look buggy or unfinished. they should fade out or finish
> the loop, or
> whatever.  If it's a static image it should fade to black or the
> background color.

Umm... yeah, that's a design decision. I'm afraid that's not my department ;)

What about the delay? Do you agree that with such a simple, no-transition splash, it makes sense to reduce the delay to 0?


> (going to be away from the computer for a few days after this message
> so probably won't reply for a while to further discussion)

Yes, me too. I'll be back in 2018.

Thank you for your feedback and for fixing Plymouth!


Max
