From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Apr 2015 09:02:13 +0000
Subject: Re: Questions about simplefb and hand-over
Message-Id: <551E5715.90600@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJKbBDCCU5zBAFLf_KH-nYLzJYbAU9S9z6Jfe8F3w5SY+-ZCuQ@mail.gmail.com>
In-Reply-To: <CAJKbBDCCU5zBAFLf_KH-nYLzJYbAU9S9z6Jfe8F3w5SY+-ZCuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Pointner <johannes.pointner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi,

On 03-04-15 10:57, Johannes Pointner wrote:
> Hello all,
>
> I'd like to use the simplefb in combination with tilcdc drm driver
> with a TI AM335x processor. I got the u-boot to simplefb part working,
> but I'm not sure how to do the hand-over part.
>
> Is it yet possible to do that? Does the tilcdc drm driver need
> additional functionality to support that? Or are there other things I
> have to take into account?
>
> Any suggestions would be highly appreciated!

There is a remove_conflicting_framebuffers call which is already used
on x86 to remove e.g. efifb when a kms driver loads, the plan for
simplefb / arm is to do the same. That is where we stand now, we've
a plan but you're the first person to actually try this.

Note that you may want to use simpledrm by David Herrmann (added to the
Cc) instead of simplefb as that will give you a kms driver right from
the start, simpledrm is not yet upstream but should go upstream soon.

Regards,

Hans


