From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 21 Mar 2011 18:00:40 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <20110321110040.6f1ea6d3@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
In-Reply-To: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Sat, 19 Mar 2011 12:20:24 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> As noone responded to my question in
> http://www.spinics.net/lists/dri-devel/msg08851.html
> (yes, it was a bit hidden in a thread), I'm asking it here again (and
> also on the Wayland
> mailing list).
> 
> Basically I'm still puzzled about this KMS thing. If the name "Kernel
> Mode Setting"
> covers it, then how does it compare to plain fbdev? Just additional frame buffer
> memory management?
> Also, some people may remember we did have kernel messages (e.g. oops, panic)
> on graphical consoles with fbdev, until people started not liking them
> showing up
> on their X desktops...

We support panic these days as well, but people still don't like seeing
them. :)

The DRM KMS APIs provide everything fbdev provides, plus memory
management, a way to expose acceleration (via GEM or TTM), and a way to
manage multiple outputs reasonably.

> Furthermore, everybody states that "future desktop" (that's
> http://wayland.freedesktop.org/)
> will require KMS drivers.
> How do/will we handle this on dumb frame buffers? It's not like we can't do
> "advanced" things like compositing using the CPU. Transparency may stretch
> it a bit on lower end CPUs, but you don't always need that.

There's nothing in DRM that precludes doing simple fbdev-like drivers
as well, though for many embedded uses I wouldn't expect it to provide
a whole lot of benefit.

-- 
Jesse Barnes, Intel Open Source Technology Center
