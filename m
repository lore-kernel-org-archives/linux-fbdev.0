From: Greg KH <greg@kroah.com>
Date: Thu, 18 Feb 2010 16:02:23 +0000
Subject: Re: [PATCH 6/10] udlfb: Rework startup and teardown to fix race
Message-Id: <20100218160223.GG21785@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245173.4353.3301.camel@bernie-aspireone>
In-Reply-To: <1266245173.4353.3301.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 06:46:13AM -0800, Bernie Thompson wrote:
> Rework probe to use refcounts and std functions
> 
> Because the different parts of the driver (usb, fbdev) tear down
> in different orders, the driver previously could crash accessing
> data that had already been freed.  Refcounting system used to handle.
> 
> Reworked probe to make use of refcounts, set mode using std fbops,
> and set up sysfs and pre-allocated urbs.

This patch adds the following warnings to the build:
	drivers/staging/udlfb/udlfb.c:1439: warning: ignoring return value of ‘device_create_file’, declared with attribute warn_unused_result
	drivers/staging/udlfb/udlfb.c:1441: warning: ignoring return value of ‘device_create_bin_file’, declared with attribute warn_unused_result

care to fix it up with a follow-on patch?

thanks,

greg k-h
