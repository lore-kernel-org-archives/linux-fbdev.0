From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 18 Sep 2011 22:23:29 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110918232329.6ff05d56@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<4E724659.5080709@gmx.de>
	<201109180112.15896.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201109180112.15896.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> This would leave us with the issue of controlling formats and other parameters 
> on the pipelines. We could keep separate DRM, KMS, FB and V4L APIs for that, 

There are some other differences that matter. The exact state and
behaviour of memory, sequencing of accesses, cache control and management
are a critical part of DRM for most GPUs, as is the ability to have them
in swap backed objects and to do memory management of them. Fences and
the like are a big part of the logic of many renderers and the same
fencing has to be applied between capture and GPU, and also in some cases
between playback accelerators (eg MP4 playback) and GPU.

To glue them together I think you'd need to support the use of GEM objects
(maybe extended) in V4L. That may actually make life cleaner and simpler
in some respects because GEM objects are refcounted nicely and have
handles.

DRM and KMS abstract out stuff into what is akin to V4L subdevices for
the various objects the video card has that matter for display - from
scanout buffers to the various video outputs, timings and the like.

I don't know what it's like with OMAP but for some of the x86 stuff
particularly low speed/power stuff the capture devices, GPU and overlays
tend to be fairly incestuous in order to do things like 1080i/p preview
while recording from the camera.

GPU is also a bit weird in some ways because while its normally
nonsensical to do things like use the capture facility one card to drive
part of another, it's actually rather useful (although not supported
really by DRM) to do exactly that with GPUs. A simple example is a dual
headed box with a dumb frame buffer and an accelerated output both of
which are using memory that can be hit by the accelerated card. Classic
example being a USB plug in monitor.
