From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Wed, 08 Apr 2015 07:24:53 +0000
Subject: Re: Questions about simplefb and hand-over
Message-Id: <CAJKbBDD_DQS2DkwMa04ijdOCE4+g-bvw=TWcZDwYJgXfB2xH1Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJKbBDCCU5zBAFLf_KH-nYLzJYbAU9S9z6Jfe8F3w5SY+-ZCuQ@mail.gmail.com>
	<551E5715.90600@redhat.com>
In-Reply-To: <551E5715.90600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hello,

thank you for your reply.
I will take a look at the x86 code and at the function you mentioned.

Do you know where the simpledrm is hosted, because I would like to
take look at it too.

Thanks,
Hannes



2015-04-03 11:02 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:
> Hi,
>
>
> On 03-04-15 10:57, Johannes Pointner wrote:
>>
>> Hello all,
>>
>> I'd like to use the simplefb in combination with tilcdc drm driver
>> with a TI AM335x processor. I got the u-boot to simplefb part working,
>> but I'm not sure how to do the hand-over part.
>>
>> Is it yet possible to do that? Does the tilcdc drm driver need
>> additional functionality to support that? Or are there other things I
>> have to take into account?
>>
>> Any suggestions would be highly appreciated!
>
>
> There is a remove_conflicting_framebuffers call which is already used
> on x86 to remove e.g. efifb when a kms driver loads, the plan for
> simplefb / arm is to do the same. That is where we stand now, we've
> a plan but you're the first person to actually try this.
>
> Note that you may want to use simpledrm by David Herrmann (added to the
> Cc) instead of simplefb as that will give you a kms driver right from
> the start, simpledrm is not yet upstream but should go upstream soon.
>
> Regards,
>
> Hans
>
>
