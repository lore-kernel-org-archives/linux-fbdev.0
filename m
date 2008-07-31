From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Thu, 31 Jul 2008 06:45:52 -0400
Message-ID: <45a44e480807310345x736d43byca8ee1a915f70b8b@mail.gmail.com>
References: <20080731095910.DEF5C45B81F@f49.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOVfQ-00049K-TT for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 03:45:57 -0700
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOVfP-0006EO-Ab
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 03:45:56 -0700
Received: by nf-out-0910.google.com with SMTP id g16so162577nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 Jul 2008 03:45:53 -0700 (PDT)
In-Reply-To: <20080731095910.DEF5C45B81F@f49.poczta.interia.pl>
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
To: krzysztof.h1@poczta.fm
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "ymiao3@marvell.com" <ymiao3@marvell.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Jul 31, 2008 at 5:59 AM,  <krzysztof.h1@poczta.fm> wrote:
>> On Thu, 12 Jun 2008 12:59:17 -0400 Jaya Kumar <jayakumar.lkml@gmail.com>
>> wrote:
>>
>> > This patch converts gumstix over to the MFP configuration system and
>> adds
>> > bluetooth support. Added a CLK_32K clock to enable bluetooth.
>>
>> Please be aware that the regular fbdev maintainer (Tony) has been out
>> of contact for many months and that I very rarely read
>> linux-fbdev-devel.  So if/when you have fbdev patches which need
>> attention, please cc myself directly.
>>
>
> Andrew,
>
> Please skip Jaya patches. He sents them to arm-linux and fbdev-devel and got
> reviews from me and Eric Miao (I review and Ack only fb related patches, so the gumstix
> patch must be acked by Eric Miao).
>
> He fixed and reposted this set few times. The latest repost is here:
> http://marc.info/?l=linux-fbdev-devel&m=121742676828595&w=2
>
> However, according to Jaya's answer he wants to push this patches through the arm tree (RMK's patch system):
> http://marc.info/?l=linux-fbdev-devel&m=121734957011562&w=2
>
> Any repost of the set to the fbdev-devel will be reviewed by me.
>
> Regards,
> Krzysztof


Hi Andrew, Krzysztof,

Yes, I've been CCing fbdev for review and thanks to Krzysztof for
prior review of the fbdev patches. Once the patchset gets Eric's ack,
I'll push it through rmk for consistency since the previous pxafb
patches also went through rmk's tree.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
