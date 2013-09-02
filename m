From: Chen Gang <gang.chen@asianux.com>
Date: Mon, 02 Sep 2013 01:41:31 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <5223ECCB.9080701@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 06:52 PM, Tomi Valkeinen wrote:
> On 30/08/13 13:41, Chen Gang wrote:
>> On 08/30/2013 06:19 PM, Tomi Valkeinen wrote:
> 
>>> Here's some old discussion about BUG:
>>>
>>> http://yarchive.net/comp/linux/BUG.html
>>>
>>
>> Yeah, if it is not a real bug (can handle it), we should not use BUG(),
>> but when we are sure it is a kernel bug, and the kernel will continue
>> blindly, we need use BUG() to stop it.
>>
>> Just like the Linus Torvalds said in the link which you provide:
>>
>> "Rule of thumb: BUG() is only good for something that never happens and
>> that we really have no other option for (ie state is so corrupt that
>> continuing is deadly)".
> 
> I guess this is where we disagree. I don't see having a corrupt bpp
> value in a fb driver's internal function as "so corrupt that continuing
> is deadly".
> 

Hmm... at least we are agree with each other

  "at least now, it should be never happen", is it correct ?


And we are disagree with each other:

  "if it really happens, I think it is a critical bug, but you have different opinion", is it correct ?


> Anyway, if you insist on the BUG(), I'll leave this patch to
> Jean-Christophe. I'm only taking small-ish patches that have no open
> issues or disagreements.
> 

OK, thank you for spending your time resources to provide your
suggestion and opinion.

And welcome another members' suggestion and completions.

>  Tomi
> 
> 


Thanks.
-- 
Chen Gang
