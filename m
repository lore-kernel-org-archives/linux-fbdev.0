From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Apr 2020 15:05:18 +0000
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
Message-Id: <CAHp75Vd8kC6ub-=pwe3QtdZ=FBqka3F1bbHea6__G5_Vm_ybcQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
 <20200423142627.1820-1-zhengdejin5@gmail.com>
 <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
In-Reply-To: <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, FlorianSchandinat@gmx.de, Dejin Zheng <zhengdejin5@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, dri-devel <dri-devel@lists.freedesktop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 23, 2020 at 5:55 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> > +     if (err)
> > +             iounmap((void *)npregs);
>
> Looks OK but while you are at it, could you please also add missing
> release_mem_region() on error and on device removal:
>
>         newport_addr = dev->resource.start + 0xF0000;
>         if (!request_mem_region(newport_addr, 0x10000, "Newport"))
>                 return -ENODEV;
>
>         npregs = (struct newport_regs *)/* ioremap cannot fail */
>                 ioremap(newport_addr, sizeof(struct newport_regs));
>         console_lock();
>         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>         console_unlock();
>         return err;
> }
>
> static void newport_remove(struct gio_device *dev)
> {
>         give_up_console(&newport_con);
>         iounmap((void *)npregs);
> }
>
> ?

Don't you think that proper solution is rather switch to memremap()?

> >       return err;
> >  }

-- 
With Best Regards,
Andy Shevchenko
