From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 28 May 2013 14:43:50 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <00d801ce5bb1$c48f2ea0$4dad8be0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org


Hi Daniel,

Thank you so much. And so very useful.:) Sorry but could be give me more
comments to the below my comments? There are still things making me
confusing.:(


> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel
> Vetter
> Sent: Tuesday, May 28, 2013 7:33 PM
> To: Inki Dae
> Cc: 'Rob Clark'; 'Maarten Lankhorst'; 'Daniel Vetter'; 'linux-fbdev';
> 'YoungJun Cho'; 'Kyungmin Park'; 'myungjoo.ham'; 'DRI mailing list';
> linux-arm-kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: Introduce a new helper framework for buffer synchronization
>=20
> On Tue, May 28, 2013 at 12:56:57PM +0900, Inki Dae wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> > > owner@vger.kernel.org] On Behalf Of Rob Clark
> > > Sent: Tuesday, May 28, 2013 12:48 AM
> > > To: Inki Dae
> > > Cc: Maarten Lankhorst; Daniel Vetter; linux-fbdev; YoungJun Cho;
> Kyungmin
> > > Park; myungjoo.ham; DRI mailing list;
> > linux-arm-kernel@lists.infradead.org;
> > > linux-media@vger.kernel.org
> > > Subject: Re: Introduce a new helper framework for buffer
> synchronization
> > >
> > > On Mon, May 27, 2013 at 6:38 AM, Inki Dae <inki.dae@samsung.com>
wrote:
> > > > Hi all,
> > > >
> > > > I have been removed previous branch and added new one with more
> cleanup.
> > > > This time, the fence helper doesn't include user side interfaces and
> > > cache
> > > > operation relevant codes anymore because not only we are not sure
> that
> > > > coupling those two things, synchronizing caches and buffer access
> > > between
> > > > CPU and CPU, CPU and DMA, and DMA and DMA with fences, in kernel
> side is
> > > a
> > > > good idea yet but also existing codes for user side have problems
> with
> > > badly
> > > > behaved or crashing userspace. So this could be more discussed
later.
> > > >
> > > > The below is a new branch,
> > > >
> > > > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> > > exynos.git/?h=3Ddma-f
> > > > ence-helper
> > > >
> > > > And fence helper codes,
> > > >
> > > > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> > > exynos.git/commit/?
> > > > h=3Ddma-fence-helper&id=ADcbc0fe7e285ce866e5816e5e21443dcce01005
> > > >
> > > > And example codes for device driver,
> > > >
> > > > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> > > exynos.git/commit/?
> > > > h=3Ddma-fence-helper&id=D2ce7af23835789602a99d0ccef1f53cdd5caaae
> > > >
> > > > I think the time is not yet ripe for RFC posting: maybe existing dma
> > > fence
> > > > and reservation need more review and addition work. So I'd glad for
> > > somebody
> > > > giving other opinions and advices in advance before RFC posting.
> > >
> > > thoughts from a *really* quick, pre-coffee, first look:
> > > * any sort of helper to simplify single-buffer sort of use-cases (v4l)
> > > probably wouldn't want to bake in assumption that seqno_fence is used.
> > > * I guess g2d is probably not actually a simple use case, since I
> > > expect you can submit blits involving multiple buffers :-P
> >
> > I don't think so. One and more buffers can be used: seqno_fence also has
> > only one buffer. Actually, we have already applied this approach to most
> > devices; multimedia, gpu and display controller. And this approach shows
> > more performance; reduced power consumption against traditional way. And
> g2d
> > example is just to show you how to apply my approach to device driver.
>=20
> Note that seqno_fence is an implementation pattern for a certain type of
> direct hw->hw synchronization which uses a shared dma_buf to exchange the
> sync cookie.

I'm afraid that I don't understand hw->hw synchronization. hw->hw
synchronization means that device has a hardware feature which supports
buffer synchronization hardware internally? And what is the sync cookie?

> The dma_buf attached to the seqno_fence has _nothing_ to do
> with the dma_buf the fence actually coordinates access to.
>=20
> I think that confusing is a large reason for why Maarten&I don't
> understand what you want to achieve with your fence helpers. Currently
> they're using the seqno_fence, but totally not in a way the seqno_fence
> was meant to be used.
>=20
> Note that with the current code there is only a pointer from dma_bufs to
> the fence. The fence itself has _no_ pointer to the dma_buf it syncs. This
> shouldn't be a problem since the fence fastpath for already signalled
> fences is completely barrier&lock free (it's just a load+bit-test), and
> fences are meant to be embedded into whatever dma tracking structure you
> already have, so no overhead there. The only ugly part is the fence
> refcounting, but I don't think we can drop that.

The below is the proposed way,
dma device has to create a fence before accessing a shared buffer, and then
check if there are other dma which are accessing the shared buffer; if exist
then the dma device should be blocked, and then  it sets the fence to
reservation object of the shared buffer. And then the dma begins access to
the shared buffer. And finally, the dma signals its own fence so that other
blocked can be waked up. However, if there was another dma blocked before
signaling then another dma can access invalid fence object after waked up
because the fence object can be released after signaling. So I made another
dma takes a one reference before blocked. And I think origin version also
takes a reference at ticket_commit(). Is there wrong point in proposed way?

>=20
> Note that you completely reinvent this part of Maarten's fence patches by
> adding new r/w_complete completions to the reservation object, which
> completely replaces the fence stuff.
>=20
> Also note that a list of reservation entries is again meant to be used
> only when submitting the dma to the gpu. With your patches you seem to
> hang onto that list until dma completes.

Yeah, that is for prevent a dma from accessing a shared buffer while the
other is accessing the shared buffer. Maybe this way means software
synchronization. And your saying seems that there is another mechanism for
dealing with such thing. Could you give me more comments for it? is there
really another mechanism?

> This has the ugly side-effect
> that you need to allocate these reservation entries with kmalloc, whereas
> if you just use them in the execbuf ioctl to construct the dma you can
> usually embed it into something else you need already anyway. At least
> i915 and ttm based drivers can work that way.
>=20

Maybe there is my misunderstanding but I thought now dma fence and relevant
stubs tend to depend on Desktop world, especially x86 gpu. So I thought we
need a little bit customizing the dma fence for embedded system.

> Furthermore fences are specifically constructed as frankenstein-monsters
> between completion/waitqueues and callbacks. All the different use-cases
> need the different aspects:
> - busy/idle checks and bo retiring need the completion semantics
> - callbacks (in interrupt context) are used for hybrid hw->irq handler->hw
>   sync approaches
>=20
> >
> > > * otherwise, you probably don't want to depend on dmabuf, which is why
> > > reservation/fence is split out the way it is..  you want to be able to
> > > use a single reservation/fence mechanism within your driver without
> > > having to care about which buffers are exported to dmabuf's and which
> > > are not.  Creating a dmabuf for every GEM bo is too heavyweight.
> >
> > Right. But I think we should dealt with this separately. Actually, we
> are
> > trying to use reservation for gpu pipe line synchronization such as sgx
> sync
> > object and this approach is used without dmabuf. In order words, some
> device
> > can use only reservation for such pipe line synchronization and at the
> same
> > time, fence helper or similar thing with dmabuf for buffer
> synchronization.
>=20
> I think a quick overview of the different pieces would be in order.
>=20
> - ww_mutex: This is just the locking primite which allows you to grab
>   multiple mutexes without the need to check for ordering (and so fear
>   deadlocks).

Should ww_mutex be necessarily used for embedded system? I'm not sure that
there are any cases we have to use this feature like x86 gpu. That is also
why I removed ticket stubs from existing reservation framework.

>=20
> - fence: This is just a fancy kind of completion with a bit of support for
>   hw->hw completion events.

hw->hw completion event means completion of dma operation? Otherwise,
hardware buffer synchronization feature? If the latter, how fence can be
used for embedded system which has no hardware feature for buffer
synchronization? Actually, that made me confusing at initial work.

> The fences themselve have no tie-in with
>   buffers, ww_mutexes or anything else.
>=20
> - reservation: This ties together an object (doesn't need to be a buffer,
>   could be any other gpu resource - see the drm/vmwgfx driver if you want
>   your mind blown) with fences. Note that there's no connection the other
>   way round, i.e. with the current patches you can't see which
>   reservations are using which fences. Also note that other objects than
>   reservations could point at fences, e.g. when the provide
>   shared/exclusive semantics are not good enough for your needs.
>=20
>   The ww_mutex in the reservation is simply the (fancy) lock which
>   protects each reservation. The reason we need something fancy is that
>   you need to lock all objects which are synced by the same fence
>   toghether, otherwise you can race and construct deadlocks in the hw->hw
>   sync part of fences.
>=20
> - dma_buf integration: This is simply a pointer to the reservation object
>   of the underlying buffer object. We need a pointer here since otherwise
>   you can construct deadlocks between dma_buf objects and native buffer
>   objects.
>=20
> The crux is also that dma_buf integration comes last - before you can do
> that you need to have your driver converted over to use
> ww_mutexes/fences/reservations.
>=20
> I hope that helps to unconfuse things a bit and help you understand the
> different pieces of the fence/reservation/ww_mutex patches floating
> around.

Thank you again.:)=20

Thanks,
Inki Dae

>=20
> Cheers, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

