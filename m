From: Greg KH <greg@kroah.com>
Date: Thu, 18 Feb 2010 15:57:20 +0000
Subject: Re: [PATCH 5/10] udlfb: Add functions to expose sysfs metrics and
Message-Id: <20100218155720.GD21785@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245168.4353.3300.camel@bernie-aspireone>
In-Reply-To: <1266245168.4353.3300.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 06:46:08AM -0800, Bernie Thompson wrote:
> Add sysfs controls for edid and performance metrics
> 
> There are 8 new files exposed in /sys/class/graphics/fb*

All new sysfs files will need a Documentation/ABI/ patch as well to
explain the files.

> 
> edid - returns 128 byte edid blog, suitable for parsing with parse-edid
> metrics_bytes_identical
> metrics_bytes_rendered
> metrics_bytes_sent
> metrics_cpu_kcycles_used

These are all single value files, which is fine.

> metrics_misc

This isn't.  sysfs files are "one value per file".  If you want to do
something else, like this file, I suggest using debugfs instead.

> and metrics_reset, which resets all perf metrics to zero

Actually, why not use debugfs for all of these files?  They aren't
really necessary for any user or tool, and are only a debugging thing.
That's what debugfs was created for :)

thanks,

greg k-h
