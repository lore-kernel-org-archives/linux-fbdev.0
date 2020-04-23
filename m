From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Thu, 23 Apr 2020 16:03:56 +0000
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
Message-Id: <20200423160356.GA2538@nuc8i5>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200423142627.1820-1-zhengdejin5@gmail.com>
 <CAHp75Vf1_SMk=_WDUrB97BGR6K6EXOdtgQ92=hTyMdVUoyWQiw@mail.gmail.com>
In-Reply-To: <CAHp75Vf1_SMk=_WDUrB97BGR6K6EXOdtgQ92=hTyMdVUoyWQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, FlorianSchandinat@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 23, 2020 at 05:52:09PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 23, 2020 at 5:26 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> >
> > A call of the function do_take_over_console() can fail here.
> > The corresponding system resources were not released then.
> > Thus add a call of the function iounmap() together with the check
> > of a failure predicate.
> 
> ...
> 
> > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Use Cc: Better to read.
>
I will pay attention to the next submission, thanks.

> ...
> 
> > v1 -> v2:
> >         - modify the commit comments by Markus'suggestion.
> 
> What suggestion? You need to be clear in changelog what exactly has
> been done without looking to any previous mail.
>
The commit comments have some more appropriate instructions by
Markus'suggestion. here is my first version commit comments:

if do_take_over_console() return an error in the newport_probe(),
due to the io virtual address is not released, it will cause a leak.

Thnaks!

> ...
> 
> >         console_lock();
> >         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
> >         console_unlock();
> > +
> > +       if (err)
> > +               iounmap((void *)npregs);
> >         return err;
> >  }
> 
> I have briefly looked at the code (it is actually quite old one!), and
> I think this is half-baked solution, besides the fact of missed
> __iomem annotation and useless explicit casting.
> The proper one seems to switch to memremap() and do memunmap() here.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
