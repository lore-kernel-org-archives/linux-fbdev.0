From: Jianjun Kong <jianjun@zeuux.org>
Subject: Re: [PATCH] drivers: process failure
	of	sysfs_create_group()
Date: Tue, 11 Nov 2008 21:30:41 +0800
Message-ID: <20081111133041.GA10576@ubuntu>
References: <20081110105332.GA19358@ubuntu>
	<Pine.LNX.4.64.0811102229170.19341@anakin>
	<5d9b736f0811110205q719ad246t81cc00fd9997b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jianjun@zeuux.org>) id 1KztKF-00068i-KK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 13:30:35 +0000
Received: from smtp.zeuux.org ([210.51.160.52] helo=z.billxu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KztK7-0003eB-4N for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 13:30:35 +0000
Content-Disposition: inline
In-Reply-To: <5d9b736f0811110205q719ad246t81cc00fd9997b10@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Michal Januszewski <michalj@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Nov 11, 2008 at 11:05:15AM +0100, Michal Januszewski wrote:
>On Mon, Nov 10, 2008 at 22:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>>> When fail to call sysfs_create_group(), it should recycle resources and return the error.
>>> This patch fix for processing failure of sysfs_create_group().
>>
>> IIRC, the reasoning behind the current code is that a failure to create sysfs
>> entries is not critical, as it doesn't impact the correct functioning of the
>> core of the driver.
>
>That's correct -- that was exactly my reasoning behind this code.

Thanks for your confirm.

-- 
Jianjun Kong @_@ Happy Hacking
Homepage: http://kongove.cn/
Gtalk: kongjianjun@gmail.com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
