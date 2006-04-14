From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] Behaviour change of /dev/fb0?
Date: Sat, 15 Apr 2006 07:29:44 +0800
Message-ID: <44403068.3020909@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751424AbWDNXaU@vger.kernel.org>
In-Reply-To: <1145009768.6179.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Richard Purdie wrote:
> Ignoring whether this is a good idea or not, under 2.6.15 you could run
> 
> dd if=/dev/zero of=/dev/fb0
> 
> which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> No space left on device".
> 
> Under 2.6.16 (and a recent git kernel), the same command clears the
> screen but then hangs. Was the change in behaviour intentional? 
> 
> I've noticed this on a couple of ARM based Zaurus handhelds under both
> w100fb and pxafb.
> 

There is a change in behavior of fb_read and fb_write committed Jan 2006.
They return the number of bytes read or written if the requested size
is bigger than the remaining space.  Previously, they returned -ENOSPC.

But I haven't experienced hangs...

Tony
