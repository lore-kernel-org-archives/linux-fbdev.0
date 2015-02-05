From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 05 Feb 2015 13:41:14 +0000
Subject: Re: [PATCH] au1100fb: Delete unnecessary checks before two function calls
Message-Id: <20150205134114.GH5336@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54D36CCE.6050401@users.sourceforge.net>
In-Reply-To: <54D36CCE.6050401@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Thu, Feb 05, 2015 at 02:14:54PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 5 Feb 2015 14:10:21 +0100
> 
> The functions clk_enable() and clk_disable() test whether their argument
> is NULL and then return immediately.

This isn't true for clk_enable().

"I find it acceptable that some of my update suggestions do not fit
to your quality expectations at the moment." --
https://lkml.org/lkml/2015/1/22/446

It's frustrating that you make the same mistake over and over and you
are fine with doing that.  If you make a mistake and you are fixing a
bug, then hopefully you fix more bugs than you introduce.  If you make a
mistake and you are doing a cleanup then you are really just introducing
bugs and that's not helpful.  I wish you would find something useful to
do instead of sending these patches.  :(

regards,
dan carpenter
