From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Dec 2011 00:21:17 +0000
Subject: Re: [PATCH 24/57] fbdev: sh_mobile_lcdc: Return display connection state in display_on
Message-Id: <201112190121.18444.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-25-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-25-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Thursday 15 December 2011 18:11:03 Guennadi Liakhovetski wrote:
> On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > Return true if the display is connected and false otherwise. Set the fb
> > info state to FBINFO_STATE_SUSPENDED in the sh_mobile_lcdc driver when
> > the display is not connected.
> 
> Hmm... I'm not sure I like functions, that return either a negative error,
> or _several_ non-negative success values. How about returning -ENODEV?

That would be returning a negative error on success. Is that better ? :-)


-- 
Regards,

Laurent Pinchart
