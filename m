From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 06 Jun 2011 16:16:51 +0000
Subject: Re: [PATCH 21/29] s3fb: use display information in info not in var for panning
Message-Id: <201106061816.51350.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tormod,

On Friday 03 June 2011 11:26:51 Tormod Volden wrote:
> On Thu, May 26, 2011 at 6:31 PM, Laurent Pinchart  wrote:
> > On Thursday 26 May 2011 16:12:21 Tormod Volden wrote:
> >> On Thu, May 26, 2011 at 12:58 AM, Laurent Pinchart wrote:
> >> > We must not use any information in the passed var besides xoffset,
> >> > yoffset and vmode as otherwise applications might abuse it. Also use
> >> > the aligned fix.line_length and not the (possible) unaligned
> >> > xres_virtual.
> >> > 
> >> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> > Cc: Antonino Daplas <adaplas@gmail.com>
> >> > ---
> >> >  drivers/video/savage/savagefb_driver.c |   16 +++++++---------
> >> >  1 files changed, 7 insertions(+), 9 deletions(-)
> >> 
> >> The patch title is misleading, this is not the s3fb driver but the
> >> savagefb driver.
> > 
> > Yes, sorry about that. I've fixed the patch title, as well as the next
> > patch.
> 
> Hi Laurent,
> I haven't seen any updated patch posted,

That's because I haven't posted the updated patches yet :-) I was waiting for 
more review.

> but anyway, the patch looks otherwise correct to me, and I have tested it on
> my Savage TwisterK:
> 
> Reviewed-by: Tormod Volden <debian.tormod@gmail.com>

Thank you.

It's been a week and a half since I posted the first version, I'll now send an 
updated one with correct titles and Acked-by/Reviewed-by lines.

-- 
Regards,

Laurent Pinchart
