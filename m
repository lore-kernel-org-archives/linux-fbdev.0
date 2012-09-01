From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 01 Sep 2012 06:25:21 +0000
Subject: Re: [PATCHv2 1/4] video: mmp display subsystem
Message-Id: <1779643.rHkRe5xu8y@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346293222-13692-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1346293222-13692-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Zhou,

On Thursday 30 August 2012 10:20:22 Zhou Zhu wrote:
> Added mmp display subsystem to support Marvell MMP display controllers.
> 
> This subsystem contains 4 parts:
> --fb folder
> --core.c
> --hw folder
> --panel folder
> 
> 1. fb folder contains implementation of fb.
> fb get path and ovly from common interface and operates on these structures.
> 
> 2. core.c provides common interface for a hardware abstraction.
> Major parts of this interface are:
> a) Path: path is a output device connected to a panel or HDMI TV.
> Main operations of the path is set/get timing/output color.
> fb operates output device through path structure.
> b) Ovly: Ovly is a buffer shown on the path.
> Ovly describes frame buffer and its source/destination size, offset, input
> color, buffer address, z-order, and so on.
> Each fb device maps to one ovly.
> 
> 3. hw folder contains implementation of hardware operations defined by
> core.c. It registers paths for fb use.
> 
> 4. panel folder contains implementation of panels.
> It's connected to path. Panel drivers would also regiester panels and linked
> to path when probe.

You might want to look at the generic panel framework RFC that I have posted 
recently (http://lwn.net/Articles/512363/).

-- 
Regards,

Laurent Pinchart

