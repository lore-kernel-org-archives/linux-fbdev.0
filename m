From: Brian Dodge <bdodge@arcticsand.com>
Date: Tue, 14 Mar 2017 15:53:04 +0000
Subject: Re: [PATCH v7 2/2] backlight arcxcnn add support for ArcticSand devices
Message-Id: <61f6e116-6190-72f3-ca89-54c9a94a6ac2@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489429323-6103-1-git-send-email-olimpiu@arcticsand.com>
 <d628cdbc-dbc4-1065-23e8-63c0d6a2dd86@linaro.org>
In-Reply-To: <d628cdbc-dbc4-1065-23e8-63c0d6a2dd86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Olimpiu Dejeu <olimpiu@arcticsand.com>, robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, joe@perches.com, medasaro@arcticsand.com

Hi Daniel,

Yes checkpatch.pl was telling us this. I didn't think we had the 
"authority" to modify that file.   Is it OK if we put the 
vendor-prefixes.txt change in the first patch (device tree bindings) or 
so you think we should have an 0003 patch for just that?

Brian

On 03/14/2017 06:16 AM, Daniel Thompson wrote:
> On 13/03/17 18:22, Olimpiu Dejeu wrote:
>> backlight: Add support for Arctic Sand LED backlight driver chips
>> This driver provides support for the Arctic Sand arc2c0608 chip,
>>     and provides a framework to support future devices.
>> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>
> Please could you also submit a patch to add arc to
> ./Documentation/devicetree/bindings/vendor-prefixes.txt.
>
> checkpatch.pl should have been asking you to do since v1 but only if 
> you test the patch series against a clean kernel (tools such as aiaiai 
> can help with this).
>
> However, once that is attended to:
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>
> Daniel.

