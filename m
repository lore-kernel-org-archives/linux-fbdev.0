From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 2/5] gumstix: conversion to
	MFP support and add bluetooth support
Date: Wed, 16 Jul 2008 00:09:18 -0700
Message-ID: <45a44e480807160009p4516c6a5l3edffd6c0a4da9e8@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-3-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807152355t72247d4dt34763c580e0f607b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ18b-0001G4-7w for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:09:21 -0700
Received: from nf-out-0910.google.com ([64.233.182.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ18Z-0002Fc-Oq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:09:21 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1560934nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 00:09:18 -0700 (PDT)
In-Reply-To: <f17812d70807152355t72247d4dt34763c580e0f607b@mail.gmail.com>
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
To: eric miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Jul 15, 2008 at 11:55 PM, eric miao <eric.y.miao@gmail.com> wrote:
> On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch converts gumstix over to the MFP configuration system and adds
>> bluetooth support. Added a CLK_32K clock to enable bluetooth.
>>
>
> The CLK_32KHz is assumed to be enabled always, so it's really not
> necessary to create a struct clk for it. Please remove that from this
> patch.
>

Hi Eric,

Ok, I will take it out.

To clarify, the bulk of gumstix's that have been shipped all come with
U-boot 1.1.4 which does not turn it on by default and so my intention
based on your previous feedback was basically: if CLK_32K not on, then
warn the user, and then turn on the clk32k so that bluetooth works on
such boards.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
