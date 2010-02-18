From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 18 Feb 2010 22:32:35 +0000
Subject: Re: [PATCH 3/10] udlfb: pre-allocated urb list helpers
Message-Id: <480988181002181432h151c7b3cpd0253b12bf9df229@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245155.4353.3298.camel@bernie-aspireone>
In-Reply-To: <1266245155.4353.3298.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Greg,

On Thu, Feb 18, 2010 at 7:54 AM, Greg KH <greg@kroah.com> wrote:
> I'm not going to reject this patch, but are you sure about this being
> needed?  The code path for creating a new urb is very tiny, just a
> memory allocation.  Is that really noticable in any benchmarks or cpu
> usage that you have found?

You're definitely right, from a performance standpoint, allocating a
fresh urb/buffer each
transfer itself wouldn't be a problem. The big perf win here, over the
older udlfb code, is
the asynchronous dispatch and being able to have several urbs in flight
at once, not the pre-allocation itself.

I actually implemented it first with alloc/free for each transfer
(http://git.plugable.com/gitphp/index.php?p=udlfb&a=commit&h
4fa3b22580fd1532d06292e9061b9b2057f6a6),
but freeing the associated buffer during completion generated WARN_ONs
during each transfer.

Google background on the problem I hit (lots of others hitting, too):
http://www.google.com/search?q=Linux+WARN_ON+dma_free_coherent

I thought about working around by queuing up a deferred op to free
buffers outside of interrupt context, but that raised overhead
concerns and leak concerns.

So that led to the current udlfb implementation, which is a pretty
common and efficient pattern, in the drivers I've known.  And it's
well tested at this point.

usb-skel needs to also deal with this same WARN_ON issue, as others
are hitting this same problem -- something like the udlfb
implementation (using internal list anchor, rather than externally
allocated one) may be a good way to go.

Best wishes,
Bernie
