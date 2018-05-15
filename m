From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 15 May 2018 16:23:09 +0000
Subject: Re: [PATCH v1] video: fbdev: pxafb: Convert to use match_string() helper
Message-Id: <e742b940e9a980862a6a7a87b62ce37acff1855b.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2018-05-15 at 18:06 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, May 15, 2018 02:17:35 PM Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday, May 15, 2018 02:59:20 PM Andy Shevchenko wrote:

> > It is already merged in publicly available tree (which is not being
> > rebased) so it is too late to drop it completely.

Oh, sorry for that.

> OK, I fixed it myself with the patch below.
> 

> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] video: fbdev: pxafb: match_string() conversion fixup
> 
> "unknown" lcd_types[] entry is needed for proper operation of
> the driver, add it back.

Yes, that's correct now.

I was thinking that we perhaps add a comment that the list of these
names should be in sync with definitions in the header.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
