From: James Simmons <jsimmons@infradead.org>
Date: Mon, 15 Mar 2010 18:38:02 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003151830070.16108@casper.infradead.org>
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
In-Reply-To: <1268566880.9302.65.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, DRI development list <dri-devel@lists.sourceforge.net>


> > The big issue we have with resizing the buffer is userspace mmaps of the fbdev
> > device, and invalidation.
> > Previous thread of unresolvedness is here.
> > http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg41878.html
> 
> Actually AFAIR (and reading through it again seems to confirm this)
> userspace mappings should be fully handled by the last patch series I
> posted back then[0]. The problem was that the struct fb_ops hooks may be
> called by the kernel from pretty much any context, and neither I nor
> Thomas was sure how to handle the TTM locking given that. Maybe James
> has ideas for this given his better familiarity with fbdev internals.

The fb_ops can only be called from fbcon or the fbdev userland interface. 
The fbcon calls should only happen when the VC is in KD_TEXT mode. Now 
with the DRM backend we have the advantage of creating a mapping seperate 
from the console mapping. A fb_open/fb_close could be used to cleaning up 
the userland mmap as well as handle the console pinning. We can supply 
your own fb_mmap hook.

> [0] Though that was really only about making it possible to unpin the
> fbcon BO while it isn't being displayed, resizing it might involve other
> issues I'm not aware of.

Yeap, but both problems are related. Kill two birds with one stone.
