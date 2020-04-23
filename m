From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 23 Apr 2020 11:10:14 +0000
Subject: Re: [PATCH v1] console: fix an issue about ioremap leak.
Message-Id: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200422155328.27473-1-zhengdejin5@gmail.com>
In-Reply-To: <20200422155328.27473-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dejin Zheng <zhengdejin5@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc: =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

> if do_take_over_console() return an error in the newport_probe(),
> due to the io virtual address is not released, it will cause a leak.

How do you think about a wording variant like the following?

   Subject:
   [PATCH v2] console: Complete exception handling in newport_probe()

   Change description:
   A call of the function “do_take_over_console” can fail here.
   The corresponding system resources were not released then.
   Thus add a call of the function “iounmap” together with the check
   of a failure predicate.


I would like to point out that there is a script for the semantic
patch language which would detect other questionable source code.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci

How do you think about to extend presented software analysis approaches?

Regards,
Markus
