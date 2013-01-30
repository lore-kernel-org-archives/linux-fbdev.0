From: Mark Zhang <nvmarkzhang@gmail.com>
Date: Wed, 30 Jan 2013 07:46:09 +0000
Subject: Re: [RFC 3/4] drm: tegra: use the Common Display Framework
Message-Id: <5108CFC1.8010905@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-4-git-send-email-acourbot@nvidia.com> <5108C298.1000500@gmail.com> <5108C55C.30104@nvidia.com>
In-Reply-To: <5108C55C.30104-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/30/2013 03:01 PM, Alex Courbot wrote:
> On 01/30/2013 03:50 PM, Mark Zhang wrote:
[...]
> 
>>> +    /* register display notifier */
>>> +    output->display_notifier.dev = NULL;
>>
>> Set "display_notifier.dev" to NULL makes we have to compare with every
>> display entity, just like what you do in "display_notify_callback":
>>
>> entity->dev && entity->dev->of_node = pnode
>>
>> So can we get the "struct device *" of panel here? Seems currently the
>> "of" framework doesn't allow "device_node -> device".
> 
> Nope. AFAICT the device might not be instanciated at this point. We
> become aware of it for the first time in the callback function. We also
> don't want to defer probing until the panel is parsed first, since the
> panel might also depend on resources of the display device.
> 

Agree.

> Thanks,
> Alex.
> 
