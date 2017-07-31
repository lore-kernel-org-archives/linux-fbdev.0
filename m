From: David Lechner <david@lechnology.com>
Date: Mon, 31 Jul 2017 17:25:28 +0000
Subject: Re: [PATCH] fbcon: Use background color for margins
Message-Id: <bffc57cf-bd63-ec3c-4b0b-986f11751bf3@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501273590-3237-1-git-send-email-david@lechnology.com>
 <20170730094726.GB18381@amd>
 <2cafbde9-6b31-9586-e3eb-0b80355eab3c@lechnology.com>
 <20170730215108.GA806@amd>
In-Reply-To: <20170730215108.GA806@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

On 07/30/2017 04:51 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Screens that don't have a black border around the active area will have
>>>> ugly black bars for the margin when the text background color is not black.
>>>> This is especially noticeable on an LCD screen (not the backlit kind) when
>>>> the terminal colors are inverted.
>>>
>>> Are you sure?
>>
>> Of course I am sure. Otherwise I would not send a patch. ;-)
>>
>> I have attached some pictures to explain it better. The default-console.jpg
>> picture shows what it looks like using just defaults. I think it is hard to
>> read the white text with the black background.
>>
>> So, the solution is to invert the terminal colors. But when you do this, the
>> margins are not inverted, so you are left with black bars on the bottom and
>> the right as seen in inverted-without-patch.jpg.
>>
>> With this patch applied, the margins are also inverted, so you don't have
>> the black bars as seen in inverted-with-patch.jpg. I think this is much
>> nicer.
>>
>>   It is quite common to have different backgrounds in
>>> different parts of the screen, how it is supposed to work there?
>>
>> There will be nothing different in this regard. Only the margins (non-text
>> area) are changed.
> 
> So you have something like midnight commander, which uses colors.
> 
> Lets say top half of screen is normal, bottom one is inverted. What
> color will borders be?
> 
> Will not they do something stupid (such as changing) when the
> curses-based application refreshes?
> 

Ah. I see what you mean now. The margin will be whatever is set for the 
vc_video_erase_char in the kernel, which can be changed by userspace. I 
tried midnight commander and sure enough, I still have the black margins 
when I invert the screen (`setterm -inverse on`). Interestingly, after 
allowing the console to blank after a timeout, the console was blanked 
with white, then after pressing a key to unblank, the margins were also 
white.

So, scratch this one. I will re-evaluate and send a new patch.



