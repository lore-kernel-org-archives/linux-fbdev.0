From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Thu, 23 Apr 2020 14:29:09 +0000
Subject: Re: [PATCH v1] console: fix an issue about ioremap leak.
Message-Id: <20200423142909.GB1562@nuc8i5>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
In-Reply-To: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fbdev@vger.kernel.org, Thomas =?utf-8?Q?Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Coccinelle <cocci@systeme.lip6.fr>

On Thu, Apr 23, 2020 at 01:10:14PM +0200, Markus Elfring wrote:
> > if do_take_over_console() return an error in the newport_probe(),
> > due to the io virtual address is not released, it will cause a leak.
> 
> How do you think about a wording variant like the following?
> 
>    Subject:
>    [PATCH v2] console: Complete exception handling in newport_probe()
> 
>    Change description:
>    A call of the function “do_take_over_console” can fail here.
>    The corresponding system resources were not released then.
>    Thus add a call of the function “iounmap” together with the check
>    of a failure predicate.
>
Thanks!

> 
> I would like to point out that there is a script for the semantic
> patch language which would detect other questionable source code.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
> 
> How do you think about to extend presented software analysis approaches?
>
Sorry, I am not familiar with it, I don't know.

BR,
Dejin

> Regards,
> Markus
