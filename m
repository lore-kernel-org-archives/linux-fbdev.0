From: Ray Strode <halfline@gmail.com>
Date: Tue, 19 Dec 2017 20:30:36 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <CAA_UwzJNC0rJxpH95UwwyT=d1JHLzSUTmiPeZhWpjguP-kV_Ow@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
In-Reply-To: <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

Hi,

> For example, having a userspace splash that starts as early as it can
> (thus on vesafb/efifb on a PC) will cause the KMS driver to fail
> reserving the entirety of video RAM, and thus fail loading. This cannot b=
e fixed.
well the fix there is to use drm devices... like this:

https://cgit.freedesktop.org/plymouth/commit/?id=97f02ee959374afb1b8a78dc67=
116cd880cf2d23

> Furthermore, Plymouth is quite broken. For example, it may lock
> (via VT_SETMODE) the VT even though Plymouth is in "disabled"
> state and X has already taken control of the VT.
What do you mean by "disabled" (plymouth.enable=3D0?) ?  if it's
disabled, it's not going to call VT_SETMODE ...

Why do you refer to VT_SETMODE as locking ?  VT_SETMODE sets
whether a process handles VT changes or the kernel does.  There is a
long standing kernel issue where a mode of VT_AUTO (kernel handles
vt switching) + KDGRAPHICS means VTs can't be changed. is that what
you're talking about?

Anyway plymouth is only going to step on X's toes, if the distro erroneously
asks it to.  Normally, a distro would run "plymouth deactivate" before
starting X, instead of trying to run them at the same time...

> This causes the kernel to throw away X's PID as the VT owner, and thus
> chvt and Ctrl-Alt-Fx no longer work because X can neither release the
> console (VT_RELDISP fails), nor does the kernel send it the signal to do
> so. This is hard to impossible to fix.
Unless i'm missing something, this is totally just a problem with startup
scripts not doing the right thing?  Plymouth shouldn't be doing anything
once X is started.  If it is, that's either a plymouth bug (or more likely a
distro integration problem)

> A third reason is that in practice, Plymouth's start is delayed for reaso=
ns
> such as the above. Yes, race conditions are being worked around with
> sleeps.
??? that's not true.  We don't have any sleep statements in the code to work
around race conditions with X.

We do have two configurable delays in the code, are you talking about one of
them?

1) The first is a ShowDelay option.  The point of this option is,
"If boot takes 5 seconds or less, it's essentially instant and we
shouldn't show a splash at all".  Nothing to do with race conditions.
You can set it to 0 if you want.

2) The second is DeviceTimeout option.  The point of this option is to
decide how long to wait for udev coldplug to finish.  It's mostly
relevant for systems that don't have kms drivers.  The point is at
somepoint during boot we need to decide to stop waiting for a drm
device to show up and just fallback to showing graphics using
legacy interfaces (like /dev/fb).  We used to wait until the udev
queue went empty, but that's error prone since it gets cleared when
the root is switched.  See

https://lists.freedesktop.org/archives/systemd-devel/2015-March/029184.html


> So some issues are hard to fix, others are impossible to fix in userspace.
I'm not convinced there are any insurmountable problems here...

One thing i'd like to do is change boot to not map fbcon at first, and
only map it in on the fly when the user hits escape, or after boot
finishes.  like, for instance, try booting with fbcon=3Dvc:2 or
fbcon=3Dmap:9 to see how it improves the boot experience.

--Ray
