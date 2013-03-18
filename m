From: Jonathan Nieder <jrnieder@gmail.com>
Date: Mon, 18 Mar 2013 22:01:34 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <20130318220134.GC5062@elie.Belkin>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363630997-5254-1-git-send-email-marex@denx.de>
 <20130318185810.GA11040@kroah.com>
 <201303182231.22749.marex@denx.de>
In-Reply-To: <201303182231.22749.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Marek Vasut wrote:

>  - It or an equivalent fix must already exist in Linus' tree (upstream).
> This can not happen, the fix in Linus' tree will have to be different since in 
> v3.9 there is one more MX28 platform which also needs fixing. I suppose I will 
> now wait for Shawn to merge the patch for 3.9-rc, get it mainline and then this 
> one can be merged?

Yes, please write again with a patch referencing the upstream commit
id when this has been fixed upstream.

Thanks and hope that helps,
Jonathan
