From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 16:46:17 +0000
Subject: Re: [PATCH 6/6] drivers/video/bfin-lq035q1-fb.c: introduce missing kfree
Message-Id: <20110406164617.GD11820@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301667827-20056-6-git-send-email-julia@diku.dk> <BANLkTinF-Z_1J8UiPJ0wnaDLxgHRv0MsPw@mail.gmail.com>
In-Reply-To: <BANLkTinF-Z_1J8UiPJ0wnaDLxgHRv0MsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 02, 2011 at 01:05:57AM -0400, Mike Frysinger wrote:
> On Fri, Apr 1, 2011 at 10:23, Julia Lawall wrote:
> > Error handling code following a kmalloc should free the allocated data.
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>

Applied, thanks.
