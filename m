From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against 2.6.7-rc2)
Date: Fri, 4 Jun 2004 08:06:38 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200406040806.18437.adaplas@hotpop.com>
References: <20040603023653.GA20951@havoc.gtf.org> <200406032307.13121.adaplas@hotpop.com> <1086285678.40bf676e1da4d@mail.theboonies.us>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265260AbUFDAHU@vger.kernel.org>
In-Reply-To: <1086285678.40bf676e1da4d@mail.theboonies.us>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@theboonies.us>, adaplas@pol.net
Cc: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>

On Friday 04 June 2004 02:01, David Eger wrote:

>
> On the down side, panning makes screen corruption for me... time to
> investigate to see if fbcon or radeonfb is to blame... perhaps panning is
> just incompatible with accel engine at all in radeon...
>

The one time I saw screen corruption with panning was when the console virtual 
rows (p->vrows in fbcon.c) were unconditionally set to var->yres_virtual/
fontheight.  In most cases, this will cause screen corruption (or even a GPU 
crash) when you scroll down to end of virtual memory.  Symptoms are corrupted 
data when you pan to p->vrows, fixed by changing to another console and back 
again.

The correct thing to do is not to scroll to the very end, but scroll only to a 
point where you still have enough fb memory at the end of fbmem to display 1 
screenful of data.  This is done by subtracting several lines to p->vrows as 
illustrated by this code snippet scattered in fbcon.c 

	p->vrows = info->var.yres_virtual / vc->vc_font.height;
	if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
		p->vrows -= (info->var.yres - (vc->vc_font.height * vc->vc_rows)) / 
vc->vc_font.height;
	}

Or this in fbcon_resize()

	p->vrows = var.yres_virtual/fh;
	if (var.yres > (fh * (height + 1)))
		p->vrows -= (var.yres - (fh * height)) / fh;

The above code is scattered because we cannot seem to find a central location 
to strategically place it because of the very confusing console code :-(  

Is it possible that the changes in your development tree might have failed to 
appropriately update p->vrows?

Tony  

P.S.  I believe this corruption was spotted with fix contributed by Thomas 
last year.
