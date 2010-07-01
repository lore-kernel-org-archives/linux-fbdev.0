From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Thu, 01 Jul 2010 23:47:29 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <AANLkTilwTdyKptIWPsnZF4kXAERCsQb2f6Ymyrkz_v5q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29CFBD.3040205@samsung.com>
	<AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
	<AANLkTikxu_p-F4iJnwiY7GvP0Zkf-WsZEAeLzfJuljlB@mail.gmail.com>
In-Reply-To: <AANLkTikxu_p-F4iJnwiY7GvP0Zkf-WsZEAeLzfJuljlB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi InKi,

Thanks for your reply.

On Wed, Jun 30, 2010 at 12:36 PM, InKi Dae <daeinki@gmail.com> wrote:
> Hi Jaya,
>
> 2010/6/30 Jaya Kumar <jayakumar.lkml@gmail.com>:
>> 2010/6/29 InKi Dae <inki.dae@samsung.com>:
>>> CPU interface needs cs, wr setup, wr act and hold delay.
>>> I added some members for them to common framework.
>>
>> Hi InKi Dae,
>>
>> The patch looks interesting. Could you help us understand more about
>> it from a big picture perspective? ie: how is this "cpu interface"
>> used? I think fb_var_screeninfo is intended to be a very generic data
>> structure and since it is exposed to userspace we should be cautious
>> about what we add to it. I didn't understand the purpose of exposing
>> cs, wr setup, wr act and hold delay to userspace.
>
> in case of lcd panel with cpu interface, it could get screen data
> through arm core
> or display controller supporting cpu interface mode.
> display controller of s5pv210 chip can create cpu interface signal according to
> cs, wr setup, wr act and hold time setting.
> the reason I added cpu timing variables to fb_var_screeninfo is for using common
> framework when setting them to the display controller as cpu timing info.
> please, see [PATCH 2/3], s3c_fb_set_timing function part.
>
> and cpu timing could be adjusted by user through fb_var_screeninfo,
> for this, suitable checking should be considered at machine specific
> fb_check_var func.
> also you can see that through [PATCH 2/3], s3c_fb_check_var.

I'm still having difficulty understanding this. I guess what I am
asking is why do these new variables "cs, wr setup, wr act and hold
time setting", have to be in fb_var_screeninfo which is a generic
platform/implementation independent structure exposed to userspace? If
I've understood things correctly, the variables themselves, eg: wr
setup seem to be specific to this implementation rather than being
generic like the other members of fb_var_sreeninfo. Have you
considered an alternative way by which you can achieve the desired
functionality. Also, I'm confused when you say "cpu timing" could be
adjusted by user through fb_var_screeninfo. Could you elaborate on
that?

I haven't read through the remaining part of the message about
mipi-dsi issues, I'm hoping developers who have implemented the other
MIPI-DSI implementations in fbdev could chime in.

Thanks,
jaya
