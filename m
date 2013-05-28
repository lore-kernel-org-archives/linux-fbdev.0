From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 28 May 2013 02:49:29 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <005601ce5b4d$f95e0160$ec1a0420$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Maarten Lankhorst [mailto:maarten.lankhorst@canonical.com]
> Sent: Tuesday, May 28, 2013 12:23 AM
> To: Inki Dae
> Cc: 'Daniel Vetter'; 'Rob Clark'; 'linux-fbdev'; 'YoungJun Cho'; 'Kyungmin
> Park'; 'myungjoo.ham'; 'DRI mailing list'; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: Introduce a new helper framework for buffer synchronization
>=20
> Hey,
>=20
> Op 27-05-13 12:38, Inki Dae schreef:
> > Hi all,
> >
> > I have been removed previous branch and added new one with more cleanup.
> > This time, the fence helper doesn't include user side interfaces and
> cache
> > operation relevant codes anymore because not only we are not sure that
> > coupling those two things, synchronizing caches and buffer access
> between
> > CPU and CPU, CPU and DMA, and DMA and DMA with fences, in kernel side is
> a
> > good idea yet but also existing codes for user side have problems with
> badly
> > behaved or crashing userspace. So this could be more discussed later.
> >
> > The below is a new branch,
> >
> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> exynos.git/?h=3Ddma-f
> > ence-helper
> >
> > And fence helper codes,
> >
> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> exynos.git/commit/?
> > h=3Ddma-fence-helper&id=ADcbc0fe7e285ce866e5816e5e21443dcce01005
> >
> > And example codes for device driver,
> >
> > https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-
> exynos.git/commit/?
> > h=3Ddma-fence-helper&id=D2ce7af23835789602a99d0ccef1f53cdd5caaae
> >
> > I think the time is not yet ripe for RFC posting: maybe existing dma
> fence
> > and reservation need more review and addition work. So I'd glad for
> somebody
> > giving other opinions and advices in advance before RFC posting.
> >
> NAK.
>=20
> For examples for how to handle locking properly, see Documentation/ww-
> mutex-design.txt in my recent tree.
> I could list what I believe is wrong with your implementation, but real
> problem is that the approach you're taking is wrong.

I just removed ticket stubs to show my approach you guys as simple as
possible, and I just wanted to show that we could use buffer synchronization
mechanism without ticket stubs.

Question, WW-Mutexes could be used for all devices? I guess this has
dependence on x86 gpu: gpu has VRAM and it means different memory domain.
And could you tell my why shared fence should have only eight objects? I
think we could need more than eight objects for read access. Anyway I think
I don't surely understand yet so there might be my missing point.

Thanks,
Inki Dae

>=20

> ~Maarten

