From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 28 Jun 2013 10:14:59 +0000
Subject: Re: [RFC 4/6] drm: simpledrm: add fbdev fallback support
Message-Id: <CANq1E4T6rR9CHsrWnBR37eROpwvBRUVMrJ+gWFgg=huxD2dP6Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372112849-670-1-git-send-email-dh.herrmann@gmail.com>
	<1372112849-670-5-git-send-email-dh.herrmann@gmail.com>
	<51CB5630.6060000@wwwdotorg.org>
In-Reply-To: <51CB5630.6060000@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>

Hi

On Wed, Jun 26, 2013 at 10:59 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/24/2013 04:27 PM, David Herrmann wrote:
>> Create a simple fbdev device during SimpleDRM setup so legacy user-space
>> and fbcon can use it.
>>
>> fbdev deletion is quite buggy. A unregister_framebuffer() call followed by
>> a printk() causes NULL-derefs in hide_cursor() and other places in the VT
>> layer. Hence, we leak the fbdev device currently to make the VT layer
>> happy. This needs to be fixed soon! Otherwise, we need a "depends !VT"
>> line for SimpleDRM.
>
>> diff --git a/drivers/gpu/drm/simpledrm/Makefile b/drivers/gpu/drm/simpledrm/Makefile
>
>>  simpledrm-y := simpledrm_drv.o simpledrm_main.o simpledrm_mem.o
>>
>> +ifdef CONFIG_DRM_SIMPLEDRM_FBDEV
>> +     simpledrm-y += simpledrm_fbdev.o
>> +endif
>
> I think that's:
>
> + simpledrm-$(CONFIG_DRM_SIMPLEDRM_FBDEV) += simpledrm_fbdev.o

Ugh, I got errors trying that because SIMPLEDRM_FBDEV is a boolean but
SIMPLEDRM is a tristate. But I guess I tried:
obj-$(CONFIG_DRM_SIMPLEDRM_FBDEV) += simpledrm_fbdev.o
which obviously fails if SIMPLEDRM=m and SIMPLEDRM_FBDEV=y. I will try
to fix that.

Thanks
David
