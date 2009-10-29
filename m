From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: silence compiler
 warning in device info printk
Date: Thu, 29 Oct 2009 14:25:22 +0100
Message-ID: <20091029142522.7030f634@hcegtvedt.norway.atmel.com>
References: <1256818234-16955-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<4AE995F1.6010307@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hans-christian.egtvedt@atmel.com>)
	id 1N3V0c-00069R-Dd for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:25:46 +0000
Received: from relay.atmel.no ([80.232.32.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3V0T-0007HX-NS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Oct 2009 13:25:46 +0000
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
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 29 Oct 2009 14:17:37 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Hans-Christian Egtvedt :
> > This patch will tell printk the format for irq_base is a decimal and not an
> > unsigned long. The irq_base is defined as an int in the struct
> > atmel_lcdfb_info.
> 
> Hi Hans-Christian,
> 
> I guess this patch is already submitted using the name:
> 
>     atmel_lcdfb.c: fix printk() type mismatch
> 

Okay, thanks, sorry for the noise.

-- 
Best regards,
Hans-Christian Egtvedt

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
