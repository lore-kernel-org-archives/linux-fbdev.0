From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 12 Mar 2015 10:44:00 +0000
Subject: Re: [PATCH] staging: sm750fb: if else block checkpath warnings
Message-Id: <20150312104400.GA22836@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150312103319.GA19906@localhost.localdomain>
In-Reply-To: <20150312103319.GA19906@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra BN <ragavendra.bn@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2015 at 03:33:19AM -0700, Ragavendra BN wrote:
> Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com>
> 

This goes on the bottom of the changelog text.


> This patch fixes the coding style warnings found by checkpath.pl for
> the if else block

It also does something else, so I have to reject this.  Please be very
specific as to what you are doing here.

thanks,

greg k-h
