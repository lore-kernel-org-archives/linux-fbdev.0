From: Timur Tabi <timur@freescale.com>
Date: Tue, 27 Sep 2011 18:37:42 +0000
Subject: Re: [PATCH 2/2] drivers/video: move some definitions from fsl-diu-fb.h
Message-Id: <4E8217F6.9040806@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316624096-5291-2-git-send-email-timur@freescale.com>
In-Reply-To: <1316624096-5291-2-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Timur Tabi wrote:
> Move several macros and structures from the Freescale DIU driver's header
> file into the source file, because they're only used by that file.  Also
> delete a few unused macros.
> 
> The diu and diu_ad structures cannot be moved because they're being used
> by the MPC5121 platform file.  A future patch eliminate the need for
> the platform file to access these structs, so they'll be moved also.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

This patch breaks the MPC5121, so please ignore it.  Sorry about that.

Please ignore Patch 1/2 as well.  I'll just repost both with a bunch of other
patches in a large patchset.

-- 
Timur Tabi
Linux kernel developer at Freescale

