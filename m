From: James Simmons <jsimmons@infradead.org>
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
Date: Wed, 11 Dec 2002 06:36:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212110636000.2617-100000@maxwell.earthlink.net>
References: <A042D564F44@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <A042D564F44@vcnet.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, adaplas@pol.net


> > int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> > {
> >         int xoffset = var->xoffset;
> >         int yoffset = var->yoffset;
> >         int err;
> >
> >         if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||
>
> I'm probably missing something important, but do not you want
>                                            !info->fbops->fb_pan_display
> instead?

Oops. Typo to the screen. That wasn't commited :-)
