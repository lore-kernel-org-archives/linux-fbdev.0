From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 14 Jun 2011 19:04:20 +0000
Subject: Re: Possible deadlock when suspending framebuffer
Message-Id: <4DF7B0B4.4060002@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTiko+2AM8dq8jP5xjbTcCM63hBAK=A@mail.gmail.com> <BANLkTimny9nzr23TufH1kMcsk57M3NXuaA@mail.gmail.com>
In-Reply-To: <BANLkTimny9nzr23TufH1kMcsk57M3NXuaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Francis Moreau <francis.moro@gmail.com>

Hi Linus,

On 06/14/2011 06:15 PM, Linus Torvalds wrote:
> Paul, fbdev people.. Comments? This was sent to me and lkml, the right
> people probably didn't see it.

Sounds very familiar. Indeed a quick glance at my archive revealed 2 
approaches/patches dealing with similar issues
http://marc.info/?l=linux-fbdev&m9539210207429&w=2
http://marc.info/?l=linux-fbdev&m9700789632450&w=2

I did not have time to verify that those do actually get those things right 
everywhere but the first one looks good and should also solve this issue I think.


Regards,

Florian Tobias Schandinat

>
> I doubt it's a big problem in practice, but..
>
>                        Linus
>
> On Tue, Jun 14, 2011 at 6:10 AM, Francis Moreau<francis.moro@gmail.com>  wrote:
>> Hello,
>>
>> I noticed that a possible deadlock can happen when the current frame
>> buffering is being suspended and a new frambuffer device is being
>> registred at the same time.
>>
>> When suspending the current frambuffer by doing : echo 1
>>> /sys/class/graphics/fb0/state, the kernel actually takes the
>> following locks in that order: console_lock, lock_fb_info (see
>> store_fbstate()).
>>
>> However when a new framebuffer is coming in, the lock sequence is:
>> lock_fb_info (taken by do_remove_conflicting_framebuffer()),
>> console_lock() (taken by unbind_console).
>>
>> I don't know how this should be fixed though...
>>
>> Thanks
>> --
>> Francis
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

