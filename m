From: Andrew Morton <akpm@osdl.org>
Subject: Fw: device mapper & cryptsetup error and   intelfb
Date: Tue, 4 Jan 2005 17:51:59 -0800
Message-ID: <20050104175159.244105a7.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cm0LT-0004O4-51
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 17:52:19 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cm0LM-0003DL-DQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 17:52:18 -0800
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id j051q7610006
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 4 Jan 2005 17:52:07 -0800
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


intelfb glitch...


Begin forwarded message:

Date: Wed, 29 Dec 2004 17:52:34 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: device mapper & cryptsetup error and   intelfb


1)
Dec 29 17:42:41 localhost kernel: device-mapper: crypt: Error allocating 
crypto tfm
Dec 29 17:42:42 localhost kernel: device-mapper: error adding target to 
table
Dec 29 17:42:47 localhost udev[18896]: removing device node '/dev/dm-0'

invoked with command:

losetup /dev/loop0 /home/mb/fs1&&cryptsetup create crloop /dev/loop0 && 
mount /dev/mapper/crloop /media/crypted

2)

i also get a plenty of  such messages

intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 488, 0
intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 792, 80
intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 184, 752

Is it normal behaviour ?


hardware info:

0000:00:02.0 VGA compatible controller: Intel Corp. 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
thats from lspci
and lspci -v

0000:00:02.0 VGA compatible controller: Intel Corp. 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03) 
(prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 0149
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Memory at f6f80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1

Maybe this helps.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
