From: Floris Bos <bos@je-eigen-domein.nl>
Date: Mon, 11 Feb 2013 14:16:31 +0000
Subject: Re: [linux-sunxi] [PATCH] video/modedb: fb_find_nearest_mode: take vmode into account
Message-Id: <5118FD3F.5050201@je-eigen-domein.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360527814-28883-1-git-send-email-bos@je-eigen-domein.nl>
In-Reply-To: <1360527814-28883-1-git-send-email-bos@je-eigen-domein.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 02/11/2013 03:06 PM, Michal Suchanek wrote:
> On 11 February 2013 14:52, Floris Bos <bos@je-eigen-domein.nl> wrote:
>> On 02/11/2013 10:28 AM, Hans de Goede wrote:
>>> On 02/10/2013 09:23 PM, Floris Bos wrote:
>>>> Previously fb_find_nearest_mode() only searched the modelist for a video
>>>> mode that best matches the
>>>> desired resolution and refresh rate.
>>>> With this patch it also takes the vmode into account if there is more
>>>> then one mode with the same
>>>> resolution and refresh rate.
>>>> Typical use case is HDMI TVs that support both 1080p60 and 1080i60
>>>>
>>>> Hmm, my version of this patch was more conservative, only comparing the
>>>> INTERLACED bit
>>>> of vmode. I assume you've tested this, and it works as advertised? If so
>>>> ack.
>>
>> It works as advertised on my HDMI TV.
>> fbcon_new_modelist() which uses fb_find_nearest_mode() no longer tries to
>> switch from 1080p to 1080i after hot-plugging the same HDMI TV.
>>
>> But thinking of it, I wonder if it would be better to test on "vmode &
>> FB_VMODE_MASK" instead though.
>> So that it does tests on FB_VMODE_INTERLACED, FB_VMODE_DOUBLE and
>> FB_VMODE_ODD_FLD_FIRST
>> But not on FB_VMODE_YWRAP, FB_VMODE_SMOOTH_XPAN, FB_VMODE_CONUPDATE.
>>
> I don't have hardware with interlaced mode support so can't really test this.
>
> I would expect that it would be better to just switch to flagless
> modes when available and accept doublescan and interlaced when not.
>
> eg. when you unplug an interlaced TV and plug in a progressive capable
> TV the mode would be upgraded. Also when the old TV had 1080i50 and
> the new has 1080i50 and 1080p60 I would pick the latter mode as user
> unless in a very special situation.

Problem is that if you go looking for a BETTER mode, the function 
fb_find_NEAREST_mode would no longer behave like the name says.

It also poses problems when the user specifically asked for i50 because 
p60 gives problems, e.g. when the display provides the wrong EDID 
information and advertises modes it does not actually support.
Be aware that the function is not only called when a different display 
is plugged in, but also when the link to the exact same display is 
broken and restored (e.g. due to DPMS power saving).


Yours sincerely,

Floris Bos
