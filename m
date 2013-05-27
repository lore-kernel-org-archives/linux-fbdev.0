From: Inki Dae <inki.dae@samsung.com>
Date: Mon, 27 May 2013 10:38:24 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <014501ce5ac6$511a8500$f34f8f00$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi all,

I have been removed previous branch and added new one with more cleanup.
This time, the fence helper doesn't include user side interfaces and cache
operation relevant codes anymore because not only we are not sure that
coupling those two things, synchronizing caches and buffer access between
CPU and CPU, CPU and DMA, and DMA and DMA with fences, in kernel side is a
good idea yet but also existing codes for user side have problems with badly
behaved or crashing userspace. So this could be more discussed later.

The below is a new branch,
=09
https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/?h=3Ddm=
a-f
ence-helper

And fence helper codes,
=09
https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/commit/?
h=3Ddma-fence-helper&id=ADcbc0fe7e285ce866e5816e5e21443dcce01005

And example codes for device driver,
=09
https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/commit/?
h=3Ddma-fence-helper&id=D2ce7af23835789602a99d0ccef1f53cdd5caaae

I think the time is not yet ripe for RFC posting: maybe existing dma fence
and reservation need more review and addition work. So I'd glad for somebody
giving other opinions and advices in advance before RFC posting.

Thanks,
Inki Dae

