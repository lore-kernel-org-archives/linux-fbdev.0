From: Rob Clark <robdclark@gmail.com>
Date: Sat, 19 Mar 2011 15:45:23 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTi=L_QuVmWN_uO0D5O9_SzvmOmgnyygz_0XNTfZy@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
In-Reply-To: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Sat, Mar 19, 2011 at 6:20 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> As noone responded to my question in
> http://www.spinics.net/lists/dri-devel/msg08851.html
> (yes, it was a bit hidden in a thread), I'm asking it here again (and
> also on the Wayland
> mailing list).
>
> Basically I'm still puzzled about this KMS thing. If the name "Kernel
> Mode Setting"
> covers it, then how does it compare to plain fbdev? Just additional frame=
 buffer
> memory management?
> Also, some people may remember we did have kernel messages (e.g. oops, pa=
nic)
> on graphical consoles with fbdev, until people started not liking them
> showing up
> on their X desktops...

The KMS part of DRM has nothing to do with acceleration.  So it could
be implemented on a dumb framebuffer.  KMS is just about mode-setting,
and configuring framebuffer (memory) that is scanned out to one or
more displays.

BR,
-R

> Furthermore, everybody states that "future desktop" (that's
> http://wayland.freedesktop.org/)
> will require KMS drivers.
> How do/will we handle this on dumb frame buffers? It's not like we can't =
do
> "advanced" things like compositing using the CPU. Transparency may stretch
> it a bit on lower end CPUs, but you don't always need that.
>
> Thanks for your answers and comments!
>
> Gr{oetje,eeting}s,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =A0=A0 -- Linu=
s Torvalds
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
