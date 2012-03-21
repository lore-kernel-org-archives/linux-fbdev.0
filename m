From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 14:26:01 +0000
Subject: Re: [PATCH v4] fbdev: remove dependency of FB_SH_MOBILE_MERAM from FB_SH_MOBILE_LCDC
Message-Id: <4F69E4F9.9040000@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87obrqwxp2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obrqwxp2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 03/21/2012 02:09 PM, Laurent Pinchart wrote:
> On Wednesday 21 March 2012 14:01:00 Florian Tobias Schandinat wrote:
>> On 03/21/2012 01:49 PM, Laurent Pinchart wrote:
>>> On Tuesday 20 March 2012 18:27:08 Kuninori Morimoto wrote:
>>>> MERAM can be used for other IP blocks as well in the future.
>>>> It doesn't necessarily mean that the MERAM driver depends on the LCDC.
>>>> This patch corrects dependency.
>>>>
>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> ---
>>>> v3 -> v4
>>>>
>>>> - move config to before endpoint
>>>
>>> As the driver doesn't depend on FB and can also be used by other
>>> subsystems, would it make sense to move it out of drivers/video/ ?
>>> drivers/sh/ might be a candidate, although I think selecting a location
>>> based on the platform is frowned upon (drivers/platform/x86 comes to
>>> mind). There's probably a better location.
>>
>> Well, as long as it is related to video/graphic I think drivers/video is
>> a good location. There are also backlight and console in that directory
>> without being directly related to the framebuffer subsystem.
> 
> The MERAM can also be used by the video engine unit (a memory-to-memory format 
> conversion block), the video processing unit (a multi-codec module), the 
> capture engine unit (camera interface), the JPEG engine unit (a JPEG codec), 
> ... Not all of those are related to display, although they're all related to 
> display, imaging, and or/video. 

I see, thanks for the explanation.
I applied this patch so it can be used for such purposes without the
dependency. If there will be a better place for it in the future we can
move it than.


Best regards,

Florian Tobias Schandinat
