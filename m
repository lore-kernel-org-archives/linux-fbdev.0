From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Problem with 2.6.11-bk[3456]
Date: Thu, 10 Mar 2005 20:47:28 -0800
Message-ID: <20050310204728.3969cfa1.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9c4E-0004dP-BI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 20:48:06 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D9c4C-00017k-P8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 20:48:06 -0800
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
Cc: Andrew Clayton <andrew@digital-domain.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


Thanks for the report, Andrew.  I'll add this to my (huge) pile of
post-2.6.10 regressions...


Begin forwarded message:

Date: Thu, 10 Mar 2005 22:08:19 +0000
From: Andrew Clayton <andrew@digital-domain.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problem with 2.6.11-bk[3456]


Hi,

Got a problem here with the last few Linus -bk releases.

2.6.11-bk2 is running fine.

2.6.11-bk3 - 2.6.11-bk6 has the following problem:

Everything is fine while the machine is booting. However as soon as X
starts up the screen goes blank as normal but stays blank, no gdm login
screen and the hard disk and floppy drive lights are on continuously.
The machine is now locked up solid and needs a hard reset.

I tried a serial console but get nothing after the kernel messages and
the agetty login.

The machine is question is an UP Athlon 1800+ XP with 768MB RAM, the
graphics card is an AGP ATI Radeon 9200SE using the kernel AGP/DRM
drivers and the Xorg radeon driver.

It's running FC3.


I've put 2.6.11-bk2 and 2.6.11-bk6 config's, dmesg's and an lspc -vv up
on the web.

http://digital-domain.net/kernel/2.6.11-bk2.config
http://digital-domain.net/kernel/2.6.11-bk6.config
http://digital-domain.net/kernel/2.6.11-bk2.dmesg
http://digital-domain.net/kernel/2.6.11-bk6.dmesg
http://digital-domain.net/kernel/lspci-vv


When looking at this the other day I did get a message on the serial
console after X started and the machine locked, about uhci host
controller being disabled or something. Unfortunately I didn't make a
note of it and didn't get it today for when I was preparing this report.

Looking at the two dmesg's there is some difference in the usb messages.


Anyway, thanks for your time and if you need any more info just let me
know.


Cheers,

Andrew Clayton
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
