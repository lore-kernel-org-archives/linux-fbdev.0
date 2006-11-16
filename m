From: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: ACPI output/lcd/auxdisplay mess
Date: Thu, 16 Nov 2006 09:45:03 +0100
Message-ID: <653402b90611160045s6ddf1305jdb262ee55b0f16bf@mail.gmail.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031015AbWKPIpH@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>

On 11/15/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > Well, we were aware of video/backlight/* (read below). Anyway,
> > auxdisplay doesn't create a class; it did in first versions, but right
> > now it behaves just like a framebuffer, no classes in the playground
> > (maybe you read a old version?).
> ...
> > However, auxdisplay means "auxiliary display device drivers", not _the
> > display_. In such folder we can put every
> > auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
> > ...) who has special requirements (like parport wiring, fixed refresh
> > rate, different properties...). Also, things like "set_contrast",
> > "max_constrast", "set_power"... didn't seem very appropriate.
>
> Is it a framebuffer device ? The framebuffer layer is abstracted to work
> with such devices.
>

cfag12864bcfb is a "fbdev" (actually, it is a "fb wrapper" for
cfag12864b, so it behaves like a framebuffer, although it is not an
usual framebuffer. f.e. it has asynchronous refresh rate, a mmaped
page to appear to be a fb...).

Still, it is not the front panel lcd of any specific device like PDA,
so people that expects only their primary video/ displays may be
confused if it appears at such section. So we decided to go away from
video/. Maybe we can change the description, as right now it only
refers to front panel lcds.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
