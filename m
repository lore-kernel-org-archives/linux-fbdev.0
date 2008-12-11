From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/4 v2] dmaengine: add a tx_free method to struct
 dma_async_tx_descriptor
Date: Thu, 11 Dec 2008 17:56:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812111750130.6881@axis700.grange>
References: <Pine.LNX.4.64.0812101122250.4578@axis700.grange> 
 <Pine.LNX.4.64.0812101129340.4578@axis700.grange> 
 <e9c3a7c20812101158h3de9c604i1c88bb7c412ccf02@mail.gmail.com> 
 <Pine.LNX.4.64.0812110011440.8273@axis700.grange> 
 <e9c3a7c20812101801r19c8fb40s6b8ce9bd6c565fed@mail.gmail.com> 
 <Pine.LNX.4.64.0812111639540.6881@axis700.grange>
 <e9c3a7c20812110843p32d768c1k8e119d23b12a5fd0@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758203AbYLKQ45@vger.kernel.org>
In-Reply-To: <e9c3a7c20812110843p32d768c1k8e119d23b12a5fd0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 11 Dec 2008, Dan Williams wrote:

> On Thu, Dec 11, 2008 at 8:55 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> >
> > Sorry, actually, it's not VIDIOC_DQBUF where we have to free buffer(s),
> > it's VIDIOC_STREAMOFF. And in a normal case there are no more completion
> > interrupts, no allocation requests, and noone is interested in
> > is_tx_complete. Normally you would just get a dma_release_channel after
> > that. Or, of course, the application may decide to restart capture, then
> > we get requests, completions, etc. again. So, yes, I could do this, it
> > just seems a bit unnatural to me.
> 
> Could the application tolerate another call to dma_request_channel
> when it restarts?  I.e. just call dma_release_channel from the ioctl
> to clean everything up and not worry about another free() mechanism?

For V4L - yes, I could do this. But is it a good idea to hard-code into a 
"generic" dma driver (or at least something that pretends to be a generic 
driver), that descriptors can only ever be freed by releasing the 
channel?...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
