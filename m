From: James Simmons <jsimmons@infradead.org>
Date: Thu, 11 Mar 2010 03:41:19 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003110334580.21470@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a5d587fb1003101258j2fca77eek3fa4cd75ea7d0813@mail.gmail.com>
In-Reply-To: <a5d587fb1003101258j2fca77eek3fa4cd75ea7d0813@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, Dave Airlie <airlied@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>


> > Yuck. See my other post about what fbdev really means in its historical
> > context. The struct fb_info really maps better to drm_crtc than to
> > drm_framebuffer. In fact take the case of the matrox fbdev driver. It
> > creates two framebuffer devices even tho it used one static framebuffer.
> > What the driver does is splits the framebuffer in two and assigned each
> > part to a CRTC.
> >
> 
> So you get the layering naturally. On fbset - fbev layer you can
> choose from the resolutions available in the current output setup, in
> kmset or whatever - drm layer you can set up the outputs, merge
> multiple outputs into single cloned fbdev or separate them, ..
> 
> It's obviously nice if you can set the resolution on all of fbcons,
> fbdev and drm layers but getting it work on at least one layer with
> proper propagation up and down also works. BTW I don't know any
> application which sets linux console (or xterm for that matter)
> resolution through the terminal API.

I agree. The mode setting should be done in one layer. Its a matter of 
doing the proper emulation of the fbdev layer.

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
