From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 20 Nov 2011 02:16:12 +0000
Subject: Re: Recent viafb changes break OLPC DCON freeze
Message-Id: <4EC862EC.9030604@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
In-Reply-To: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniel,

On 11/18/2011 04:09 PM, Daniel Drake wrote:
> On Thu, Nov 17, 2011 at 8:14 PM, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> As you mentioned it, I had a look at this driver. It looks like viafb does it
>> (polarity) just the other way around than geode. So it might be wort a try to
>> change in
>>
>> drivers/video/via/share.h:
>> /* 1200x900@60 Sync Polarity (DCON) */
>> #define M1200X900_R60_HSP       NEGATIVE
>> #define M1200X900_R60_VSP       NEGATIVE
>>
>> to
>>
>> /* 1200x900@60 Sync Polarity (DCON) */
>> #define M1200X900_R60_HSP       POSITIVE
>> #define M1200X900_R60_VSP       POSITIVE
> 
> That fixes the problem - thanks! Let me know if you'd like me to make
> a patch with that change (I can do so on Monday).

Yes, I'd appreciate it. Then I could queue this patch for 3.2, you might also
consider adding a "Cc: stable@kernel.org" to it so previous releases also get
fixed up.

> It may still be worth you looking at the diagnosis - in particular I
> think I may have found something that may clean up some of the
> uncertainty in commit 32fab7bc

True. Well I already know that it was required for some reason to get the
output, so I merged my branch with the fix before I merged the one with the
problematic patch, to make regression testing easier. So now we know the display
wiring on OLPC better than the driver did some releases ago, though I'd be
happier if I'd find a generic way to figure these display wiring out...


Thanks,

Florian Tobias Schandinat

> 
> Thanks
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

