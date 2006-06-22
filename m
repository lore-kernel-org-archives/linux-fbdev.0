From: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
 Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 12:35:53 +0200
Message-ID: <449A7289.2000703@ed-soft.at>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
	<449A5A63.1080205@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtMXZ-0000yK-H0 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 03:36:01 -0700
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]
	helo=mognix.dark-green.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtMXY-0006lP-1R
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 03:36:01 -0700
Received: from [192.168.1.102]
	(81-223-173-114.taubstummengasse.xdsl-line.inode.at [81.223.173.114])
	by mognix.dark-green.com (Postfix) with ESMTP id D031642A817
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 12:35:54 +0200 (CEST)
In-Reply-To: <449A5A63.1080205@pobox.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

It' Supports the macbook pro. the pro is like the 17" imac "M_I17".

cu

gimli

Torgeir Veimo schrieb:
> Geert Uytterhoeven wrote:
>> ---------- Forwarded message ----------
>> Date: Wed, 21 Jun 2006 14:40:24 +0200
>> From: Edgar Hucek <hostmaster@ed-soft.at>
>> To: LKML <linux-kernel@vger.kernel.org>
>> Subject: [PATCH 1/1] New Framebuffer for Intel based Macs [try #2]
>>
>> This patch add a new framebuffer driver for the Intel Based macs.
>> This framebuffer is needed when booting from EFI to get something
>> out the box  ;)
>>
>> +typedef enum _MAC_TYPE {
>> +	M_I17,
>> +	M_I20,
>> +	M_MINI,
>> +	M_MACBOOK,
>> +	M_NEW
>> +} MAC_TYPE;
>>   
> This doesn't support the macbook pro?
> 


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
