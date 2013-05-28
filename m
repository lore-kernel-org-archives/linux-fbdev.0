From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 28 May 2013 14:50:16 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <00de01ce5bb2$aa7c6b30$ff754190$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Rob Clark
> Sent: Tuesday, May 28, 2013 10:49 PM
> To: Inki Dae
> Cc: Maarten Lankhorst; Daniel Vetter; linux-fbdev; YoungJun Cho; Kyungmin
> Park; myungjoo.ham; DRI mailing list;
linux-arm-kernel@lists.infradead.org;
> linux-media@vger.kernel.org
> Subject: Re: Introduce a new helper framework for buffer synchronization
>=20
> On Mon, May 27, 2013 at 11:56 PM, Inki Dae <inki.dae@samsung.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> >> owner@vger.kernel.org] On Behalf Of Rob Clark
> >> Sent: Tuesday, May 28, 2013 12:48 AM
> >> To: Inki Dae
> >> Cc: Maarten Lankhorst; Daniel Vetter; linux-fbdev; YoungJun Cho;
> Kyungmin
> >> Park; myungjoo.ham; DRI mailing list;
> > linux-arm-kernel@lists.infradead.org;
> >> linux-media@vger.kernel.org
> >> Subject: Re: Introduce a new helper framework for buffer
> synchronization
> >>
> >> On Mon, May 27, 2013 at 6:38 AM, Inki Dae <inki.dae@samsung.com> wrote:
> >> > Hi all,
> >> >
> >> > I have been removed previous branch and added new one with more
> cleanup.
> >> > This time, the fence helper doesn't include user side interfaces and
> >> cache
> >> > operation relevant codes anymore because not only we are not sure
> that
> >> > coupling those two things, synchronizing caches and buffer access
> >> between
> >> > CPU and CPU, CPU and DMA, and DMA and DMA with fences, in kernel side
> is
> >> a
> >> > good idea yet but also existing codes for user side have problems
> with
> >> badly
> >> > behaved or crashing userspace. So this could be more discussed later.
> >> >
> >> > The below is a new branch,
> >> >
> >> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> >> exynos.git/?h=3Ddma-f
> >> > ence-helper
> >> >
> >> > And fence helper codes,
> >> >
> >> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> >> exynos.git/commit/?
> >> > h=3Ddma-fence-helper&id=ADcbc0fe7e285ce866e5816e5e21443dcce01005
> >> >
> >> > And example codes for device driver,
> >> >
> >> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> >> exynos.git/commit/?
> >> > h=3Ddma-fence-helper&id=D2ce7af23835789602a99d0ccef1f53cdd5caaae
> >> >
> >> > I think the time is not yet ripe for RFC posting: maybe existing dma
> >> fence
> >> > and reservation need more review and addition work. So I'd glad for
> >> somebody
> >> > giving other opinions and advices in advance before RFC posting.
> >>
> >> thoughts from a *really* quick, pre-coffee, first look:
> >> * any sort of helper to simplify single-buffer sort of use-cases (v4l)
> >> probably wouldn't want to bake in assumption that seqno_fence is used.
> >> * I guess g2d is probably not actually a simple use case, since I
> >> expect you can submit blits involving multiple buffers :-P
> >
> > I don't think so. One and more buffers can be used: seqno_fence also has
> > only one buffer. Actually, we have already applied this approach to most
> > devices; multimedia, gpu and display controller. And this approach shows
> > more performance; reduced power consumption against traditional way. And
> g2d
> > example is just to show you how to apply my approach to device driver.
>=20
> no, you need the ww-mutex / reservation stuff any time you have
> multiple independent devices (or rings/contexts for hw that can
> support multiple contexts) which can do operations with multiple
> buffers.

I think I already used reservation stuff any time in that way except
ww-mutex. And I'm not sure that embedded system really needs ww-mutex. If
there is any case,=20
could you tell me the case? I really need more advice and understanding :)

Thanks,
Inki Dae

  So you could conceivably hit this w/ gpu + g2d if multiple
> buffers where shared between the two.  vram migration and such
> 'desktop stuff' might make the problem worse, but just because you
> don't have vram doesn't mean you don't have a problem with multiple
> buffers.
>=20
> >> * otherwise, you probably don't want to depend on dmabuf, which is why
> >> reservation/fence is split out the way it is..  you want to be able to
> >> use a single reservation/fence mechanism within your driver without
> >> having to care about which buffers are exported to dmabuf's and which
> >> are not.  Creating a dmabuf for every GEM bo is too heavyweight.
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
> it is probably easier to approach from the reverse direction.. ie, get
> reservation/synchronization right first, and then dmabuf.  (Well, that
> isn't really a problem because Maarten's reservation/fence patches
> support dmabuf from the beginning.)
>=20
> BR,
> -R
>=20
> >>
> >> I'm not entirely sure if reservation/fence could/should be made any
> >> simpler for multi-buffer users.  Probably the best thing to do is just
> >> get reservation/fence rolled out in a few drivers and see if some
> >> common patterns emerge.
> >>
> >> BR,
> >> -R
> >>
> >> >
> >> > Thanks,
> >> > Inki Dae
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-fbdev"
> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

