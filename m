From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 18:58:04 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915195804.4e6d965b@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<4E724659.5080709@gmx.de>
In-Reply-To: <4E724659.5080709@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit@freedesktop.org, Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

> Well, I rather think that the fb API is more user centric to allow every program
> to use it directly in contrast to the KMS/DRM API which aims to support every
> feature the hardware has. For this the fb API should not change much, but I
> understand some additions were needed for some special users, probably limited
> to X and wayland.

Wayland needs vblank frame buffer switching and the like. Likewise given
you want to composite buffers really any serious accelerated device ends
up needing a full memory manager and that ends up needing a buffer
manager. Wayland needs clients to be doing their own rendering into
objects which means authorisation and management of the render engine
which ends up looking much like DRM.

> One of my biggest problems with KMS is that it has (naturally) a lot more
> complexity than the fb API which leads to instability. Basically it's very

It shouldn't do - and a sample of one (your machine) is not a
statistically valid set. Fb is pretty much ununsable in contrast on my
main box, but that's not a statistically valid sample either.

I'm not that convinced by the complexity either. For a simple video card
setup such as those that the fb layer can kind of cope with (ie linear
buffer, simple mode changes, no client rendering, no vblank flipping,
limited mode management, no serious multi-head) a DRM driver is also
pretty tiny and simple.

> Well, I think it's too late to really fix this thing. We now have 3 APIs in the
> kernel that have to be kept. Probably the best we can do now is figure out how
> we can reduce code duplication and do extensions to those APIs in a way that
> they are compatible with each other or completely independent and can be used
> across the APIs.

I think it comes down to 'when nobody is using the old fb drivers they can
drop into staging and oblivion'. Right now the fb layer is essentially
compatibility glue on most modern x86 platforms.

Alan
