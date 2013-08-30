From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 30 Aug 2013 08:44:11 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52205B5B.9000002@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 04:36 PM, Tomi Valkeinen wrote:
> On 30/08/13 11:17, Chen Gang wrote:
>> On 08/30/2013 03:21 PM, Tomi Valkeinen wrote:
> 
>>> I don't think you should use BUG there. BUG should be used when there's
>>> not really a good way to continue. Here you could have just a WARN, and
>>> return some default FIFO watermark value.
>>>
>>
>> i740_calc_fifo() is a static function, so we can check its caller's
>> information to find the suitable fixing ways (for extern function, we
>> almost can not do like this).
>>
>> it has only one caller i740fb_decode_var(), which has already let 'bpp'
>> within the values (8, 15, 16, 24, 32). So if another values occurs, it
>> must be a BUG (e.g. the stack may override under ia32).
> 
> My point was that there should almost never be need for BUG in a normal
> driver. BUG means that the whole kernel will probably halt. Even if an
> fb driver encounters a problem that should never happen, it should maybe
> give a WARN, and continue or fail in a controlled manner.
> 

e.g when the stack is override under ia32, it is better to stop continue
as soon as possible to try to avoid the kernel continue blindly, that
may let the coredump/KDB analyzers' work much easier.

Hmm... when driver cause issue, it has effect with the whole kernel
(kernel may die soon), so BUG() is used under the whole kernel wide
(include normal drivers).

>  Tomi
> 
> 

Thanks.
-- 
Chen Gang
