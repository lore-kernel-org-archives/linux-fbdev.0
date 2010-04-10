From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [RFC] Initial OLPC Viafb merge
Date: Sat, 10 Apr 2010 03:02:28 +0200
Message-ID: <4BBFCE24.2070207@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<4BBEBE87.4000809@gmx.de>	<20100409124626.0b150104@bike.lwn.net>	<4BBFB914.1020600@gmx.de> <20100409182722.3080bb2d@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100409182722.3080bb2d@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> On Sat, 10 Apr 2010 01:32:36 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> Please correct me if I am wrong but the remaining 6 patches concerning 
>> suspend&resume look like a real big FIXME. So at the end it is expected 
>> to work only on VX855 and needs something called OFW?
> 
> OFW = OpenFirmware.  You could say BIOS instead.  It's pretty normal to
> expect the BIOS to put things into a semi-rational state at resume time.

So its more or less the same I always do for testing the module.

> Well, if we want to keep s/r out of tree, we can do that.  It will
> complicate the merge of the other stuff, since it's got hooks into the
> GPIO and camera code too.  But, like everything else I've posted so
> far, it's not the work that I personally set out to do.  I can push
> that work on others :)
> 
> That said, the suspend/resume support in this patch set makes suspend
> work on one chipset, and probably comes pretty close on the others
> without breaking anything there.  I don't see the harm in merging it;
> it makes the code better than it is now.  I would rather not have to
> separate it out from the rest.  But I'll not fight over this one; if
> there's real opposition then we can force OLPC to continue to carry it
> out of tree.

At least I'd like some more time (multiple weeks) to have a look at this 
issue & patches and try to come up with improvements that make it likely 
work on other IGPs and eventually not needing any BIOS/OFW. I agree its 
already an improvement but certainly one of the kind I like less as VIA 
could come up with such "improvements" too. IMHO it's a bad thing to 
push one chipset first if the target is to support all equally well (as 
long as the hardware permits).
So I'd be glad if you could go on with the patches that are less painful 
and get them ready for the merge window (as I really don't have a clue 
how long it will take me to get the suspend/resume stuff to a state I 
consider acceptable). Perhaps we should make suspend and resume a 
configure option and mark it as experimental?


Thanks,

Florian Tobias Schandinat
