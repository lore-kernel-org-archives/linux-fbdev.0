From: "Carl Vanderlip" <carlv@codeaurora.org>
Date: Mon, 21 Mar 2011 23:49:46 +0000
Subject: Re: [PATCH 17/20] video: msm: Prevent framebuffer glitch
Message-Id: <1f9ceab007818b26e65019950985fe88.squirrel@www.codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485574-27600-1-git-send-email-carlv@codeaurora.org>
	<4D87552D.4070205@ru.mvista.com>
In-Reply-To: <4D87552D.4070205@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


> Carl Vanderlip wrote:
>
>> Holds a reference to the mdp_clk until lateinit, and moves the
>> frambuffer
>> initialization to device_init.
>
>     Maybe I'm just blind but I don't see where the patch does the
> latter...
>
>> The framebuffer lcdc driver will grab a
>> reference to mdp_clk, which prevents the clock from being disabled by
>> clock_late_init.
>
>> Authors:
>> Dima Zavin <dima@android.com>
>> Rebecca Schultz Zavin <rebecca@android.com>
>> Colin Cross <ccross@android.com>
>

Fear not. You are not going blind :P, I got a bit overzealous when trying
to re-use the commit text that was available from the squashed patch that
this patch set is spawned from (hence why [18/20] also has this same
issue.
I will be re-writing this commit text for v2 (unless this c-text is
desired to be kept for "historical" purposes).

>> ---
>>  drivers/video/msm/mdp.c |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>
>> diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
>> index 0bb19fa..b3f334ad 100644
>> --- a/drivers/video/msm/mdp.c
>> +++ b/drivers/video/msm/mdp.c
>> @@ -38,6 +38,7 @@ struct class *mdp_class;
>>
>>  static DECLARE_WAIT_QUEUE_HEAD(mdp_ppp_waitqueue);
>>  static unsigned int mdp_irq_mask;
>> +struct clk *mdp_clk_to_disable_later;
>
>     Why not just 'mdp_clk'? :-)
>

I was not the original author for these variable names, though I do see
some reason behind the naming of this variable. I'd be more willing to
change this name, to "mdp_clk" if it weren't so visually similar to
mdp->clk (tired programmer eyes/brain could read (or write) the wrong
one).

As it is, the name is a little long, but it makes it extraordinarily clear
what its purpose is (i.e. you know exactly what it is being used for
without having to go searching for other places it is used).

So while I don't like the name as it is, I don't really like 'mdp_clk'
either (though would be willing to change it if anyone feels like being
stubborn :-)).

    -Carl V.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

