From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 08 Apr 2015 08:32:27 +0000
Subject: Re: Questions about simplefb and hand-over
Message-Id: <CANq1E4RhACj4dWnYQ_9=f-OSJfcoX2rQnPihb1VCtaxAoQ6Diw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJKbBDCCU5zBAFLf_KH-nYLzJYbAU9S9z6Jfe8F3w5SY+-ZCuQ@mail.gmail.com>
	<551E5715.90600@redhat.com>
	<CAJKbBDD_DQS2DkwMa04ijdOCE4+g-bvw=TWcZDwYJgXfB2xH1Q@mail.gmail.com>
	<5524D92B.4040408@redhat.com>
In-Reply-To: <5524D92B.4040408-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Johannes Pointner <johannes.pointner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi

On Wed, Apr 8, 2015 at 9:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 08-04-15 09:24, Johannes Pointner wrote:
>>
>> Hello,
>>
>> thank you for your reply.
>> I will take a look at the x86 code and at the function you mentioned.
>>
>> Do you know where the simpledrm is hosted, because I would like to
>> take look at it too.
>
>
> David Herrmann (in the Cc) is the best person to answer that, I
> think he needs to rebase on it on the latest upstream kernel.
>
> David ?

http://cgit.freedesktop.org/~dvdhrm/linux/log/?h=simpledrm

I should _definitely_ revive that. My TODO list does get shorter, so
lets see whether I can find some spare time for it.

Please note that you can use remove_conflicting_framebuffers() with
simplefb just fine. No reason to wait for simpledrm (except that it's
way cooler!). Once I push the patches, I will convert
remove_conflicting_framebuffers() to work just fine, and simpledrm
will take-over all simplefb devices seamlessly.

Thanks
David
