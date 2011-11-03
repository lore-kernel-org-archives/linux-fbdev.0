From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 03 Nov 2011 17:53:46 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <20111103175346.61da8612@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<e80977e3-0992-454e-8ee2-2944560d3b3d@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <e80977e3-0992-454e-8ee2-2944560d3b3d@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> Well the current plan I had for this was to do it in userspace, I don't think the kernel
> has any business doing it and I think for the simple USB case its fine but will fallover
> when you get to the non-trivial cases where some sort of acceleration is required to move
> pixels around. But in saying that its good you've done what something, and I'll try and spend
> some time reviewing it.

There are some clear advantages in the kernel doing bits of this I think.
The kernel understands device to device DMA, and has a better idea than
userspace about things like buffer alignment internals. It also means
this ultimately can work without X running which is a plus for some
applications (I want a displaylink gadget for my phone but thats another
story 8)).

> I'm also not sure how you deal with tiling etc, you can also start hitting rendering limits,
> where a GPU can render to 4kx4k but you can plug in more USB devices, again I'm hoping to
> solve this in userspace as well.

Tiling has to be handled by the recipient (at least when the fb is shared). The nastier end of
it that I don't see convered in the documentation is the handling of
fencing between cards. Eg if you wanted to do display on one card fed
into a second to do effects processing (think about TV type stuff)

Alan
