From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 27 May 2013 16:02:17 +0000
Subject: Re: Introduce a new helper framework for buffer synchronization
Message-Id: <CAKMK7uG1T-w=rVfORzdSk9LWN_aXqqCiG87UdhjutfbS=rpzbg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAAQKjZP=iOmHRpHZCbZD3v_RKUFSn0eM_WVZZvhe7F9g3eTmPA@mail.gmail.com>
	<CAF6AEGuDih-NR-VZCmQfqbvCOxjxreZRPGfhCyL12FQ1Qd616Q@mail.gmail.com>
	<006a01ce504e$0de3b0e0$29ab12a0$%dae@samsung.com>
	<CAF6AEGv2FiKMUpb5s4zHPdj4uVxnQWdVJWL-i1mOOZRxBvMZ4Q@mail.gmail.com>
	<00cf01ce512b$bacc5540$3064ffc0$%dae@samsung.com>
	<CAF6AEGuBexKUpTwm9cjGjkxCTKgEaDhAakeP0RN=rtLS6Qy=Mg@mail.gmail.com>
	<CAAQKjZP37koEPob6yqpn-WxxTh3+O=twyvRzDiEhVJTD8BxQzw@mail.gmail.com>
	<20130520211304.GV12292@phenom.ffwll.local>
	<20130520213033.GW12292@phenom.ffwll.local>
	<032701ce55f1$3e9ba4b0$bbd2ee10$%dae@samsung.com>
	<20130521074441.GZ12292@phenom.ffwll.local>
	<033a01ce5604$c32bd250$498376f0$%dae@samsung.com>
	<CAKMK7uHtk+A7CDZH3qHt+F3H_fdSsWwt-bEPn-N0919oOE+Jkg@mail.gmail.com>
	<012801ce57ba$a5a87fa0$f0f97ee0$%dae@samsung.com>
	<014501ce5ac6$511a8500$f34f8f00$%dae@samsung.com>
	<CAF6AEGvGv539Ktdeg03n783nD+HofDamcJCLX93rzzKGOCV8_Q@mail.gmail.com>
In-Reply-To: <CAF6AEGvGv539Ktdeg03n783nD+HofDamcJCLX93rzzKGOCV8_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Clark <robdclark@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, Maarten Lankhorst <maarten.lankhorst@canonical.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, YoungJun Cho <yj44.cho@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "myungjoo.ham" <myungjoo.ham@samsung.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Mon, May 27, 2013 at 5:47 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Mon, May 27, 2013 at 6:38 AM, Inki Dae <inki.dae@samsung.com> wrote:
>> Hi all,
>>
>> I have been removed previous branch and added new one with more cleanup.
>> This time, the fence helper doesn't include user side interfaces and cac=
he
>> operation relevant codes anymore because not only we are not sure that
>> coupling those two things, synchronizing caches and buffer access between
>> CPU and CPU, CPU and DMA, and DMA and DMA with fences, in kernel side is=
 a
>> good idea yet but also existing codes for user side have problems with b=
adly
>> behaved or crashing userspace. So this could be more discussed later.
>>
>> The below is a new branch,
>>
>> https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/?h=
=3Ddma-f
>> ence-helper
>>
>> And fence helper codes,
>>
>> https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/comm=
it/?
>> h=3Ddma-fence-helper&id=ADcbc0fe7e285ce866e5816e5e21443dcce01005
>>
>> And example codes for device driver,
>>
>> https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/comm=
it/?
>> h=3Ddma-fence-helper&id=D2ce7af23835789602a99d0ccef1f53cdd5caaae
>>
>> I think the time is not yet ripe for RFC posting: maybe existing dma fen=
ce
>> and reservation need more review and addition work. So I'd glad for some=
body
>> giving other opinions and advices in advance before RFC posting.
>
> thoughts from a *really* quick, pre-coffee, first look:
> * any sort of helper to simplify single-buffer sort of use-cases (v4l)
> probably wouldn't want to bake in assumption that seqno_fence is used.

Yeah, which is why Maarten&I discussed ideas already for what needs to
be improved in the current dma-buf interface code to make this Just
Work. At least as long as a driver doesn't want to add new fences,
which would be especially useful for all kinds of gpu access.

> * I guess g2d is probably not actually a simple use case, since I
> expect you can submit blits involving multiple buffers :-P

Yeah, on a quick read the current fence helper code seems to be a bit
limited in scope.

> * otherwise, you probably don't want to depend on dmabuf, which is why
> reservation/fence is split out the way it is..  you want to be able to
> use a single reservation/fence mechanism within your driver without
> having to care about which buffers are exported to dmabuf's and which
> are not.  Creating a dmabuf for every GEM bo is too heavyweight.

That's pretty much the reason that reservations are free-standing from
dma_bufs. The idea is to embed them into the gem/ttm/v4l buffer
object. Maarten also has some helpers to keep track of multi-buffer
ww_mutex locking and fence attaching in his reservation helpers, but I
think we should wait with those until we have drivers using them.

For now I think the priority should be to get the basic stuff in and
ttm as the first user established. Then we can go nuts later on.

> I'm not entirely sure if reservation/fence could/should be made any
> simpler for multi-buffer users.  Probably the best thing to do is just
> get reservation/fence rolled out in a few drivers and see if some
> common patterns emerge.

I think we can make the 1 buffer per dma op (i.e. 1:1
dma_buf->reservation : fence mapping) work fairly simple in dma_buf
with maybe a dma_buf_attachment_start_dma/end_dma helpers. But there's
also still the open that currently there's no way to flush cpu caches
for dma access without unmapping the attachement (or resorting to
trick which might not work), so we have a few gaping holes in the
interface already anyway.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
