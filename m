From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 21 Sep 2010 10:44:35 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <1285065875.8555.233.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>	<4C963E99.9080207@gmx.de>
	 <20100919190240.65762511@neptune.home>  <4C97B079.8050707@gmx.de>
In-Reply-To: <4C97B079.8050707@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Mon, 2010-09-20 at 21:05 +0200, Florian Tobias Schandinat wrote: 
> 
> Bruno Prémont schrieb:
> > 
> > On Sun, 19 September 2010 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> >>
> >> Bruno Prémont schrieb:
> >>> For USB-attached (or other hot-(un)pluggable) framebuffers the current
> >>> fbdev infrastructure is not very helpful. Each such driver currently
> >>> needs to perform the ref-counting on its own in .fbops.fb_open and
> >>> .fbops.fb_release callbacks.
> >> I agree. This is a great idea even for non-hot-(un)pluggable framebuffers.
> > 
> > Yes, things like drmfb and drivers of multi-head capable framebuffer
> > drivers would certainly appreciate as well, but they will probably also
> > want to care about users (of fb_info.screen_base).
> 
> I don't see any special users of fb_info.screen_base. It's only used for 
> software fallbacks of acceleration functions and fb_read/fb_write (which I'd 
> consider rare to fb_mmap). The bad thing of screen_base is that it can make 
> viafb try to map up to 512MB on 32 bit systems...
> Much more painful IMHO are the mmaped areas in userspace which essentially 
> prevent moving around of the screen framebuffer inside the video ram.

Actually, FWIW, when I tried to fix the framebuffer being pinned at a
fixed location in VRAM all the time in radeondrmfb, the userspace
mappings didn't seem to be any particular problem thanks to TTM. The
problem was the framebuffer CPU access by fbcon, as it can happen from
pretty much any context. The only possible solution at this point seems
to be to prevent fbcon CPU access completely by providing accelerated
versions of all its relevant hooks.


-- 
Earthling Michel Dänzer           |                http://www.vmware.com
Libre software enthusiast         |          Debian, X and DRI developer
