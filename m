From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 May 2011 12:14:20 +0000
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else constructions
Message-Id: <BANLkTi=dCF-EskTECWpfmFmf-UL0ZjLCqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
	<BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
	<1305029285.2045.38.camel@deskari>
In-Reply-To: <1305029285.2045.38.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Niels de Vos <ndevos@redhat.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 10, 2011 at 14:08, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2011-05-10 at 11:42 +0200, Geert Uytterhoeven wrote:
>> What about using the standard pr_debug()/dev_dbg() instead?
>> With dynamic debug, it can be enabled at run time.
>> As a bonus, you get printf()-style format checking if debugging is disabled.
>
> Yes, dev_dbg & co. would be better.
>
> However, one thing I dislike about them is the extra stuff they print.
> For example, for omapfb and omapdss dev_dbg will print:
>
> omapfb omapfb: foo
> omapdss_dss omapdss_dss: foo
>
> I originally added the debug macros to omapdss to be able to
> automatically print the DSS module name, as at that point there was only
> one big omapdss device. And I guess I just followed with similar macro
> in omapfb also. But I believe both omapdss and omapfb should be changed
> to dev_* prints sometime soon.

If you don't want the extra baggage, do

        #define pr_fmt(fmt)     KBUILD_MODNAME ": " fmt

and use pr_debug().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
