From: David Eger <eger@theboonies.us>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against
	2.6.7-rc2)
Date: Thu,  3 Jun 2004 13:01:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1086285678.40bf676e1da4d@mail.theboonies.us>
References: <20040603023653.GA20951@havoc.gtf.org>
	<200406032307.13121.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S263733AbUFCSB0@vger.kernel.org>
In-Reply-To: <200406032307.13121.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>

Quoting "Antonino A. Daplas" <adaplas@hotpop.com>:

> 1. SCROLL_ACCEL = no panning + copyarea;
> 2. SCROLL_REDRAW = no panning + imageblit;
> 3. SCROLL_PAN/SCROLL_WRAP = pan/wrap + copyarea;

Correct.

> Personally, the pseudocode below might be better.
>
> If (pan/wrap is available) {
> 	if (fb reading is fast || accel copyarea is available)
> 		SCROLL_PAN/WRAP;
> 	else
> 		SCROLL_REDRAW; /* since SCROLL_PAN/WRAP_REDRAW not available */
> } else {
> 	if (fb_reading is fast || accel copyarea is available)
> 		SCROLL_ACCEL;
> 	else
> 		SCROLL_REDRAW;
> }

I coded your pseudocode up, and I'm convinced now that you and Thomas are right.
 We should prefer panning when it's available
cat /usr/src/linux/MAINTAINERS is 0.3 seconds instead of 1.5 seconds.

On the down side, panning makes screen corruption for me... time to investigate
to see if fbcon or radeonfb is to blame... perhaps panning is just incompatible
with accel engine at all in radeon...

-dte
