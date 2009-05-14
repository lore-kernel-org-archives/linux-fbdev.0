From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] staging: misplaced parentheses?
Date: Fri, 15 May 2009 09:24:19 +1000
Message-ID: <1242343459.1867.27.camel@pasglop>
References: <4A0C0C4E.6070401@gmail.com>
	<20090514093827.33a099f7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <benh@kernel.crashing.org>) id 1M4kIY-00029p-Vi
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 23:25:10 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4kIM-0002kt-Hi
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 23:25:05 +0000
In-Reply-To: <20090514093827.33a099f7.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Thu, 2009-05-14 at 09:38 -0700, Andrew Morton wrote:
> > Subject: [PATCH] staging: misplaced parentheses?
> 
> The title is wrong.
> 
> On Thu, 14 May 2009 14:19:26 +0200
> Roel Kluin <roel.kluin@gmail.com> wrote:
> 
> > The leftmost `+' has a higher precedence than the `?' so this returns
> > (vres * hres * (1 << color_mode) + (VMODE && CMODE) ? 0x10 : 0x20) + 0x1000
> 
> That seems OK.

Yes, the original code looks ok and the patches one not quite ...

The idea is that the framebuffer is offset by 0x1020 normally, except
when the video mode is VMODE_832_624_75 and the depth > 8 in which case
it's offet by 0x1010. It's a weird piece of HW but I think the original
code is correct. Or do I miss something ?

Cheers,
Ben.

> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > The original code looks odd, but I am not entirely certain whether my patch is
> > correct. So please review.
> > 
> > diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
> > index 03b3670..a88f4b6 100644
> > --- a/drivers/video/platinumfb.c
> > +++ b/drivers/video/platinumfb.c
> > @@ -224,7 +224,7 @@ static inline int platinum_vram_reqd(int video_mode, int color_mode)
> >  	return vmode_attrs[video_mode-1].vres *
> >  	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
> >  		((video_mode == VMODE_832_624_75) &&
> > -		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
> > +		 (color_mode > CMODE_8) ? 0x10 : 0x20)) + 0x1000;
> >  }
> >  
> >  #define STORE_D2(a, d) { \
> 
> The patch changes it to
> 
> (vres * hres * (1 << color_mode) + (VMODE && (CMODE ? 0x10 : 0x20)) + 0x1000
> 
> I think?  It makes no sense to do (foo && non-zero-value).
> 
> ------------------------------------------------------------------------------
> The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> production scanning environment may not be a perfect world - but thanks to
> Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
> Series Scanner you'll get full speed at 300 dpi even with all image 
> processing features enabled. http://p.sf.net/sfu/kodak-com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
