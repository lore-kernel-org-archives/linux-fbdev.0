From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 14 Mar 2017 16:08:40 +0000
Subject: Re: [PATCH v7 2/2] backlight arcxcnn add support for ArcticSand devices
Message-Id: <44a210ee-f0c4-3933-c696-09446028d249@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489429323-6103-1-git-send-email-olimpiu@arcticsand.com>
 <d628cdbc-dbc4-1065-23e8-63c0d6a2dd86@linaro.org>
 <61f6e116-6190-72f3-ca89-54c9a94a6ac2@arcticsand.com>
In-Reply-To: <61f6e116-6190-72f3-ca89-54c9a94a6ac2-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Dodge <bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, medasaro-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org

On 14/03/17 15:53, Brian Dodge wrote:
> Hi Daniel,
>
> Yes checkpatch.pl was telling us this. I didn't think we had the
> "authority" to modify that file.

You don't really need authority to propose changes (e.g. send a patch). 
I guess you might attract sharp words from a maintainer if the proposed 
change were conspicuously reckless or extremely short sighted ("my use 
case is the only one that really matters") but I don't see any risk of 
that here.

Think of it like this: if folks with @arcticsand.com mail addresses 
don't try to document the vendor prefix, who will?


 > Is it OK if we put the
> vendor-prefixes.txt change in the first patch (device tree bindings) or
> so you think we should have an 0003 patch for just that?

Personally I'd add it as a new patch but I'd make it the *first* patch 
in the series.


Daniel.


PS Top posting *is* something that will eventually attract sharp words
    from some maintainers ;-)


> On 03/14/2017 06:16 AM, Daniel Thompson wrote:
>> On 13/03/17 18:22, Olimpiu Dejeu wrote:
>>> backlight: Add support for Arctic Sand LED backlight driver chips
>>> This driver provides support for the Arctic Sand arc2c0608 chip,
>>>     and provides a framework to support future devices.
>>> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>>
>> Please could you also submit a patch to add arc to
>> ./Documentation/devicetree/bindings/vendor-prefixes.txt.
>>
>> checkpatch.pl should have been asking you to do since v1 but only if
>> you test the patch series against a clean kernel (tools such as aiaiai
>> can help with this).
>>
>> However, once that is attended to:
>>
>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>>
>> Daniel.
>

