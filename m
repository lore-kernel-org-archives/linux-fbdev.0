From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 30 Aug 2013 10:41:16 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <522076CC.2030305@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 06:19 PM, Tomi Valkeinen wrote:
> On 30/08/13 12:45, Chen Gang wrote:
>> On 08/30/2013 05:16 PM, Tomi Valkeinen wrote:
> 
>>> So, in my opinion:
>>>
>>> - Normally we should presume the the stack is not corrupted, or
>>> otherwise we'll end up with lots of checks all over.
>>>
>>
>> It seems the above reply "Hmm... it really has quite a few same cases
>> ..." is suitable for discussing with your opinion.
> 
> Well, if other drivers do silly things, it's no reason to do it here also.
> 

Hmm... I can understand.  What I have done is only just "satisfy the
compiler".

>>
>>> - Even if i740_calc_fifo() is a static function, and we can analyze the
>>> _current_ situation, we don't know how the driver will evolve in the future.
>>>
>>
>> For normal static function (not callback function) it can be in control
>> within inside (ourselves), don't like extern function, it is out of
>> control with inside.
>>
>> So we can assume something in the future.
> 
> We can assume that only if we presume that the future changes are
> bug-free. But more often than not there are bugs in the kernel drivers.
> 

Yeah.

> Now, say, if such a bug is introduced, and somebody is running the
> kernel in a remote server, the driver will call BUG(). This will cause
> the server to halt. The user won't see what happened, the connections
> are just lost and the error is not written to a hard disk.
> 

For our case, it we don't call BUG(), the kernel will continue blindly,
and in most cases, at last it will die too (or zombie, or some other
critical issues).

So BUG() is only for trying to protect the kernel continue blindly.


> If, instead, the driver would do WARN, and continue or fail in a
> controlled manner, the user can find out about the issue easily. Even if
> there is a stack corruption, it's most likely the driver in question
> that has it, and thus not really fatal.
> 

Hmm, in my opinion, four our case, it is fatal, need try to stop kernel
as soon as possible (don't let it continue blindly).

> Sure, there's the possibility that there's a bigger memory corruption,
> which would go unnoticed by, say, the filesystem layer, resulting in a
> corrupted filesystem. And we would catch this corruption by checking the
> bpp variable. But, really, I find that very unlikely scenario.
> 

Yeah. In fact the reason why I focus on 'bpp' is because of "satisfying
the compiler" (not let it report warning).

> Here's some old discussion about BUG:
> 
> http://yarchive.net/comp/linux/BUG.html
> 

Yeah, if it is not a real bug (can handle it), we should not use BUG(),
but when we are sure it is a kernel bug, and the kernel will continue
blindly, we need use BUG() to stop it.

Just like the Linus Torvalds said in the link which you provide:

"Rule of thumb: BUG() is only good for something that never happens and
that we really have no other option for (ie state is so corrupt that
continuing is deadly)".

In fact, for our case, when "default" happens: it is just match the
contents above.

>  Tomi
> 
> 


Thanks.
-- 
Chen Gang
