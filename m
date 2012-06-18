From: David Herrmann <dh.herrmann@googlemail.com>
Date: Mon, 18 Jun 2012 19:06:16 +0000
Subject: Re: [RFC 00/10] fblog: framebuffer kernel log driver
Message-Id: <CANq1E4QmtCUFMioYoBm1h+MV9PMc8GSs9b8CkwBdV4c4-fm_og@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-serial@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Herrmann <dh.herrmann@googlemail.com>

Hi

On Sun, Jun 17, 2012 at 12:04 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> As some might know I am working on making CONFIG_VT obsolete. But as a de=
veloper
> it is often useful to have a kernel-log on the screen during boot to debu=
g many
> common kernel(-config) errors. However, without CONFIG_VT we cannot use t=
he
> VGA/framebbufer consoles either. Therefore, I am working on a small driver
> called "fblog".
>
> This driver simply writes the kernel log to all connected framebuffers. I=
t works
> similar to fbcon but removes all the complexity of the virtual terminals.=
 There
> is a sysfs attribute called "active" that allows to enable/disable fblog =
so
> user-space can start an xserver or similar.
>
> The main purpose is debugging kernel boot problems. Therefore, it is not
> optimized for speed and I tried keeping it simple. I splitted the patches
> into 10 small chunks to make review easier.
>
> I would be glad if someone could review this and tell me whether this is
> something we could include in mainline or not.
>
>
> There are still some issues but apart from them it works fine on my
> machine (x86):
> =A0- I register the fblog device during module_init and need to call
> =A0 =A0module_get(). However, this means it is impossible to call "rmmod =
fblog" as
> =A0 =A0fblog has a reference to itself. Using "rmmod -f fblog" works fine=
 but is a
> =A0 =A0bit ugly. Is there a nice way to fix this? Otherwise I would need =
to call
> =A0 =A0device_get() in module_exit() if there is a pending user of the fb=
log-device
> =A0 =A0even though I unregistered it.
> =A0- I redraw all framebuffers while holding the console-lock. This may s=
low down
> =A0 =A0machines with more than 2 framebuffers (like 10 or 20). However, a=
s this is
> =A0 =A0supposed to be a debug driver, I think I can ignore this? If someo=
ne wants
> =A0 =A0to improve the redraw logic to avoid redrawing the whole screen al=
l the
> =A0 =A0time, I would be glad to include it in this patchset :)
> =A0- I am really no expert regarding the framebuffer subsystem. So I would
> =A0 =A0appreciate it if someone could comment whether I need to handle th=
e events
> =A0 =A0in a different way or whether it is ok the way it is now.

One additional issue:
With udlfb.c we have hotplug capable framebuffers. However, fbcon and
fblog currently never close a framebuffer if not explicitely requested
by user-space. Therefore, if a framebuffer device is removed, the
FB_EVENT_FB_UNREGISTER event will never be sent because fbcon/fblog
still have a reference to the framebuffer(-driver). Therefore, the
number of available fbs will grow until there are no more free
indices.

See dlfb_usb_disconnect() in udlfb.c for an example. It does not
invoke unregister_framebuffer() unless the last user closed the FB.
udlfb disables the console on its framebuffer devices to avoid this,
but this doesn't seem to be a good solution.
How about sending an FB_EVENT_FB_DISCONNECT event during unlink_framebuffer=
()?

This still doesn't force user-space to close /dev/fbX but it at least
will make it possible to fblog/fbcon to close the framebuffer. fbmem.c
can then still be modified to mark the open file as dead so user-space
will also close the device hopefully.

Regards
David
