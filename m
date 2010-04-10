From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 08/16] viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
Date: Sat, 10 Apr 2010 02:42:52 +0200
Message-ID: <4BBFC98C.5010805@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<1270746946-12467-9-git-send-email-corbet@lwn.net>	<4BBF9EE7.50707@gmx.de> <20100409181942.175b375a@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100409181942.175b375a@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> On Fri, 09 Apr 2010 23:40:55 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> I don't like the idea of OLPC specific code. Isn't there any way to 
>> speed this up in general?
> 
> Architecture-specific code happens.  OLPCs are wired differently; if
> you go trying to do LVDS out those GPIO ports on an OLPC, you'll not
> end up talking to the hardware you think you're talking to.  The best
> thing to do is to avoid it altogether.

*sigh* I feared it would be something like this.

>> There is not yet even an option for OLPC_XO_1_5 (in contrast to 
>> CONFIG_OLPC) in mainline. Is such a thing planned?
> 
> Yes, it is.  That's part of the remaining OLPC support code which has
> also been brought forward to 2.6.34 with the intention of mainlining it.
> 
>> I can't really see anything that would speak for accepting this patch 
>> now in current mainline, sorry.
> 
> If you can come up with a better solution to the problem, I'm all
> ears.  But without it you'll have a hard time running mainline kernels
> on XO 1.5 systems.  It is all coming, but the OLPC folks are scrambling
> to get everything together; I don't think we really need to make things
> harder for them.

Sadly no as you probably know the OLPC hardware much better than me.
However I do not intend to give the OLPC folks a hard time.

> That said, machine_is_olpc() is properly defined for all
> configurations, so the #ifdefs can (and should) come out.

I'm not sure I get you right here. If you talk about removing the 
defines and only letting the machine check that is something that I 
would accept now. If this is not what you meant I think it would be 
better to move this patch to the series adding the config option.


Thanks,

Florian Tobias Schandinat
