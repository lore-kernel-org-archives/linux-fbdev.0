From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Mon, 7 Jul 2008 20:52:06 -0400
Message-ID: <45a44e480807071752k3d09f2cam786b9d4e56da964e@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
	<4851D4E9.3080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KG1RB-0003HL-SP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 17:52:09 -0700
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KG1RA-0005PN-Aj
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 17:52:09 -0700
Received: by ug-out-1314.google.com with SMTP id o29so1248569ugd.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Jul 2008 17:52:06 -0700 (PDT)
In-Reply-To: <4851D4E9.3080008@gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 10:01 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Jaya Kumar wrote:
>> diff --git a/include/asm-arm/arch-pxa/mfp-pxa25x.h b/include/asm-arm/arch-pxa/mfp-pxa25x.h
>> index 0499323..6c82a74 100644
>> --- a/include/asm-arm/arch-pxa/mfp-pxa25x.h
>> +++ b/include/asm-arm/arch-pxa/mfp-pxa25x.h
>> @@ -79,6 +79,7 @@
>>  #define GPIO43_HWUART_TXD    MFP_CFG_OUT(GPIO43, AF3, DRIVE_HIGH)
>>  #define GPIO44_HWUART_CTS    MFP_CFG_IN(GPIO44, AF3)
>>  #define GPIO45_HWUART_RTS    MFP_CFG_OUT(GPIO45, AF3, DRIVE_HIGH)
>> +#define GPIO45_HWUART_RTSL   MFP_CFG_OUT(GPIO45, AF3, DRIVE_LOW)
>
> Is this board specific or globally applicable? ISTR, RTS is low active,

I suspect it is board specific, ie: gumstix-[basix/connex]-bt
specific. I wasn't able to find schematics for this board but found
what is probably the same part of the design.

http://www.gumstix.org/schematics/B00002-HWUART.png?nocache=1

> so a HIGH in low power mode would be more appropriate that the remote
> DCE will hold its data to send.

I agree that RTS should start high. I'm not sure why the bt device
seems troubled in that state. I'll debug some more.

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
