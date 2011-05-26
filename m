From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 May 2011 08:17:45 +0000
Subject: Re: [PATCH 00/29] Use display information in info not in var for panning
Message-Id: <201105261017.45838.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

On Thursday 26 May 2011 07:23:36 Geert Uytterhoeven wrote:
> On Thu, May 26, 2011 at 00:57, Laurent Pinchart wrote:
> > While playing with the FBIOPAN_DISPLAY ioctl I noticed that many drivers
> > use information from the ioctl argument such as the display resolution
> > when they should use the current settings from the fb_info structure.
> 
> Haven't gone through all patches, but the above is correct.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks.

I will wait a couple of days for individual drievr maintainers to reply. I 
don't expect to get an ack for every driver, so we will have to decide whether 
to apply some of the patches without testing them.

-- 
Regards,

Laurent Pinchart
