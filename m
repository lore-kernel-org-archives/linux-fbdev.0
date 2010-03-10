From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 18:47:28 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003101819290.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
In-Reply-To: <a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Old FrameBuffer List <linux-fbdev-devel@lists.sourceforge.net>, DRI development list <dri-devel@lists.sourceforge.net>, Dave Airlie <airlied@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, Paulius Zaleckas <paulius.zaleckas@gmail.com>


> >> Yuck. See my other post about what fbdev really means in its historical
> >> context. The struct fb_info really maps better to drm_crtc than to
> >> drm_framebuffer. In fact take the case of the matrox fbdev driver. It
> >> creates two framebuffer devices even tho it used one static framebuffer.
> >> What the driver does is splits the framebuffer in two and assigned each
> >> part to a CRTC.
> >
> > The only problem with that is that it eats a lot of memory for the
> > console which limits X when it starts. On cards with limited vram ,
> > you might not have enough memory left for any meaningful acceleration
> > when X starts.
> 
> It would be nice to find a way to reclaim the console memory for X,
> but I'm not sure that can be done and still provide a good way to
> provide oops support.

	Ah, the power of flags. We had the same issue with user requesting a mode
change or fbcon asking for a different mode. We handled it with the flag 
FBINFO_MISC_USEREVENT. Since you are using KMS as the backend for fbcon you will
have to deal also with the ability to change the resolution with tools like stty.
I can easily see how to do this plus give you more memory like you want :-) 
	For the oops are you talking about printing oops to the screen 
while X is running ? Otherwise if you experience a oops and go back to 
console mode you should be able to view it. The console text buffer is 
independent of the graphics card memory system.

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
