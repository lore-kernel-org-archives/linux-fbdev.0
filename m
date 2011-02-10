From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Thu, 10 Feb 2011 13:01:17 +0000
Subject: Re: [PATCH] mx3fb: Fix parameter to sdc_init_panel
Message-Id: <201102101401.18331.alexander.stein@systec-electronic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297332330-21964-1-git-send-email-alexander.stein@systec-electronic.com>
	<201102101227.26949.alexander.stein@systec-electronic.com>
	<Pine.LNX.4.64.1102101337310.18510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102101337310.18510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 10 February 2011, 13:48:23 Guennadi Liakhovetski wrote:
> > Ok, i will just write about HSYNC the problem about VSYNC is similar.
> > Let's assume we have a display with the following properties.
> > left_margin   = 38
> > right_margin  = 32
> > hsync_len     = 20
> > width         = 800
> > 
> > Without the patch we get the following arguments on sdc_init_panel
> > width           = 800
> > h_start_width   = 38 (left_margin)
> > h_sync_width    = 20 (hsync_len)
> > h_end_width     = 52 = 32 + 20 (right_margin + hsync_len)
> > 
> > So we will write into SDC_HOR_CONF:
> > 
> > reg = ((h_sync_width - 1) << 26) |
> > 
> >     ((width + h_start_width + h_end_width - 1) << 16);
> > 
> > reg = ((20 - 1) << 26) |
> > 
> >     ((800 + 38 + 52 - 1) << 16);
> > 
> > So the value SCREEN_WIDTH get written is
> > width + left_margin + right_margin + hsync_len
> > 
> > which is IMO wrong. The description in the reference manual states:
> > > Screen width minus 1. Specifies the number of pixel clock periods
> > > between the last HSYNC and the new HSYNC.
> > 
> > It should just be: width + left_margin + right_margin
> > I fell accross it, as I have a display with 800 px width and rather big
> > left_margin. The sum got greater than 1023 which is what SCREEN_WIDTH can
> > hold at maximum.
> > 
> > I don't know which display you used, but I guess your right_margin (and
> > lower_margin) needs to be adjusted.
> 
> Ok, agree. But then you need to adjust all current users and have them
> tested... Otherwise, of course, you can just adjust your platform panel
> data to work with the current calculations, even though in principle your
> patch seems to be doing the right thing (tm), according to the manual. But
> if applied as is without fixing all the users, it can very well break
> them...

Ok, I've just seen there are some model defines in mx3fb.c which would also be 
affected.
I'll try to find all mx3fb users and fix their videomodes and repost a new 
patch.

Alexander
