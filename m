From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Wed, 07 Sep 2016 08:46:33 +0000
Subject: Re: [RESEND PATCH 0/3] fbdev: vfb: make VirtualFB more flexible
Message-Id: <57CFD3E9.70602@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/09/16 08:36, Tomi Valkeinen wrote:
> On 15/08/16 13:10, Vladimir Murzin wrote:
>> Hi,
>>
>> This short patch series is supposed to add some flexibility to the VFB
>> which should help with testing in display-less environment.
>>
>> Thanks!
>>
>> Vladimir Murzin (3):
>>   fbdev: vfb: add description to module parameters
>>   fbdev: vfb: add option for video mode
>>   fbdev: vfb: simplify memory management
>>
>>  drivers/video/fbdev/vfb.c |  129 ++++++++++-----------------------------------
>>  1 file changed, 27 insertions(+), 102 deletions(-)
> 
> Looks fine to me. Can you check if the vfb_default can be constified? I
> can make the change, so no need to resend.

I don't see issues with vfb_default constified.

Thanks for feedback!

Vladimir

> 
>  Tomi
> 

