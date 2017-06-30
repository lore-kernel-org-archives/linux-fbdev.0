From: Joe Perches <joe@perches.com>
Date: Fri, 30 Jun 2017 03:47:57 +0000
Subject: Re: [PATCH] uvesafb: use pr_cont when printing multiple parameters on the same line
Message-Id: <1498794477.2739.12.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1706292214580.21823@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1706292214580.21823@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Michal Januszewski <spock@gentoo.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-06-29 at 22:16 -0400, Mikulas Patocka wrote:
> The kernel automatically inserts newlines between printk calls unless
> pr_cont is used. This patch changes the uvesafb log message from:

Should be fixed in -next already.

commit a8feae091106 ("uvesafb: Fix continuation printks without
KERN_LEVEL to pr_cont, neatening")

