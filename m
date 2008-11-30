From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/2] lcd: add support for Toppoly
	TDO35S series to tdo24m driver
Date: Sun, 30 Nov 2008 15:40:01 +0800
Message-ID: <f17812d70811292340s6ca3cf4ds64070c8d9a5c42ec@mail.gmail.com>
References: <492E8349.40309@compulab.co.il>
	<f17812d70811271713v7cc0e798pcd3c35bf2b3c84e8@mail.gmail.com>
	<49324176.8040904@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1L6guU-0006y0-05
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 07:40:06 +0000
Received: from rv-out-0708.google.com ([209.85.198.251])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L6guR-0007QU-1r for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 07:40:05 +0000
Received: by rv-out-0708.google.com with SMTP id f25so1883958rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 29 Nov 2008 23:40:01 -0800 (PST)
In-Reply-To: <49324176.8040904@compulab.co.il>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, eric miao <eric.miao@marvell.com>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

On Sun, Nov 30, 2008 at 3:32 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Eric Miao wrote:
>> Looks generally OK, yet I'd prefer
>>
>>   1. tdo24m.h being placed in "include/linux/spi/"
>>   2. when platform_data == NULL, default to TDO24M model?
>
> Ok, no problem.
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Acked-by: Eric Miao <eric.miao@marvell.com>

Richard,

Could you please help merge this into your backlight tree?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
