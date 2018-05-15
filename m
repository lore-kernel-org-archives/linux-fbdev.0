From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 15 May 2018 11:59:20 +0000
Subject: Re: [PATCH v1] video: fbdev: pxafb: Convert to use match_string() helper
Message-Id: <71f79c345eb29dcec9ac971e52873726c780e313.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2018-05-15 at 13:54 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, May 15, 2018 02:35:03 PM Andy Shevchenko wrote:
> > On Tue, 2018-05-15 at 12:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday, May 03, 2018 09:04:23 PM Andy Shevchenko wrote:
> > > > The new helper returns index of the matching string in an array.
> > > > We are going to use it here.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
> > > > m>
> > > 
> > > Patch queued for 4.18, thanks.
> > 
> > I went through it again and found a bug, the type "unknown" should
> > be
> > left untouched.
> 
> Indeed, could you provide incremental fix?

Is it late enough to drop patch completely? If so, I do a fix asap.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
