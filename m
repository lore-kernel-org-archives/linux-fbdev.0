From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 16 Aug 2011 06:41:57 +0000
Subject: Re: [RFC] fbdev: allow multiple concurrent visible consoles
Message-Id: <4E4A1135.6080502@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312799864-3468-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1312799864-3468-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Martin,

On 08/11/2011 10:57 AM, Martin Decky wrote:
> Hello Florian,
>
>> This patch allows having multiple visible consoles that receive
>> display updates. For example one can have running "top" to monitor
>> the system on fb0 and at the same time work on a shell on fb1.
>
> I hate to report this, because I would really appreciate this feature,
> but your patch (applied against kernel 3.0) breaks my machine.

Thank you for testing it. And you do not need to worry, the more feedback I get 
the more motivated I am to get it mainline.

> I have an x86-64 machine with a dual-GPU ATI Radeon HD 4850 X2 (which
> acts essentially as two discrete R700s) driven by the "radeon" KMS driver.
>
> If I use the "fbcon=map:01" boot option to map the even-numbered VCs to
> the first GPU and the odd-numbered VCs to the second GPU, the kernel
> patched with your patch encounters some sort of soft-lockup when
> initializing the second GPU (i.e. creating the fb1) while booting. The
> is no panic or oops message and I can reset the machine by hitting
> ctrl+alt+del, but there is no further progress. I can provide further
> observations if you would like to.

Interesting. With your fbcon option I was able to reproduce it (without it, it 
boots as expected). Unfortunately I was not yet able too figure out what causes 
this behavior. I guess it'll take me some time to get it right, probably not for 
the next merge window, but I'll continue to work on it.


Thanks,

Florian Tobias Schandinat
