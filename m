From: Marek Vasut <marex@denx.de>
Date: Mon, 18 Mar 2013 22:17:53 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <201303182317.53616.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363630997-5254-1-git-send-email-marex@denx.de>
 <201303182231.22749.marex@denx.de> <20130318220134.GC5062@elie.Belkin>
In-Reply-To: <20130318220134.GC5062@elie.Belkin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jonathan,

> Marek Vasut wrote:
> >  - It or an equivalent fix must already exist in Linus' tree (upstream).
> > 
> > This can not happen, the fix in Linus' tree will have to be different
> > since in v3.9 there is one more MX28 platform which also needs fixing. I
> > suppose I will now wait for Shawn to merge the patch for 3.9-rc, get it
> > mainline and then this one can be merged?
> 
> Yes, please write again with a patch referencing the upstream commit
> id when this has been fixed upstream.

Roger that, will do. Is that all that needs repairing in the patch?

Thank you!

Best regards,
Marek Vasut
