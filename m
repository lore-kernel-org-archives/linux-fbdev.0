From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 06:12:03 +0000
Subject: Re: [PATCH 3/4] drivers/video/bf537-lq035.c: Add missing IS_ERR test
Message-Id: <20110125061203.GD11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295898922-18822-1-git-send-email-julia@diku.dk> <1295898922-18822-4-git-send-email-julia@diku.dk> <201101241543.19543.vapier@gentoo.org>
In-Reply-To: <201101241543.19543.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Julia Lawall <julia@diku.dk>, kernel-janitors@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 24, 2011 at 03:43:17PM -0500, Mike Frysinger wrote:
> On Monday, January 24, 2011 14:55:21 Julia Lawall wrote:
> > lcd_device_register may return ERR_PTR, so a check is added for this value
> > before the dereference.  All of the other changes reorganize the error
> > handling code in this function to avoid duplicating all of it in the added
> > case.
> > 
> > In the original code, in one case, the global variable fb_buffer was set to
> > NULL in error code that appears after this variable is initialized.  This
> > is done now in all error handling code that has this property.
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>

Applied, thanks.
