From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:30:56 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
Message-Id: <201109202130.56759.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Monday 11 July 2011 14:35:54 Laurent Pinchart wrote:
> Resuming from runtime PM restores all LCDC registers. If the dot clock
> is off at that time display panning information will be corrupted.
> 
> Turn the dot clock on before resuming from runtime PM. Similarly,
> turn the clock off after suspending the LCDC.

Could you please pick this patch for v3.2 ?

-- 
Regards,

Laurent Pinchart
