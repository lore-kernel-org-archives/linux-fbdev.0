From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH] atmel_lcdfb: silence compiler
 warning in device info printk
Date: Thu, 29 Oct 2009 14:34:23 +0100
Message-ID: <4AE999DF.9050301@evidence.eu.com>
References: <1256818234-16955-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<4AE995F1.6010307@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <claudio@evidence.eu.com>) id 1N3VIH-0003WF-7V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:44:01 +0000
Received: from aa002msb.fastweb.it ([85.18.95.81])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3VIC-00043y-B6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:44:01 +0000
In-Reply-To: <4AE995F1.6010307@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jkosina@suse.cz

Nicolas Ferre ha scritto:
> Hans-Christian Egtvedt :
>   
>> This patch will tell printk the format for irq_base is a decimal and not an
>> unsigned long. The irq_base is defined as an int in the struct
>> atmel_lcdfb_info.
>>     
>
> Hi Hans-Christian,
>
> I guess this patch is already submitted using the name:
>
>     atmel_lcdfb.c: fix printk() type mismatch
>
> It goes his way using "trivial" git tree. It is already in linux-next
> (baad1b580a7d08a4062a7f50eab0e06f90ad94d6) and I hope it will be
> included in 2.6.32-final.
>   
Hi Hans-Christian,

I confirm that I sent this patch on October 8th to this list and to LKML 
too (http://lkml.org/lkml/2009/10/8/67).

Then, the patch has been re-sent by Nicolas on October 9th 
(http://lkml.org/lkml/2009/10/9/86) and finally applied by Jiri Kosina 
(http://lkml.org/lkml/2009/10/9/218).

Many thanks anyway.

Best regards,

Claudio

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
