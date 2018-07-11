From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 11 Jul 2018 17:35:02 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
In-Reply-To: <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Zimmermann <tzimmermann@suse.de>

Hi,

On 11-07-18 17:42, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 5:35 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11-07-18 17:28, Daniel Vetter wrote:
>>>
>>> On Wed, Jul 11, 2018 at 5:14 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 11-07-18 17:07, Thomas Zimmermann wrote:
>>>>>
>>>>>
>>>>> Hi
>>>>>
>>>>> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>>>>>
>>>>>>
>>>>>>
>>>>>> What if you make lockless_register_fb visible to fbcon, and then we can
>>>>>> have a macro:
>>>>>
>>>>>
>>>>>
>>>>> There are more of these macro invocations under drivers/tty/vt, which
>>>>> also mess up the log during debugging.
>>>>
>>>>
>>>>
>>>> Hmm, so this option is already broken (in a way) then, my first reaction
>>>> to your mail was that we should just remove that option. But that seemed
>>>> a bit harsh to me so I've been working on a fix for the last 10 minutes
>>>> or so.
>>>>
>>>> But if it is already broken I'm tempted to just remove the option and
>>>> be done with it.  We really need less cruft in the fbdev/fbcon code not
>>>> more.
>>>
>>>
>>> Please don't remove it, it makes debugging kms driver issues on
>>> initial modeset (which is usually run from framebuffer_register, while
>>> hodling the console_lock) impossible.
>>
>>
>> OK, so if we don't remove it, we should probably make it so that it
>> can be used without triggering any WARN_ONs, which would require changing
>> the existing WARN_CONSOLE_UNLOCKED() so that the calls from
>> drivers/tty/vt/vt.c
>> also do not trigger it ?
>>
>> I guess one can just ignore the oopses when debugging, but debugging surely
>> would be easier if there are just no oopses ?
> 
> I'd say let's only bother with the ones in fbcon.c. Avoids the trouble
> with having to expose the fb module option to vt.c somehow.

The plan was actually do the things the other way around, add a flag to
vt.c which when set disables the WARN_ON calls and then have fbdev[.ko]
set that when the fb.lockless_fb_register option is set.

> The ones
> in vt.c are as old as the git history (from a quick check at least),
> and in my debugging they never have been annoying (or I somehow didn't
> ever hit them, not idea).

There is a #if 1 #define #else #define empty around the WARN_CONSOLE_UNLOCKED()
call in include/linux/console.h I've the feeling that is there as a hack
to be able to quickly disable the WARN_ONs when debugging.

Have you seen Steven's suggestion which he send about the same time
as your mail I'm replying to here ? I personally think that doing
something like that makes sense (for as long as we have the need
for the lockless_fb_register debug hack).

Note I've 2 patches ready to go to only fix this in fbcon.c, but I
think a more thorough fix makes sense.

Regards,

Hans

