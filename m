From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 10 Mar 2015 15:33:12 +0000
Subject: Re: [PATCH v2] staging: sm750fb: Fix sparse warning
Message-Id: <CAA5enKbsb4qTHOH=+YfKGsaWj+9KsQPf-k00Z2x7n-kbvu=DFA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425977519-4810-1-git-send-email-lstoakes@gmail.com>
	<20150310150612.GA22560@kroah.com>
In-Reply-To: <20150310150612.GA22560@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 March 2015 at 15:06, Greg KH <gregkh@linuxfoundation.org> wrote:
> This doesn't apply anymore due to other patches I just took, so can you
> rebase this patch on my latest staging-testing branch of staging.git?

Fixed in v3 of staging: sm750fb: Cleanup the type of mmio75.

> Also, how about someone fixing the real compiler warnings this driver is
> spitting out first, before we worry about sparse warnings?  That's much
> more relevant here as it's keeping the driver from being built in
> linux-next at the moment.
>
> thanks,
>
> greg k-h

I am more than happy to take a look at this later today when I have
the opportunity to do so :)

-- 
Lorenzo Stoakes
https:/ljs.io
