From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 19 Mar 2011 11:20:24 +0000
Subject: Future desktop on dumb frame buffers?
Message-Id: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>

As noone responded to my question in
http://www.spinics.net/lists/dri-devel/msg08851.html
(yes, it was a bit hidden in a thread), I'm asking it here again (and
also on the Wayland
mailing list).

Basically I'm still puzzled about this KMS thing. If the name "Kernel
Mode Setting"
covers it, then how does it compare to plain fbdev? Just additional frame buffer
memory management?
Also, some people may remember we did have kernel messages (e.g. oops, panic)
on graphical consoles with fbdev, until people started not liking them
showing up
on their X desktops...

Furthermore, everybody states that "future desktop" (that's
http://wayland.freedesktop.org/)
will require KMS drivers.
How do/will we handle this on dumb frame buffers? It's not like we can't do
"advanced" things like compositing using the CPU. Transparency may stretch
it a bit on lower end CPUs, but you don't always need that.

Thanks for your answers and comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
