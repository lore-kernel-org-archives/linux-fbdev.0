From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Jan 2019 10:38:54 +0000
Subject: Re: [PATCH v3] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <CAMuHMdVNige+Th=+emLs41_bqfGHbYerUoK7x4tSJ2Uz9K1Pww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181030154456epcas4p19e91c78daad3f1f48e8260601e5fdfec@epcas4p1.samsung.com>
 <20181030154419.2889-1-prarit@redhat.com>
 <3de54c0d-3e9b-769f-5cc6-e69dbb399426@samsung.com>
 <20190102160536.h46ehoymo4sh6apz@pathway.suse.cz>
In-Reply-To: <20190102160536.h46ehoymo4sh6apz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, Thierry Reding <treding@nvidia.com>

Hi Petr,

On Wed, Jan 2, 2019 at 6:43 PM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2018-12-20 17:31:57, Bartlomiej Zolnierkiewicz wrote:
> > [ added Petr & Sergey to Cc: ]
> >
> > Hi,
> >
> > On 10/30/2018 04:44 PM, Prarit Bhargava wrote:
> > > On text-based systems the 'quiet' boot option will show printk levels
> > > higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
> > > during boot can cause some consoles to lose display data and as a result
> > > confuse the end user.
> > >
> > > Do not display the Tux logo on systems that are in 'quiet' boot.
> > >
> > > v2: It helps to commit all my changes before sending them.  Remove extra
> > > bracket.
> > > v3: buildbot error fix: fbcon can be built as part of a module so export console_printk
> > >
> > > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Marko Myllynen <myllynen@redhat.com>
> > > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Thierry Reding <treding@nvidia.com>
> > > Cc: Yisheng Xie <ysxie@foxmail.com>
> > > Cc: dri-devel@lists.freedesktop.org

> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -66,6 +66,7 @@ int console_printk[4] = {
> > >     CONSOLE_LOGLEVEL_MIN,           /* minimum_console_loglevel */
> > >     CONSOLE_LOGLEVEL_DEFAULT,       /* default_console_loglevel */
> > >  };
> > > +EXPORT_SYMBOL(console_printk);
> >
> > You need printk Maintainers Ack on it.
>
> I am fine with the added export (as a printk maintainer).

EXPORT_SYMBOL_GPL()?

The file seems to use a strange mix of both...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
