From: Maksim Salau <maksim.salau@gmail.com>
Date: Mon, 24 Apr 2017 08:06:05 +0000
Subject: Re: [PATCH] video: fbdev: udlfb: Fix buffer on stack
Message-Id: <20170424110605.2366eb8f@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170422164922.9472-1-maksim.salau@gmail.com>
In-Reply-To: <20170422164922.9472-1-maksim.salau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> > +       const u8 set_def_chn[] = {  
> 
> Please make this static, else it will be copied once more by the compiler.
> 
> kmalloc() + memcpy() => kmemdup().
> 

Thanks, Geert!
