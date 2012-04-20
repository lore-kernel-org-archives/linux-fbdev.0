From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 20 Apr 2012 15:57:34 +0000
Subject: Re: [PATCH 2/4] misc: add LM3533 ambient light sensor driver
Message-Id: <20120420155734.GE8327@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334935826-12527-1-git-send-email-jhovold@gmail.com>
 <1334935826-12527-3-git-send-email-jhovold@gmail.com>
In-Reply-To: <1334935826-12527-3-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <jhovold@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Apr 20, 2012 at 05:30:24PM +0200, Johan Hovold wrote:
> Add sub-driver for the ambient light sensor in National Semiconductor /
> TI LM3533 lighting power chips.
> 
> Raw ADC values as well as current ALS zone can be retrieved through
> sysfs. The ALS zone can also be read using a character device
> (/dev/lm3533-als) which is updated on zone changes (interrupt driven or
> polled).
> 
> The driver provides a configuration interface through sysfs.

Which seems to not be documented at all :(

What about using the iio interface for this instead?  Doesn't that
already provide this standard interface you are looking for?

thanks,

greg k-h
