From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Use of 'reserved' fields in var_screeninfo
Date: Mon, 14 Nov 2005 11:57:27 -0800
Message-ID: <4378EC27.7010502@mvista.com>
References: <4378E2CB.3080902@mvista.com> <Pine.LNX.4.62.0511142029340.15023@numbat.sonytel.be> <4378E997.50208@mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkSN-0002rB-5c
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:57:35 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=hermes.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbkSJ-0001UT-4K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:57:32 -0800
Received: from [127.0.0.1] (godzilla.mvista.com [10.0.0.2])
	by hermes.mvista.com (Postfix) with ESMTP id E02A41A6F1
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 11:57:27 -0800 (PST)
In-Reply-To: <4378E997.50208@mvista.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Kevin Hilman wrote:
> Geert Uytterhoeven wrote:
> 
>>What do you want to export there?
>>
> 
> 
> I'm just weighing the options of whether I should just add a new
> device-specific ioctl, or try to export this as part of the var_screeninfo.
> 

Come to think of it, no matter what I added to the screeninfo struct,
fbcon_switch() would have to be hacked to not disrupt any new fields since it
does a memset-to-zero.

I think a device-specific ioctl is the way to go.

Thanks for  the help.
-- 
Kevin Hilman
MontaVista Software -- http://www.mvista.com/



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
