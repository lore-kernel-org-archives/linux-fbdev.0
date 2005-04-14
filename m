From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [Bugme-new] [Bug 4468] New: Upgrade to 2.6.11.6 results in no longer being able to turn the lcd backlight off.
Date: Thu, 14 Apr 2005 13:51:25 +0800
Message-ID: <200504141351.25084.adaplas@hotpop.com>
References: <20050410172843.6366ef8a.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLxH0-0000wa-JP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:18 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DLxGz-0005RJ-5G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 67D14152A737
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Apr 2005 05:52:06 +0000 (UTC)
In-Reply-To: <20050410172843.6366ef8a.akpm@osdl.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: klug@blarg.org

On Monday 11 April 2005 08:28, Andrew Morton wrote:

> Previous to my 2.6.11.6 upgrade I was running 2.6.9. With all unpatched 2.6
> kernel versions up to and including 2.6.9, I could turn the lcd backlight
> off by running "echo lcd_out:0 > /proc/acpi/toshiba/video" as root. I
> upgraded directly from 2.6.9 to 2.6.11.6. With the upgrade I am no longer
> able to turn the lcd backlight off. There is no effect after running "echo
> lcd_out:0 >
> /proc/acpi/toshiba/video" and the /proc/acpi/toshiba/video lcd_out option

Looks more like an acpi problem than fbdev/backlight.

> remains unchanged as 1. I recompiled the 2.6.11.6 kernel with the new
> option CONFIG_BACKLIGHT_LCD_SUPPORT=y. Enabling this option did not allow

Does not matter as intelfb does not use the backlight/lcd architecture yet.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
