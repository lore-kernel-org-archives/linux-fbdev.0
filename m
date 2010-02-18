From: Greg KH <greg@kroah.com>
Date: Thu, 18 Feb 2010 16:01:17 +0000
Subject: Re: [PATCH 9/10] udlfb: explicit dependencies and warnings
Message-Id: <20100218160117.GF21785@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245195.4353.3304.camel@bernie-aspireone>
In-Reply-To: <1266245195.4353.3304.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 06:46:35AM -0800, Bernie Thompson wrote:
> Specify Kconfig dependencies, and include warnings for building as a module
> 
> udlfb is dependent on FB_DEFERRED_IO, FB_SYS_*, and FB_MODE_HELPERS
> 
> Because many kernels do not include defio (which cannot be built
> as a module), yet users want to be able to build udlfb as a module later,
> udlfb has ifdefs and these dependency warnings to help udlfb build with or
> without certain dependencies, but also print warnings for any lost function.
> 
> Even though this kind of flexibility isn't common, we've gotten feedback
> from a significant portion of users that they were frustrated without it.

This patch adds the warning to the build:
	drivers/staging/udlfb/udlfb.c:65:2: warning: #warning message "FB_SYS_* in kernel or module option to support fb console"

Any ideas?

thanks,

greg k-h
