From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 03/10] pxafb: fix
 __devinit/exit annotations
Date: Fri, 13 Jun 2008 09:24:04 +0800
Message-ID: <4851CC34.4050209@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>	<1213289961-1562-4-git-send-email-jayakumar.lkml@gmail.com>
	<20080612203639.e948ae52.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6y1T-0008E1-V4 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 18:24:11 -0700
Received: from ti-out-0910.google.com ([209.85.142.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6y1R-0002mk-DZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 18:24:11 -0700
Received: by ti-out-0910.google.com with SMTP id y6so1392661tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 18:24:08 -0700 (PDT)
In-Reply-To: <20080612203639.e948ae52.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Krzysztof Helt wrote:
> On Thu, 12 Jun 2008 12:59:14 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> 
>> This patch fixes pxafb's init/exit annotations. It uses __devinit/exit for
>> probe functions and __init for init functions. g_options is left as
>> __devinitdata since it is used by both.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>> ---
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 

Acked-by: Eric Miao <eric.miao@marvell.com>

> 
> ----------------------------------------------------------------------
> Sprawdz, czy jestes lepszy, niz Leo!
> kliknij >>> http://link.interia.pl/f1e2f
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
