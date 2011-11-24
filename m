From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Nov 2011 13:48:26 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <CAPM=9tzv1Vmc81BMwUAYH43K-d8FvWdK3VaLQeyjy2jmH4UP3A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
	<CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
	<20111124125853.6ddc1a56@lxorguk.ukuu.org.uk>
In-Reply-To: <20111124125853.6ddc1a56@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Nov 24, 2011 at 12:58 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> The thing is this is how optimus works, the nvidia gpus have an engine
>> that you can program to move data from the nvidia tiled VRAM format to
>
> This is even more of a special case than DisplayLink ;-)
>
>> Probably a good idea to do some more research on intel/nvidia GPUs.
>> With intel you can't read back from UMA since it'll be uncached memory
>> so unuseable, so you'll need to use the GPU to detile and move to some
>> sort of cached linear area you can readback from.
>
> It's main memory so there are various ways to read it or pull it into
> cached space.

We have no way to detile on the CPU for lots of intel corner cases, I don't hold
out for it being a proper solution, though in theory for hibernate its
a requirement to figure out.
But you can expose stuff via the GTT using fences to detile, but you
can't then get cached access to it.
So no really various ways, none of them useful or faster than getting
the GPU to blit somewhere linear
and flipping the dest mapping.

>
>> I merge this VCRTC stuff I give a lot of people an excuse for not
>> bothering to fix the harder problems that hotplug and dynamic GPUs put
>> in front of you.
>
> I think both cases are slightly missing the mark, both are specialist
> corner cases and once you add things like cameras to the mix that will
> become even more painfully obvious.
>
> The underlying need I think is a way to negotiate a shared buffer format
> or pipeline between two devices. You also need in some cases to think
> about shared fencing, and that is the bit that is really scary.
>
> Figuring out the transform from A to B ('lets both use this buffer
> format') or 'I can render then convert' is one thing. Dealing with two
> GPUs firing into the same buffer while scanning it out I just pray
> doesn't ever need shared fences.

But we have a project looking into all that, called dmabuf, we also
have the PRIME work which we hope to build on top of dmabuf.

The thing is there are lots of building blocks we need to put in
place, and we've mostly identified what they are, its just typing now.

Dave.
