From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 05 Feb 2015 14:20:27 +0000
Subject: Re: [PATCH] au1100fb: Delete unnecessary checks before two function calls
Message-Id: <54D37C2B.2090001@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <54D36CCE.6050401@users.sourceforge.net> <20150205134114.GH5336@mwanda>
In-Reply-To: <20150205134114.GH5336@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> The functions clk_enable() and clk_disable() test whether their argument
>> is NULL and then return immediately.
> 
> This isn't true for clk_enable().

I stumble on an interesting name space issue once more.


> It's frustrating that you make the same mistake over and over
> and you are fine with doing that.

I admit that there can be also risks with my update suggestions
in similar ways to contributions from other software developers.

A specific function implementation exists which performs also input
parameter validation.
http://lxr.free-electrons.com/source/drivers/sh/clk/core.c#L291

Such variants might not fit to the functions au1100fb_drv_suspend()
and au1100fb_drv_resume().


Do you want that I send a reduced patch?

Regards,
Markus
