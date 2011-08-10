From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 10 Aug 2011 21:01:59 +0000
Subject: Re: [PATCH v3 00/29] Use display information in info not in var for
Message-Id: <4E42F1C7.3000405@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310123683-8064-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310123683-8064-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent, Paul,

On 08/09/2011 12:35 PM, Laurent Pinchart wrote:
> On Wednesday 13 July 2011 10:24:24 Paul Mundt wrote:
>> On Fri, Jul 08, 2011 at 01:14:14PM +0200, Laurent Pinchart wrote:
>>> Hi everybody,
>>>
>>> Here's the third version of the FBIOPAN_DISPLAY fixes patch series.
>>>
>>> As a reminder, while playing with the FBIOPAN_DISPLAY ioctl I noticed
>>> that many drivers use information from the ioctl argument such as the
>>> display resolution when they should use the current settings from the
>>> fb_info structure.
>>>
>>> These 29 patches fix most of those drivers. Missing drivers are ivtv (for
>>> which a patch has Andy Walls has already pushed a patch),
>>> sh_mobile_lcdcfb (for which the fix is a bit more complex, I will work
>>> on it later) and viafb (for which Florian Tobias Schandinat has already
>>> sent a patch).
>>>
>>> The patches have been compile-tested on architectures for which I have a
>>> working compiler (x86 and ARM) with allyesconfig. I don't own any
>>> hardware supported by these drivers so I haven't been able to perform
>>> additional tests.
>>>
>>> I've split the fixes in one patch per driver for easier review and
>>> handling of potential problems. The patches can be squashed together if
>>> needed. I've tried to CC individual driver maintainers when possible,
>>> and Acked-by lines received in reply to the first version have been
>>> included.
>>>
>>> Compared to v2, I've fixed a compile issue in the atmel_lcdfb driver and
>>> added a couple of SoB lines.
>>>
>>> Paul, is it time to push this for 3.1 ?
>>
>> I have the v2 series queued up already, so it would be nice to simply
>> have the v2->v3 differences as incremental changes that can be piled on.
>> The signed-off-by lines are not that critical in this case since it's a
>> largely mechanical change all over the place, so it's primarily the build
>> fix(es?) that would be nice to have.
>
> I've sent you a fix on top of your v2 series a while ago, and none of these
> patches made it to v3.1-rc1.
>
> Is fbdev maintained at all ?

Yes, it is :)

Well I already wrote to Paul because of this and got a response. Basically he 
had to do other stuff/trees and felt that everything could go in after rc1 as well.
But if the situation persists that he has too much other stuff to do and no time 
left for fbdev I'd be willing to take over maintaining the fbdev stuff.
So you may rest assured that your work will not be lost and at worst be merged 
in the next merge window.


Best regards,

Florian Tobias Schandinat
