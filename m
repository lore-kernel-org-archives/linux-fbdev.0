From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Thu, 23 Apr 2020 17:02:45 +0000
Subject: Re: console: Complete exception handling in newport_probe()
Message-Id: <20200423170245.GA3417@nuc8i5>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5>
 <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
In-Reply-To: <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fbdev@vger.kernel.org, Thomas =?utf-8?Q?Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Coccinelle <cocci@systeme.lip6.fr>

On Thu, Apr 23, 2020 at 05:23:29PM +0200, Markus Elfring wrote:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
> >>
> >> How do you think about to extend presented software analysis approaches?
> >>
> > Sorry, I am not familiar with it, I don't know.
> 
> Do you find the comments helpful at the beginning of this SmPL script?
>
Sorry, I do not know how to use the SmPL script. 

> Would you like to let any more source code analysis tools help you
> to find remaining update candidates?
>
yes, but I think the source code analysis tools only can found the simple
repetitive issue. and need spend some time learning to use it. at different
stages, it should have different methods for me. now, I think the best for
me may be that read and check the source code. Thanks!

BR,
Dejin

> Regards,
> Markus
