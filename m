From: Rob Clark <robdclark@gmail.com>
Date: Fri, 26 Jul 2013 14:24:54 +0000
Subject: Re: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <CAF6AEGubFuVO8DtGSgefRpc16mwOEVoV3hPjfNkVg48to6p2Jw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
 <20130726141430.GQ24642@n2100.arm.linux.org.uk>
In-Reply-To: <20130726141430.GQ24642@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, pawel.moll@arm.com, linux-arm-kernel@lists.infradead.org, tom.cooksey@arm.com

On Fri, Jul 26, 2013 at 10:14 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 25, 2013 at 02:21:59PM -0400, Rob Clark wrote:
>> On Thu, Jul 25, 2013 at 1:17 PM,  <tom.cooksey@arm.com> wrote:
>> > Known issues:
>> >  * It uses KDS. We intend to switch to whatever implicit per-buffer
>> >    synchronisation mechanism gets merged, once something is merged.
>> >  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
>> >    allocate buffers for the GPU. Still not sure how to resolve this
>> >    as we don't use DRM for our GPU driver.
>>
>> any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
>> once the dma-fence stuff is in place), we'd have gpu-specific drm
>> (gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
>> using prime/dmabuf to share between the two.
>
> The PL111 primecell is just a scanout device.  It has no GPU embedded
> in it.  It's just like the Armada/Dove DRM stuff - if a GPU is provided
> it's an entirely separate piece of IP, and will likely remain a separate
> non-DRM driver.
>
> In the case of PL111, PL111 is not manufacturer specific so the GPU can
> be any standalone GPU.

Oh, yeah, I know PL111 is different block independent from GPU.  I
wasn't advocating adding mali support in this driver.  But instead
creating a mali DRM driver which had GEM and gpu bits, but not KMS.
Then buffer sharing w/ prime/dmabuf just like you would, for example
on a laptop w/ both integrated graphics and discrete GPU.

BR,
-R
