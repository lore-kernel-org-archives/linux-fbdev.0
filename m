From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:15:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019211557.GD1142@elf.ucw.cz>
References: <200410160551.40635.adaplas@hotpop.com> <416FFFFD.28877.2F2B6C9@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269406AbUJSVVC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <416FFFFD.28877.2F2B6C9@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > In the case of something like a Mac you would want to keep the
> > display blank until the early user space code initializes the
> > display in graphics mode. Only if you get a fatal error before this
> > would you dump the info using the Open Firmware display. Same
> > strategy would apply to x86. 
> 
> True. On the Mac they use the speakers so the user knows that the machine 
> is booting. Almost immediately after hitting the power you will hear a 
> calming sound coming from the speaker, and it might be another 5 seconds 
> or so before the actual video comes up. 

Heh, I'm trying to do the some in i386 resume case... If you can call
square waves at 600Hz "calming sound" :-). Having video early would
certainly be more welcome.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
