From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 17:35:01 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003101719030.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
In-Reply-To: <a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Suchanek <hramrach@centrum.cz>
Cc: David Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius Zaleckas <paulius.zaleckas@gmail.com>


> On 21 November 2009 05:27, Dave Airlie <airlied@gmail.com> wrote:
> 
> > At the moment the problem with fbset is what to do with it in the
> > dual head case. Currently we create an fb console that is lowest
> > common size of the two heads and set native modes on both,
> 
> Does that mean that fbset is supposed to work (set resolution) on drmfb?

Yes it could work. No it doesn't work.
 
> >
> > Now if a user runs fbset, I'm not sure what the right answer is,
> > a) pick a head in advance via sysfs maybe and set it on that.
> > b) try and set the mode on both heads cloned (what to do if
> > there is no common mode is another issue).
> >
> 
> I would say it's time to support multihead with fbset properly.
> 
> That is people would need new fbset which sees both (all) heads, and
> fbset can then choose the head itself (and people can make it do
> something different when they don't like the default). It should also
> support setting up rotation on each head.
> 
> For old fbset setting something visible is probably good enough.
> 
> Schemes which would make a multihead setup look like a single screen
> get complicated quite easily. Perhaps an option to turn off some
> outputs so that the native resolution of one output is used (instead
> of clone) would work.

	Before we go there you have to reflect on what the original reason was to 
have a framebuffer layer. The point to have a VT console terminal on 
platforms that lacked hardware that supported native text mode hardware. 
In other words had no vga text mode. A VT terminal is just a keyboard and 
a display. In fact in the old days you had to write framebuffer console 
drivers with things like con_putcs, con_write. Then the api was changed to 
make driver writing simple. The struct fb_info represented your graphics 
card.
	Of course at that time we also had hardware that supported more 
than one crtc which made things more complex. This was reflected in the 
new api. Struct fb_info was moved in the direction to represent the 
display. Remember the terminal only really cares about the display. Inside 
struct fb_info we have a void *par that was a pointer to some structure 
that represented the graphics card itself. So in the case of multi-head 
systems you could have two struct fb_info and one shared *par. That way if 
you wanted to changed the resolution on one screen the check_var function 
could using the *par to test if the hardware could support both 
resolutions at the same time. 
	Note also there is exist a sysfs that allows you to migrate your 
second fbdev devices to a new terminal. Also problems exist in the upper 
console layers that prohibit true multi-desktop systems.

