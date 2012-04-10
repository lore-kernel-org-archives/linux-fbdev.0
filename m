From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Apr 2012 12:34:42 +0000
Subject: Re: mx3fb overlay support
Message-Id: <Pine.LNX.4.64.1204101420050.7641@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJP5LRNwPXx_sQ=uX4AZDz9HvLdF_nRcoVXBkAWmidVpbdby9g@mail.gmail.com>
In-Reply-To: <CAJP5LRNwPXx_sQ=uX4AZDz9HvLdF_nRcoVXBkAWmidVpbdby9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Alex

On Tue, 10 Apr 2012, alex gershgorin wrote:

> Hi Guennadi,
> 
> In mx3fb current version overlay does not supporting,
> I came across a patch 3/4 v4 i.MX31: framebuffer driver that you submitted
> in 2008,
> there was support Overlay, but for some reason in the next versions overlay
> support has been removed.
> 
> As you understand this is necessary if we want to use the foreground and
> background Planes.
> in my case, one has to display live video, and other graphics.
> 
> I would like to hear your opinion, if may reuse a part of this patch,
> and add overlay support to mx3fb current version.

Maybe this note in the original commit message explains the reason: 
"Overlay support is included but has never been tested." ;-)

> if necessary, I am ready to provide any assistance :-)

Sure, please, re-add it, test, fix, any improvements are welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
