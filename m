From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 15 Jun 2015 05:29:13 +0000
Subject: Re: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus dr
Message-Id: <20150615051712.GA21087@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
 <20150613001849.GB5234@kroah.com>
 <20150613084618.GA6492@sudip-PC>
 <20150613162839.GA14842@kroah.com>
 <1434214625.2507.9.camel@perches.com>
In-Reply-To: <1434214625.2507.9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Sat, Jun 13, 2015 at 09:57:05AM -0700, Joe Perches wrote:
> 
> It seems ready to me.
> 
> As far as I can tell, there's just a few niggles
> that could be done:
> 
> Something like (too lazy to separate them into multiple patches)
Thanks.	I will break into patches. Call me lazy for not having it done
till now.
> 
> o reduce indentation a couple of places
> o add newlines to logging messages
> o add const to static array
> o use consistent function declaration style
> 
> It's unfortunate there are so many #ifdef __BIG_ENDIAN uses.
instead of #ifdef __BIG_ENDIAN can i then use a bool flag to check by if-else?

regards
sudip
