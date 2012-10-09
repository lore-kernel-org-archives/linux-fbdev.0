From: Sekhar Nori <nsekhar@ti.com>
Date: Tue, 09 Oct 2012 06:44:52 +0000
Subject: Re: [PATCH 1/2] da8xx-fb: move panel information from driver to platform file
Message-Id: <5073C514.20409@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 10/8/2012 10:03 PM, Manjunathappa, Prakash wrote:
> Hi Sekhar,
> 
> On Mon, Oct 08, 2012 at 18:10:12, Nori, Sekhar wrote:
>> Hi Prakash,
>>
>> On 10/5/2012 7:21 PM, Manjunathappa, Prakash wrote:
>>> Moving panel information from driver to platform file, patch also made
>>> compliant to fb_videomode data.
>>>
>>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
>>
>> Why do you have to do this? Just moving panel data from driver to
>> platform code doesn't seem to buy anything.
>>
>> If you are passed DT data, then use it else continue the existing
>> platform data method? Once all the boards using this driver are
>> converted to DT, then all the panel information can be removed from
>> driver. That will save code.
>>
> 
> Because of following reasons I moved it out of driver
> 1)This patch also converts panel information compliant to fb_videomode.
> Patch "of: add display helper"[1] under review expects panel data in fb_videomode format.

Sounds like this should be a separate patch as this has got nothing to
do with moving panel information to platform code.

> 2)I felt difficult and unclean to have driver supporting both panel data from driver and panel data from DT.

Do you have any code where you tried this? If it is clean enough, can
you post it so we can all see what the alternate looks like?

> 3)This effort will also ease adding DT support of this driver.

It is still not clear to me why exactly it will ease adding DT support.

Thanks,
Sekhar
