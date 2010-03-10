From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 17:42:10 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
In-Reply-To: <21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>


> >> At the moment the problem with fbset is what to do with it in the
> >> dual head case. Currently we create an fb console that is lowest
> >> common size of the two heads and set native modes on both,
> >
> > Does that mean that fbset is supposed to work (set resolution) on drmfb?
> 
> No we've never hooked it up but it could be made work.

I had it to the point of almost working. I plan on working on getting it 
working again.
 
> > Schemes which would make a multihead setup look like a single screen
> > get complicated quite easily. Perhaps an option to turn off some
> > outputs so that the native resolution of one output is used (instead
> > of clone) would work.
> >
> 
> I've only really got two answer for this:
> 
> (a) hook up another /dev/dri/card_fb device and use the current KMS
> ioctls to control the framebuffer, have the drm callback into fbdev/fbcon
> to mention resizes etc. Or add one or two info gathering ioctls and
> allow use of the /dev/dri/control device to control stuff.
> 
> (b) add a lot of ioctls to KMS fbdev device, which implement some sort
> of sane multi-output settings.
> 
> Now the second sounds like a lot of work if not the correct solution,
> you basically needs a way to pretty much expose what the KMS ioctls
> expose on the fb device, and then upgrade fbset to make sense of it all.

Yuck. See my other post about what fbdev really means in its historical 
context. The struct fb_info really maps better to drm_crtc than to 
drm_framebuffer. In fact take the case of the matrox fbdev driver. It  
creates two framebuffer devices even tho it used one static framebuffer.
What the driver does is splits the framebuffer in two and assigned each 
part to a CRTC.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
