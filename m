From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 10 Mar 2015 15:06:12 +0000
Subject: Re: [PATCH v2] staging: sm750fb: Fix sparse warning
Message-Id: <20150310150612.GA22560@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425977519-4810-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425977519-4810-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 08:51:59AM +0000, Lorenzo Stoakes wrote:
> This patch fixes the following sparse warning:-
> 
> drivers/staging/sm750fb/ddk750_help.c: warning: incorrect type in assignment (different address spaces)
> 
> In addition it eliminates an unnecessary volatile.

This doesn't apply anymore due to other patches I just took, so can you
rebase this patch on my latest staging-testing branch of staging.git?

Also, how about someone fixing the real compiler warnings this driver is
spitting out first, before we worry about sparse warnings?  That's much
more relevant here as it's keeping the driver from being built in
linux-next at the moment.

thanks,

greg k-h
