From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 13:03:20 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <48846920-4244-763c-a23b-44f42ac2c2c6@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
In-Reply-To: <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Ray Strode <halfline@gmail.com>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On 12/19/2017 09:30 PM, Ray Strode wrote:
> Hi,
>=20
>> For example, having a userspace splash that starts as early as it can
>> (thus on vesafb/efifb on a PC) will cause the KMS driver to fail
>> reserving the entirety of video RAM, and thus fail loading. This cannot =
be fixed.
> well the fix there is to use drm devices... like this:
>=20
> https://cgit.freedesktop.org/plymouth/commit/?id=97f02ee959374afb1b8a78dc=
67116cd880cf2d23

Sorry, you're confusing things. Please re-read the v1 cover letter, the com=
mit message for patch 1, and the associated discussions.

There is also a bug report where I've described what happens - I think it c=
larifies the situation a lot:
  https://bugzilla.opensuse.org/show_bug.cgi?id=980750


To summarise: What you mean is for Plymouth to ignore FB devices when they =
have equivalent DRM devices. And yes, Plymouth does that just fine.

The problem that I am stumbling upon is different:
 - the system starts with an FB driver
 - after the ShowDelay time, Plymouth opens /dev/fb0
 - the system finally loads the DRM driver, which tries to kick the previou=
s FB driver
 - loading the DRM driver fails because Plymouth still has the previous /de=
v/fb0 open


It's a wholly different issue.


>> Furthermore, Plymouth is quite broken. For example, it may lock
>> (via VT_SETMODE) the VT even though Plymouth is in "disabled"
>> state and X has already taken control of the VT.
> What do you mean by "disabled" (plymouth.enable=3D0?) ?  if it's
> disabled, it's not going to call VT_SETMODE ...

1. System boots
2. Plymouth starts and grabs some displays
3. gdm starts and runs /usr/bin/plymouth deactivate
4. X server grabs VT
5. udev queue is empty
6. Plymouth thinks that coldplugging has finished, and grabs remaining disp=
lays
7. <this is where Plymouth calls VT_SETMODE even though it's deactivated>
8. gdm runs /usr/bin/plymouth quit --retain-splash


> Why do you refer to VT_SETMODE as locking ?

It's not a lock in the concurrency sense, sure.

If you have a better way of calling it, I'd be glad to learn.
Maybe "grabbing the VT", "taking ownership of the VT", ...?


> VT_SETMODE sets
> whether a process handles VT changes or the kernel does.  There is a
> long standing kernel issue where a mode of VT_AUTO (kernel handles
> vt switching) + KDGRAPHICS means VTs can't be changed. is that what
> you're talking about?

No, that's not what I mean. I've inserted printk()s in the kernel, and I've=
 seen the X server's PID being thrown out when Plymouth calls VT_SETMODE. O=
nce this happens, the kernel can no longer tell X to release the display.

The VT_SETMODE API is meant to be used by a single user at a time, not by t=
wo concurrently. It was built in a time when it was assumed that nobody oth=
er than the X server would use it.


> Anyway plymouth is only going to step on X's toes, if the distro erroneou=
sly
> asks it to.  Normally, a distro would run "plymouth deactivate" before
> starting X, instead of trying to run them at the same time...

That's what gdm, sddm, etc. do.

And then, if something causes Plymouth to sense a new device (such as Plymo=
uth thinking that udev coldplug is complete), it will open the device, and =
as part of that, call VT_SETMODE. This is unexpected, since "plymouth deact=
ivate" should keep it from doing this. And Plymouth's code architecture is =
such that this bug is hard to fix.

This is accurate as of about one year ago. I haven't looked into it since, =
but have decided to write a kernel-based replacement to simplify things and=
 to show a splash as early as possible. It just avoids all of this complexi=
ty.


>> This causes the kernel to throw away X's PID as the VT owner, and thus
>> chvt and Ctrl-Alt-Fx no longer work because X can neither release the
>> console (VT_RELDISP fails), nor does the kernel send it the signal to do
>> so. This is hard to impossible to fix.
> Unless i'm missing something, this is totally just a problem with startup
> scripts not doing the right thing?  Plymouth shouldn't be doing anything
> once X is started.  If it is, that's either a plymouth bug (or more likel=
y a
> distro integration problem)

It is a Plymouth bug, see above.


>> A third reason is that in practice, Plymouth's start is delayed for reas=
ons
>> such as the above. Yes, race conditions are being worked around with
>> sleeps.
> ??? that's not true.  We don't have any sleep statements in the code to w=
ork
> around race conditions with X.
>=20
> We do have two configurable delays in the code, are you talking about one=
 of
> them?
>=20
> 1) The first is a ShowDelay option.  The point of this option is,
> "If boot takes 5 seconds or less, it's essentially instant and we
> shouldn't show a splash at all".  Nothing to do with race conditions.
> You can set it to 0 if you want.

This is the sleep that I mean.

On the one hand, it is this delay that makes most users not notice the "bus=
y VRAM bug". If the DRM driver that replaces the FB driver is included in t=
he initramfs, then in most cases, it will be loaded before the 5 seconds ar=
e up. However, if the driver is loaded after these 5 seconds have elapsed, =
then Plymouth will have opened /dev/fb0 and the modprobe fails.

This sleep in Plymouth, combined with DRM drivers being included in the ini=
tramfs, just happens to work around the bug on most systems.

On the other hand, what is the motivation for this delay? If Plymouth were =
to display the splash instantly on a system that needs 0.5 seconds to boot,=
 then the splash would flash for 0.5 seconds. But with the delay, a system =
that needs 5.5 seconds to boot will also flash it for 0.5 seconds. Either w=
ay, the splash will just flash for a moment. The delay only changes which s=
ystems are affected. However, if you set the delay to 0, you'll run into th=
e bug I described above. This is a design problem, hidden by a needless del=
ay.


> 2) The second is DeviceTimeout option.  The point of this option is to
> decide how long to wait for udev coldplug to finish.  It's mostly
> relevant for systems that don't have kms drivers.  The point is at
> somepoint during boot we need to decide to stop waiting for a drm
> device to show up and just fallback to showing graphics using
> legacy interfaces (like /dev/fb).  We used to wait until the udev
> queue went empty, but that's error prone since it gets cleared when
> the root is switched.  See
>=20
> https://lists.freedesktop.org/archives/systemd-devel/2015-March/029184.ht=
ml

I know this thread.

In the very email you linked, Tom explains that "the udev queue is empty" i=
s NOT a way to sense that "udev coldplug is complete":
"Just to stress this again: the assumptions plymouth makes here are invalid=
."

In fact, there is no way to know this. DRM devices that replace generic FB =
devices can appear at any time. And the solution to this is to implement a =
timeout? This makes zero sense. It breaks with any fundamental reasoning of=
 concurrency. As far as I can see, Plymouth doesn't understand concurrency.


So if you have a case where:

1. plymouth deactivate
2. Xorg starts
3. plymouth thinks "coldplug complete"
4. plymouth calls VT_SETMODE

...you're clearly doing something very, very wrong because you're ignoring =
the "deactivate" command.


If this has been truly fixed in the meantime, please ignore it.


>> So some issues are hard to fix, others are impossible to fix in userspac=
e.
> I'm not convinced there are any insurmountable problems here...
>=20
> One thing i'd like to do is change boot to not map fbcon at first, and
> only map it in on the fly when the user hits escape, or after boot
> finishes.  like, for instance, try booting with fbcon=3Dvc:2 or
> fbcon=3Dmap:9 to see how it improves the boot experience.
This doesn't touch upon any of the problems that I've described, and only s=
erves to introduce additional failure points.


The reason why I wrote the kernel splash is that it's foolproof.
It doesn't need these hacks that just keep piling up.
No sleeps. No remapping of consoles. No races. No fights. No nothing.

This is why I started it.



Max
