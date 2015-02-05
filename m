From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 05 Feb 2015 17:18:44 +0000
Subject: Re: [PATCH] au1100fb: Delete unnecessary checks before two function calls
Message-Id: <20150205171844.GL5285@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54D36CCE.6050401@users.sourceforge.net>
 <20150205134114.GH5336@mwanda>
 <54D37C2B.2090001@users.sourceforge.net>
In-Reply-To: <54D37C2B.2090001@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Thu, Feb 05, 2015 at 03:20:27PM +0100, SF Markus Elfring wrote:
> >> The functions clk_enable() and clk_disable() test whether their argument
> >> is NULL and then return immediately.
> > 
> > This isn't true for clk_enable().
> 
> I stumble on an interesting name space issue once more.
> 

The "once more" is the problem in this statement.  Other people would
have stopped making the mistake by now.  I am able to see your bugs so
you should be able to see your bugs as well.

> 
> > It's frustrating that you make the same mistake over and over
> > and you are fine with doing that.
> 
> I admit that there can be also risks with my update suggestions
> in similar ways to contributions from other software developers.
> 

At times, I have told other people to stop sending cleanups until they
can at least fix a bugs to balance out the bugs they have introduced.
It's unacceptable to only introduce bugs and never fix any.

regards,
dan carpenter

