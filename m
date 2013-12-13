From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Dec 2013 08:16:45 +0000
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Message-Id: <CAMuHMdUZ6enS0cuGL_OxV+ak3PwOkWVXAaxGxjLRXP-A7FmvYg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1824203.Ui6fpnZVmO@avalon>
	<52A979D8.3040604@ti.com>
	<1703598.NbqXAMAFOI@avalon>
In-Reply-To: <1703598.NbqXAMAFOI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>

On Fri, Dec 13, 2013 at 4:45 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > That's great, and I fully support that. This also calls for refactoring
>> > the V4L2 DT bindings and support code to share them with display devices.
>> > A bikeshedding question is where to put the common code.
>>
>> Thanks very much for review!
>>
>> I know drivers/video is in practice "fbdev", but drivers/video (the
>> words) sound like the best place for things related to video.
>
> That's an option as well, but I'm not sure I like the idea of mixing fbdev and
> generic video in a single directory. We could use a subdirectory of
> drivers/video.

Or reshuffle the various graphics/video/fb/console directories (more
bikeshedding). With git it's not that painful.

Frame buffer devices ended up in drivers/video because at that time, graphics
cards were called video cards. Moving video only entered the picture later.

drivers/fb/ (currently most of drivers/video/)
drivers/console/  (currently drivers/video/console/)
...

Or should fb be under gpu?
What about drivers/media? Video and audio are multi-media, too...

Baah, bad idea... too much bikeshedding ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
