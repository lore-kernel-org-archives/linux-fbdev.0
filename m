From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 24 Nov 2011 12:58:53 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <20111124125853.6ddc1a56@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
	<CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
In-Reply-To: <CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> The thing is this is how optimus works, the nvidia gpus have an engine
> that you can program to move data from the nvidia tiled VRAM format to

This is even more of a special case than DisplayLink ;-)

> Probably a good idea to do some more research on intel/nvidia GPUs.
> With intel you can't read back from UMA since it'll be uncached memory
> so unuseable, so you'll need to use the GPU to detile and move to some
> sort of cached linear area you can readback from.

It's main memory so there are various ways to read it or pull it into
cached space.

> I merge this VCRTC stuff I give a lot of people an excuse for not
> bothering to fix the harder problems that hotplug and dynamic GPUs put
> in front of you.

I think both cases are slightly missing the mark, both are specialist
corner cases and once you add things like cameras to the mix that will
become even more painfully obvious.

The underlying need I think is a way to negotiate a shared buffer format
or pipeline between two devices. You also need in some cases to think
about shared fencing, and that is the bit that is really scary.

Figuring out the transform from A to B ('lets both use this buffer
format') or 'I can render then convert' is one thing. Dealing with two
GPUs firing into the same buffer while scanning it out I just pray
doesn't ever need shared fences.

Alan


