From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Sun, 26 Apr 2020 02:55:34 +0000
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak related system resources
Message-Id: <20200426025534.GA19252@nuc8i5>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20f37865-5af3-5fb9-8b8f-91f9464e4af3@web.de>
In-Reply-To: <20f37865-5af3-5fb9-8b8f-91f9464e4af3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Apr 24, 2020 at 06:54:41PM +0200, Markus Elfring wrote:
> > The corresponding system resources were not released then.
> 
> How do you think about a wording variant like the following?
>
Markus, I think my commit comments is a sufficiently clear description
for this patch. Someone has told me not to send commit comments again
and again when it is enough clear. Because it only wastes the precious
time of the maintainer and very very little help for patch improvement.

BTW, In the past week, you asked me to change the commit comments in my
6 patches like this one. Let me return to the essence of patch, point
out the code problems and better solutions will be more popular.

>    Subject:
>    [PATCH v4] console: newport_con: Fix incomplete releasing of system resources
> 
>    Change description:
>    * A call of the function do_take_over_console() can fail here.
>      The corresponding system resources were not released then.
>      Thus add a call of iounmap() and release_mem_region()
>      together with the check of a failure predicate.
> 
>    * Add also a call of release_mem_region() for the completion
>      of resource clean-up on device removal.
> 
> 
> It can be nicer if all patch reviewers (including me) will be explicitly specified
> as recipients for such messages, can't it?
> 
> Regards,
> Markus
