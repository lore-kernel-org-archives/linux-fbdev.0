From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Dec 2011 22:10:42 +0000
Subject: Re: Should I use FBINFO_VIRTFB?
Message-Id: <4EEA7062.9050807@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEA5DA7.3010406@freescale.com>
In-Reply-To: <4EEA5DA7.3010406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Konrad Rzeszutek Wilk wrote:
>> > #define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
>> > #define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */

> Not really. They have a different function, but you are better of looking in the code
> to see how they are used.

Well, I tried that, which is why I said, "I don't see any good documentation."  FBINFO_PARTIAL_PAN_OK appears to be only used in one place:

case SCROLL_PAN_REDRAW:
	if ((p->yscroll + count <	     2 * (p->vrows - vc->vc_rows))
	    && ((!scroll_partial && (b - t = vc->vc_rows))
		|| (scroll_partial
		    && (b - t - count >
			3 * vc->vc_rows >> 2)))) {
		if (t > 0)
			fbcon_redraw_move(vc, p, 0, t, count);
		ypan_up_redraw(vc, t, count);
		if (vc->vc_rows - b > 0)
			fbcon_redraw_move(vc, p, b,
				  vc->vc_rows - b, b);
	} else
		fbcon_redraw_move(vc, p, t + count, b - t - count, t);
	fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
break;

I can't parse this, and I can't figure out if my driver is better off with or without FBINFO_PARTIAL_PAN_OK.

I have the same problem with FBINFO_READS_FAST.  

So I really would like someone explain these macros to me.

-- 
Timur Tabi
Linux kernel developer at Freescale

