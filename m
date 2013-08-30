From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 30 Aug 2013 09:45:37 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <522069C1.40506@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 05:16 PM, Tomi Valkeinen wrote:
> On 30/08/13 11:44, Chen Gang wrote:
>> On 08/30/2013 04:36 PM, Tomi Valkeinen wrote:
>>> On 30/08/13 11:17, Chen Gang wrote:
>>>> On 08/30/2013 03:21 PM, Tomi Valkeinen wrote:
>>>
>>>>> I don't think you should use BUG there. BUG should be used when there's
>>>>> not really a good way to continue. Here you could have just a WARN, and
>>>>> return some default FIFO watermark value.
>>>>>
>>>>
>>>> i740_calc_fifo() is a static function, so we can check its caller's
>>>> information to find the suitable fixing ways (for extern function, we
>>>> almost can not do like this).
>>>>
>>>> it has only one caller i740fb_decode_var(), which has already let 'bpp'
>>>> within the values (8, 15, 16, 24, 32). So if another values occurs, it
>>>> must be a BUG (e.g. the stack may override under ia32).
>>>
>>> My point was that there should almost never be need for BUG in a normal
>>> driver. BUG means that the whole kernel will probably halt. Even if an
>>> fb driver encounters a problem that should never happen, it should maybe
>>> give a WARN, and continue or fail in a controlled manner.
>>>
>>
>> e.g when the stack is override under ia32, it is better to stop continue
>> as soon as possible to try to avoid the kernel continue blindly, that
>> may let the coredump/KDB analyzers' work much easier.
>>
>> Hmm... when driver cause issue, it has effect with the whole kernel
>> (kernel may die soon), so BUG() is used under the whole kernel wide
>> (include normal drivers).
> 
> You want i740_calc_fifo() to check the bpp parameter and issue a BUG if
> it's not a valid bpp-value, because in the current driver
> i740_calc_fifo() is never called with a non-valid bpp, and thus a wrong
> bpp indicates a stack corruption?
> 

Yes, it is just an e.g. (may also has another samples)

> How about the freq parameter? In the current driver freq can never be
> higher than 1000000. If it is, it's stack corruption. Maybe there should
> be a BUG for that case also?
> 

So I said:

"Hmm... it really has quite a few same cases in kernel wide like our
case, but at least they do not report warnings (this does not like our
case), so let just fix our case to satisfy the compiler. :-) "

> As I see it, you're just checking a single arbitrary value in an
> arbitrary place in the driver, and protecting against stack corruption
> there. Why not check all the values in all the functions of the driver
> as well, looking for stack corruptions?
>

BUG() can not protect issues, it can try to protect the kernel continue
blindly after kernel has issue.


> And the bigger issue is that you're only talking about the current
> driver. The driver could be changed tomorrow, maybe calling
> i740_calc_fifo() from some other place, where a wrong bpp could just
> possibly happen. In that case it wouldn't be a stack corruption, but a
> "normal" driver bug.
> 

Yeah, BUG() is for bugs in kernel wide, ('stack corruption' is just one
of sample).

And BUG() only report the direct cause, not report the root cause, so
when one sub system report BUG, it does not mean this sub system must
has this BUG.


> So, in my opinion:
> 
> - Normally we should presume the the stack is not corrupted, or
> otherwise we'll end up with lots of checks all over.
> 

It seems the above reply "Hmm... it really has quite a few same cases
..." is suitable for discussing with your opinion.


> - Even if i740_calc_fifo() is a static function, and we can analyze the
> _current_ situation, we don't know how the driver will evolve in the future.
> 

For normal static function (not callback function) it can be in control
within inside (ourselves), don't like extern function, it is out of
control with inside.

So we can assume something in the future.

>  Tomi
> 
> 

Thanks.
-- 
Chen Gang
