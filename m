From: Greg KH <gregkh@suse.de>
Date: Fri, 19 Feb 2010 00:36:14 +0000
Subject: Re: [PATCH 3/10] udlfb: pre-allocated urb list helpers
Message-Id: <20100219003614.GB29873@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245155.4353.3298.camel@bernie-aspireone>
In-Reply-To: <1266245155.4353.3298.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Feb 18, 2010 at 02:32:35PM -0800, Bernie Thompson wrote:
> Hi Greg,
>=20
> On Thu, Feb 18, 2010 at 7:54 AM, Greg KH <greg@kroah.com> wrote:
> > I'm not going to reject this patch, but are you sure about this being
> > needed? =A0The code path for creating a new urb is very tiny, just a
> > memory allocation. =A0Is that really noticable in any benchmarks or cpu
> > usage that you have found?
>=20
> You're definitely right, from a performance standpoint, allocating a
> fresh urb/buffer each
> transfer itself wouldn't be a problem. The big perf win here, over the
> older udlfb code, is
> the asynchronous dispatch and being able to have several urbs in flight
> at once, not the pre-allocation itself.
>=20
> I actually implemented it first with alloc/free for each transfer
> (http://git.plugable.com/gitphp/index.php?p=3Dudlfb&a=3Dcommit&h
4fa3b22580fd1532d06292e9061b9b2057f6a6),
> but freeing the associated buffer during completion generated WARN_ONs
> during each transfer.
>=20
> Google background on the problem I hit (lots of others hitting, too):
> http://www.google.com/search?q=3DLinux+WARN_ON+dma_free_coherent

Ick, that's not good.

> I thought about working around by queuing up a deferred op to free
> buffers outside of interrupt context, but that raised overhead
> concerns and leak concerns.

You can just have the urb framework purge the memory when it is finished
automatically, right?  What's wrong with that, it should work for what
you need.

> So that led to the current udlfb implementation, which is a pretty
> common and efficient pattern, in the drivers I've known.  And it's
> well tested at this point.

Yeah, because it's a common pattern, it either:
	- needs to be in the usb core so people don't keep duplicating
	  it everywhere
	- removed because there is a better and simpler way.

Right now I'm thinking the latter, as the urb can be dynamically handled
including the buffer attached to it.  We also have urb "anchors" to
handle disconnecting devices for dynamic urbs, so this should all be
handled.

But we can discuss this on the linux-usb list, not here :)

thanks,

greg k-h
