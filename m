From: Moshe Green <mgmoshes@gmail.com>
Date: Sat, 03 Sep 2016 19:57:50 +0000
Subject: Re: [PATCH 1/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <20160903195750.GA6323@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
 <20160901160446.GA18620@kroah.com>
 <CAJEcRgqM=gLmFVkCY78gkqHDV8jU2i8ST37s8NkjJ77CoxeZrw@mail.gmail.com>
 <20160902113508.GA18456@kroah.com>
In-Reply-To: <20160902113508.GA18456@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com

On Fri, Sep 02, 2016 at 01:35:08PM +0200, Greg KH wrote:
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Fri, Sep 02, 2016 at 11:28:51AM +0300, moshe green wrote:
> > There were (mostly) two kinds of warnings that I've handled, "80
> > character line length" and block comments structure.
> > Some of the changes involve handling two separate warnings in a single comment.
> > Where this occurs, should I break down the change into two steps -
> > fixing a warning at a time?
> > Or should I fix both warnings in the same commit - and place the
> > commit in the most appropriate patch?
> 
> Hm, use your best judgement here, what would you want to be on the
> receiving end of if you had to review such a patch series?
> 
> thanks,
> 
> greg k-h

Will do.

thanks,

Moshe Green
