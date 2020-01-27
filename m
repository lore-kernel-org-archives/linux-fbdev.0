From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Jan 2020 10:40:24 +0000
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
Message-Id: <CAMuHMdU32gF89zz86WH3AqkoPK7hdSjWMexJ1aLU9woe0qF0YA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200125195506.GA16638@brightrain.aerifal.cx>
 <20200126071724.GA3520745@kroah.com>
In-Reply-To: <20200126071724.GA3520745@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, DRI Development <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Greg,

On Sun, Jan 26, 2020 at 8:44 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 25, 2020 at 02:55:06PM -0500, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > --
>
> I know I don't accept patches without any changelog text, don't know
> about other subsystem maintainers...

FTR, I do, iff the one-line summary says everything that needs to be said.

What's the point in writing a full paragraph like:

   Currently the foo driver does not support the bar device.
   As users may want to use the bar device, it makes perfect sense
   to add support for the bar device to the foo driver.
   Hence add support for the bar device to the foo driver.

if this doesn't add any value on top of the one-line summary?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
