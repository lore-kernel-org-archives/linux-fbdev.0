From: James Simmons <jsimmons@infradead.org>
Date: Tue, 16 Mar 2010 13:56:38 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003161353200.14714@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
	<alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
	<21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
	<alpine.LFD.2.00.1003131421360.12031@casper.infradead.org>
	<21d7e9971003131301r723f3311p3553ea8a1a86bf0a@mail.gmail.com>
	<1268566880.9302.65.camel@thor.local>
	<alpine.LFD.2.00.1003151830070.16108@casper.infradead.org>
	<1268747186.4176.38.camel@thor.local>
In-Reply-To: <1268747186.4176.38.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, DRI development list <dri-devel@lists.sourceforge.net>


> > The fb_ops can only be called from fbcon or the fbdev userland interface. 
> > The fbcon calls should only happen when the VC is in KD_TEXT mode. Now 
> > with the DRM backend we have the advantage of creating a mapping seperate 
> > from the console mapping. A fb_open/fb_close could be used to cleaning up 
> > the userland mmap as well as handle the console pinning. We can supply 
> > your own fb_mmap hook.
> 
> Again, the issue is not userspace but that fb_ops hooks can be called
> from interrupt context etc.

This should not happen. The VT layer is protected from calling in the 
interrupt context. TNor does fbcon call any fb_ops methods from a irq.
I have to look at the fbdev drivers but to my knowledge none touch any 
memory while in a context. Have you seen this happen before? Please let me 
know do I can fix it right a way.
