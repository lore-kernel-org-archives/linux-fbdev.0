From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] vgacon: optimize scrolling
Date: Sun, 21 Sep 2008 23:22:17 +0200
Message-ID: <20080921212205.GA5740@joi>
References: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com> <1222012809-5783-2-git-send-email-marcin.slusarz@gmail.com> <20080921203757.455ead71.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753724AbYIUVXS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080921203757.455ead71.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

On Sun, Sep 21, 2008 at 08:37:57PM +0200, Krzysztof Helt wrote:
> On Sun, 21 Sep 2008 18:00:08 +0200
> Marcin Slusarz <marcin.slusarz@gmail.com> wrote:
> 
> > Join multiple scr_memcpyw into 1-3 calls (usually 2).
> > (benchmarked average speedup: 1%)
> > 
> 
> The scr_memcpyw is an inline function so there is no real call here.

... or it's defined to memcpy
 
> However, have you tested the patch with scroll range > 2 *  vgacon_scrollback_size?
>
> It seems that your patch only handles scrolling if it is not bigger than 2 * vgacon_scrollback_size.

No. count is always within range <0, c->vc_rows> (look how it's computed
just before this loop). Second copy is needed only when end of screen
crosses end/beginning of scrollback (it's a circular buffer).

> Regards,
> Krzysztof
> 
> > Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: linux-fbdev-devel@lists.sourceforge.net
> > ---
> >  drivers/video/console/vgacon.c |   28 ++++++++++++++++------------
> >  1 files changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> > index bd1f57b..de4f66c 100644
> > --- a/drivers/video/console/vgacon.c
> > +++ b/drivers/video/console/vgacon.c
> > @@ -292,23 +292,27 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
> >  	d = (void *) c->vc_origin;
> >  	s = (void *) c->vc_screenbuf;
> >  
> > -	while (count--) {
> > -		scr_memcpyw(d, vgacon_scrollback + soff, c->vc_size_row);
> > -		d += c->vc_size_row;
> > -		soff += c->vc_size_row;
> > -
> > -		if (soff >= vgacon_scrollback_size)
> > -			soff = 0;
> > +	if (count) {
> > +		int copysize;
> > +		count *= c->vc_size_row;
> > +		/* how much memory to end of buffer left? */
> > +		copysize = min(count, vgacon_scrollback_size - soff);
> > +		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
> > +		d += copysize;
> > +		count -= copysize;
> > +		
> > +		if (count) {
> > +			copysize = min(count, vgacon_scrollback_size);
> > +			scr_memcpyw(d, vgacon_scrollback, copysize);
> > +			d += copysize;
> > +		}
> >  	}
> >  
> >  	if (diff == c->vc_rows) {
> >  		vgacon_cursor(c, CM_MOVE);
> >  	} else {
> > -		while (diff--) {
> > -			scr_memcpyw(d, s, c->vc_size_row);
> > -			d += c->vc_size_row;
> > -			s += c->vc_size_row;
> > -		}
> > +		if (diff)
> > +			scr_memcpyw(d, s, diff * c->vc_size_row);
> >  	}
> >  
> >  	return 1;
> > -- 
> > 1.5.6.4
