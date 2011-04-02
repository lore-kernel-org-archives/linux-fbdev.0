From: Mike Frysinger <vapier.adi@gmail.com>
Date: Sat, 02 Apr 2011 05:05:57 +0000
Subject: Re: [PATCH 6/6] drivers/video/bfin-lq035q1-fb.c: introduce missing kfree
Message-Id: <BANLkTinF-Z_1J8UiPJ0wnaDLxgHRv0MsPw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301667827-20056-6-git-send-email-julia@diku.dk>
In-Reply-To: <1301667827-20056-6-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: Paul Mundt <lethal@linux-sh.org>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 1, 2011 at 10:23, Julia Lawall wrote:
> Error handling code following a kmalloc should free the allocated data.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
