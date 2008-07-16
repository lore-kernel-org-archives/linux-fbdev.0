From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 2/5] gumstix: conversion to
	MFP support and add bluetooth support
Date: Wed, 16 Jul 2008 15:13:01 +0800
Message-ID: <f17812d70807160013y48261c07p9f17fc2b0f342157@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-3-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807152355t72247d4dt34763c580e0f607b@mail.gmail.com>
	<45a44e480807160009p4516c6a5l3edffd6c0a4da9e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ1CB-0001cg-4E for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:13:03 -0700
Received: from rv-out-0708.google.com ([209.85.198.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ1CA-00070e-K2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:13:02 -0700
Received: by rv-out-0708.google.com with SMTP id f25so4493408rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 00:13:02 -0700 (PDT)
In-Reply-To: <45a44e480807160009p4516c6a5l3edffd6c0a4da9e8@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Jul 16, 2008 at 3:09 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Tue, Jul 15, 2008 at 11:55 PM, eric miao <eric.y.miao@gmail.com> wrote:
>> On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>>> This patch converts gumstix over to the MFP configuration system and adds
>>> bluetooth support. Added a CLK_32K clock to enable bluetooth.
>>>
>>
>> The CLK_32KHz is assumed to be enabled always, so it's really not
>> necessary to create a struct clk for it. Please remove that from this
>> patch.
>>
>
> Hi Eric,
>
> Ok, I will take it out.
>
> To clarify, the bulk of gumstix's that have been shipped all come with
> U-boot 1.1.4 which does not turn it on by default and so my intention
> based on your previous feedback was basically: if CLK_32K not on, then
> warn the user, and then turn on the clk32k so that bluetooth works on
> such boards.
>

Then we should probably enable the 32K OSCC in the board init code
instead, maybe gumstix_init_32K() in gumstix_init(). Feel free to fire
another patch for this please, and leave enough comments.


> Thanks,
> jaya
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
