From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2019 09:18:42 +0000
Subject: Re: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of bootup logos
Message-Id: <CAMuHMdXTm8n=SXyRejT27Q9Vxv0hw5C8DQDXiNM=06aYXq=dgQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190826195740.29415-1-peda@axentia.se> <20190826195740.29415-3-peda@axentia.se>
 <CAMuHMdVx77aOyUVhZ2_N76VAP+AJ3X8w-gdHLjnjUEeRKcZmOA@mail.gmail.com> <a31ff144-f037-3580-08b5-aa368572c69d@axentia.se>
In-Reply-To: <a31ff144-f037-3580-08b5-aa368572c69d@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>

Hi Peter,

On Tue, Aug 27, 2019 at 10:54 AM Peter Rosin <peda@axentia.se> wrote:
> On 2019-08-27 10:36, Geert Uytterhoeven wrote:
> > On Mon, Aug 26, 2019 at 10:46 PM Peter Rosin <peda@axentia.se> wrote:
> >> Probably most useful if you only want one logo regardless of how many
> >> CPU cores you have.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >
> > Thanks for your patch!
> >
> >> --- a/Documentation/fb/fbcon.rst
> >> +++ b/Documentation/fb/fbcon.rst
> >> @@ -174,6 +174,11 @@ C. Boot options
> >>         displayed due to multiple CPUs, the collected line of logos is moved
> >>         as a whole.
> >>
> >> +9. fbcon=logo-count:<n>
> >> +
> >> +       The value 'n' overrides the number of bootup logos. Zero gives the
> >> +       default, which is the number of online cpus.
> >
> > Isn't that a bit unexpected for the user?
> > What about making -1 the default (auto), and zero meaning no logos?
>
> I just naively assumed there was some other mechanism to disable it.

That was my first thought, too, but I couldn't find one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
