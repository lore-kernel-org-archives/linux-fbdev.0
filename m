From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Thu, 10 Feb 2011 11:27:26 +0000
Subject: Re: [PATCH] mx3fb: Fix parameter to sdc_init_panel
Message-Id: <201102101227.26949.alexander.stein@systec-electronic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297332330-21964-1-git-send-email-alexander.stein@systec-electronic.com>
	<Pine.LNX.4.64.1102101136320.15087@axis700.grange>
	<Pine.LNX.4.64.1102101158510.17898@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102101158510.17898@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 10 February 2011, 12:00:09 Guennadi Liakhovetski wrote:
> On Thu, 10 Feb 2011, Guennadi Liakhovetski wrote:
> > On Thu, 10 Feb 2011, Alexander Stein wrote:
> > > h_end_width and v_end_width should only contain the front porches.
> > > Otherwise, SCREEN_WIDTH (pixel clocks between HSYNC) in SDC_HOR_CONF
> > > and SCREEN_HEIGHT (rows between VSYNC) in SDC_VER_CONF get false
> > > values.
> > 
> > Hm, no, this corrupts image on my pcm990 test-board. What makes you think
> > this patch is needed? How do you see, that current values are "false?"

Ok, i will just write about HSYNC the problem about VSYNC is similar.
Let's assume we have a display with the following properties.
left_margin   = 38
right_margin  = 32
hsync_len     = 20
width         = 800

Without the patch we get the following arguments on sdc_init_panel
width           = 800
h_start_width   = 38 (left_margin)
h_sync_width    = 20 (hsync_len)
h_end_width     = 52 = 32 + 20 (right_margin + hsync_len)

So we will write into SDC_HOR_CONF:

reg = ((h_sync_width - 1) << 26) |
    ((width + h_start_width + h_end_width - 1) << 16);
reg = ((20 - 1) << 26) |
    ((800 + 38 + 52 - 1) << 16);

So the value SCREEN_WIDTH get written is
width + left_margin + right_margin + hsync_len
which is IMO wrong. The description in the reference manual states:
> Screen width minus 1. Specifies the number of pixel clock periods between
> the last HSYNC and the new HSYNC.
It should just be: width + left_margin + right_margin
I fell accross it, as I have a display with 800 px width and rather big 
left_margin. The sum got greater than 1023 which is what SCREEN_WIDTH can hold 
at maximum.

I don't know which display you used, but I guess your right_margin (and 
lower_margin) needs to be adjusted.

> > > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > > ---
> > > 
> > >  drivers/video/mx3fb.c |    7 +++----
> > >  1 files changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> > > index ef71e56..9040833 100644
> > > --- a/drivers/video/mx3fb.c
> > > +++ b/drivers/video/mx3fb.c
> > > @@ -881,12 +881,11 @@ static int __set_par(struct fb_info *fbi, bool
> > > lock)
> 
> Also just occurred to me - your offset of 881 lines is 100 lines below my
> offset for the same code - against what tree is this patch, or do you have
> some local changes there? Can it be, that that's the reason for your
> problem?

Oh, I didn't rebase this patch on current linux git. This patch is on my 
2.6.34 kernel. Anyway, since 2.6.34 there are no related patches on mx3fb.c.

Alexander
