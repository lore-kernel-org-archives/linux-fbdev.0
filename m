From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Sat, 20 Mar 2004 22:52:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040320215219.GA20277@dreamland.darkstar.lan>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320213030.GA3950@kroah.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040320213030.GA3950@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Il Sat, Mar 20, 2004 at 01:30:30PM -0800, Greg KH ha scritto: 
> On Sat, Mar 20, 2004 at 06:49:56PM +0100, Kronos wrote:
> > Hi,
> > the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
> > With this patch udev will automagically create device nodes for each
> > framebuffer registered. Once all drivers are converted to
> > framebuffer_{alloc,release} we can switch to our own class.
> 
> yeah, it's about time!  Didn't I post this patch a few months ago... :)

Hum, I remeber your patch that did the same thing, but it didn't use
class_simple, did it?

> Anyway, it looks good, I only have one comment:
> 
> > notebook:~# tree /sys/class/graphics/
> > /sys/class/graphics/
> 
> "graphics"?  Why that?  Why not "fb"?
> 
> It doesn't really matter to me, just curious.

It was discussed a while ago (this is James):

<quote>
On Tue, 9 Sep 2003, Benjamin Herrenschmidt wrote:
> > On Tue, 2003-09-09 at 21:24, Kronos wrote:
> > > +static struct class fb_class = {
> > > + .name           = "video",
> >
> > I'd rather use "display" here. "video" is too broad and will cause
> > confusion with multimedia stuff.
>
> Exactly my comment. I was thinking about `graphics' instead of
> `video', but indeed `display' sounds better. Gr{oetje,eeting}s,

I prefere graphics myself. Display sounds to generic. That is what video
and graphics output is piped to. Since fbdev doesn't handle video ouput
normally this is kind of fuzzy sounding.
</quote>

Luca
-- 
Home: http://kronoz.cjb.net
"Di tutte le perversioni sessuali, la castita` e` la piu` strana".
Anatole France
