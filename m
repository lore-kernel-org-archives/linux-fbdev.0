From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 May 2011 16:31:43 +0000
Subject: Re: [PATCH 21/29] s3fb: use display information in info not in var for panning
Message-Id: <201105261831.43798.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tormod,

On Thursday 26 May 2011 16:12:21 Tormod Volden wrote:
> On Thu, May 26, 2011 at 12:58 AM, Laurent Pinchart wrote:
> > We must not use any information in the passed var besides xoffset,
> > yoffset and vmode as otherwise applications might abuse it. Also use the
> > aligned fix.line_length and not the (possible) unaligned xres_virtual.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > ---
> >  drivers/video/savage/savagefb_driver.c |   16 +++++++---------
> >  1 files changed, 7 insertions(+), 9 deletions(-)
> 
> The patch title is misleading, this is not the s3fb driver but the
> savagefb driver.

Yes, sorry about that. I've fixed the patch title, as well as the next patch.

-- 
Regards,

Laurent Pinchart
