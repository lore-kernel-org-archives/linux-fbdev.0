From: Max Staudt <mstaudt@suse.de>
Date: Tue, 19 Dec 2017 17:04:16 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
In-Reply-To: <20171219161630.GI26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On 12/19/2017 05:16 PM, Daniel Vetter wrote:
> On Wed, Dec 13, 2017 at 08:47:42PM +0100, Max Staudt wrote:
>> Dear fbdev and fbcon developers,
>>
>> Thank you very much for your input for the first patch series.
>>
>> I've included your feedback into this second roll, and kindly ask for
>> your opinion on the new patch series.
>=20
> Ok I've realized that my assumptions about why you need this aren't
> holding up.
>=20
> So from reading these patches it sounded like you want an in-kernel boot
> splash because that would be on the display faster than a userspace one
> like plymouth. That's the only reasons I can see for this (if there's
> another good justification, please bring it up).

Yep, that's one of the reasons.

You can find a lot more in the commit message for my first patch.


For example, having a userspace splash that starts as early as it can (thus=
 on vesafb/efifb on a PC) will cause the KMS driver to fail reserving the e=
ntirety of video RAM, and thus fail loading. This cannot be fixed.

Reproducer:  https://bugzilla.opensuse.org/show_bug.cgi?id=980750


Furthermore, Plymouth is quite broken. For example, it may lock (via VT_SET=
MODE) the VT even though Plymouth is in "disabled" state and X has already =
taken control of the VT. This causes the kernel to throw away X's PID as th=
e VT owner, and thus chvt and Ctrl-Alt-Fx no longer work because X can neit=
her release the console (VT_RELDISP fails), nor does the kernel send it the=
 signal to do so. This is hard to impossible to fix.


A third reason is that in practice, Plymouth's start is delayed for reasons=
 such as the above. Yes, race conditions are being worked around with sleep=
s. It'd be nice to have a splash as early as possible, without having to wo=
rry about races.


So some issues are hard to fix, others are impossible to fix in userspace. =
I figured that rather than hacking back and forth and defining APIs in both=
 the kernel and userspace (redoing a sizable part of Plymouth, or writing a=
 replacement), I might as well put small and simple code in the kernel stra=
ight away.

And if it's hooked into fbcon, we get stuff for free:
 - It shows *really* early, even before userland is available.
 - There are no fights, no races for the device. Of any kind.
 - The code is small and simple.


Further reasoning so far, from the comments to my v1 patch series:

  https://lkml.org/lkml/2017/11/10/374
  https://lkml.org/lkml/2017/11/9/324


> I only know of very embedded setups (tv top boxes, in vehicle
> entertainment) where that kind of "time to first image" really matters,
> and those systems:
> - have a real hw kms driver
> - don't have fbcon or fbdev emulation enabled (except for some closed
>   source stacks that are a bit slow to adapt to the new world, and we
>   don't care about those in gfx).

Well, those could enable fbcon if they want the bootsplash. Shouldn't make =
a difference anyway if they're powerful enough to run Linux. As long as the=
 bootsplash is shown, no fbcon drawing operations are executed, so there is=
 no expensive scrolling or such to hog the system.


> But from discussions it sounds like you very much want to use this on
> servers, which makes 0 sense to me. On a server something like plymouth
> should do a perfectly reasonable job.

As I said in the other thread, every little helps.

For example, even on a server, a nice bootsplash makes a Linux system more =
attractive to novice users.

On desktops, it's basically mandatory, as users seem to be scared of text s=
crolling by.


> So, why exactly do we need this?

For the aforementioned reasons, and to have a nice, unified bootsplash code=
 on *all* devices.


> (let's stop the other thread meanwhile, there's no point discussing
> implementation details if the why? question isn't answered yet)

Sure, I hope this helps.



Max
