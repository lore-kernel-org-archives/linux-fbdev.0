From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 19:28:00 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915202800.6320826a@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<4E724659.5080709@gmx.de>
	<20110915195804.4e6d965b@lxorguk.ukuu.org.uk>
	<4E724F93.1050203@gmx.de>
In-Reply-To: <4E724F93.1050203-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>
Cc: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> As you have DRM now and as I'm not interested in wayland I won't discuss this,
> but I guess it might be a good start for Geert's question what would be needed
> to use it on dumb framebuffers.

GMA500 is basically a 2D or dumb frame buffer setup but with a lot of
rather complicated output and memory management required due to the
hardware. With the latest changes to GEM (private objects) it's basically
trivial to use the frame buffer management interfaces.

> Yes, if you limit DRM to the functionality of the fb API I guess you could reach
> the same stability level. But where can I do this? Where is a option to forbid
> all acceleration or at least limit to the acceleration that can be done without
> any risk?

A driver can provide such module options as it wants.

> That's a really difficult question. Determining the users is difficult and there
> are people that use their hardware very long, for example we are about to get a
> new driver for i740. For the framebuffer infrastructure I guess you have to at
> least wait for my death.

I doubt it'll be that long - but you are right it will take time and
there isn't really any need to push or force it. These things take care
of themselves and in time nobody will care about the old fb stuff, either
because DRM covers it all or equally possibly because it doesn't support
3D holographic projection 8)

Alan
