From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fb accel capabilities (resend against 2.6.7-rc2)
Date: Thu, 3 Jun 2004 23:07:13 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406032307.13121.adaplas@hotpop.com>
References: <20040603023653.GA20951@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVtoN-0005lr-8n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 08:07:19 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BVtoM-00007I-QZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 08:07:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 0E50C57D90C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  3 Jun 2004 14:33:03 +0000 (UTC)
In-Reply-To: <20040603023653.GA20951@havoc.gtf.org>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thursday 03 June 2004 10:36, David Eger wrote:

I haven't tested the patch, but here's a few comments:

So, 

1. SCROLL_ACCEL = no panning + copyarea;
2. SCROLL_REDRAW = no panning + imageblit;
3. SCROLL_PAN/SCROLL_WRAP = pan/wrap + copyarea;

Are these correct?

Assuming the above is correct, then the logic in update_scrollmode() may not 
be optimal.

>  static __inline__ void updatescrollmode(struct display *p, struct fb_info
> *info, struct vc_data *vc) {
> -	int m;
> +	int cap = info->flags;
>
> -	if (p->scrollmode & __SCROLL_YFIXED)
> -		return;
> -	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
> -	    divides(vc->vc_font.height, info->var.yres_virtual))
> -		m = __SCROLL_YWRAP;
> -	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
> +	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
> +		p->scrollmode = SCROLL_ACCEL;

We should also check if the hardware is capable of panning/wrapping.  If it 
is, then the scrolling mode should be SCROLL_PAN/WRAP. An accelerated drawing 
function combined with panning/wrapping is extremely fast.

> +	else if ((cap & FBINFO_HWACCEL_YWRAP) &&
> +		 divides(info->fix.ywrapstep, vc->vc_font.height) &&
> +		 divides(vc->vc_font.height, info->var.yres_virtual))
> +		p->scrollmode = SCROLL_WRAP;
> +	else if ((cap & FBINFO_HWACCEL_YPAN) &&
> +		 divides(info->fix.ypanstep, vc->vc_font.height) &&

In the above case, we should also check if accelerated copyarea is availble or 
if fb reading is fast.  Because if fb reading is slow and accel copyarea is 
not available,  the resulting scrolling action will not be smooth. In this 
case, SCROLL_REDRAW may be a better scrolling mode even if it's slower than 
SCROLL_PAN/WRAP.

>  		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
> -		m = __SCROLL_YPAN;
> -	else if (p->scrollmode & __SCROLL_YNOMOVE)
> -		m = __SCROLL_YREDRAW;
> +		p->scrollmode = SCROLL_PAN;
> +	else if (cap & FBINFO_READS_FAST)
> +		/* okay, we'll use software version of accel funcs... */
> +		p->scrollmode = SCROLL_ACCEL;

This is similar with the above.  If panning/wrapping is available and fb 
reading is very fast, then SCROLL_PAN/WRAP is probably preferrable than just 
SCROLL_ACCEL.

>  	else
> -		m = __SCROLL_YMOVE;
> -	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
> +		p->scrollmode = SCROLL_REDRAW;

Ditto.

Personally, the pseudocode below might be better.

If (pan/wrap is available) {
	if (fb reading is fast || accel copyarea is available)
		SCROLL_PAN/WRAP;	
	else 
		SCROLL_REDRAW; /* since SCROLL_PAN/WRAP_REDRAW not available */
} else {
	if (fb_reading is fast || accel copyarea is available)
		SCROLL_ACCEL;
	else
		SCROLL_REDRAW;
}
 
Tony




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
