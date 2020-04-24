From: Markus Elfring <Markus.Elfring@web.de>
Date: Fri, 24 Apr 2020 16:54:41 +0000
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak related system resources
Message-Id: <20f37865-5af3-5fb9-8b8f-91f9464e4af3@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200423164251.3349-1-zhengdejin5@gmail.com>
In-Reply-To: <20200423164251.3349-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dejin Zheng <zhengdejin5@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

> The corresponding system resources were not released then.

How do you think about a wording variant like the following?

   Subject:
   [PATCH v4] console: newport_con: Fix incomplete releasing of system resources

   Change description:
   * A call of the function do_take_over_console() can fail here.
     The corresponding system resources were not released then.
     Thus add a call of iounmap() and release_mem_region()
     together with the check of a failure predicate.

   * Add also a call of release_mem_region() for the completion
     of resource clean-up on device removal.


It can be nicer if all patch reviewers (including me) will be explicitly specified
as recipients for such messages, can't it?

Regards,
Markus
