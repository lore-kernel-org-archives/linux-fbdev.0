From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: Fw: device mapper & cryptsetup error and
   intelfb
Date: Wed, 05 Jan 2005 17:50:13 +0100
Message-ID: <41DC1AC5.9010602@worldonline.fr>
References: <20050104175159.244105a7.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmEN0-0007mt-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Jan 2005 08:50:50 -0800
Received: from smtp9.wanadoo.fr ([193.252.22.22])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CmEMw-0006DQ-0H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Jan 2005 08:50:50 -0800
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0906.wanadoo.fr (SMTP Server) with SMTP id 64BA81C001E1
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 Jan 2005 17:50:38 +0100 (CET)
Received: from worldonline.fr (AGrenoble-152-1-26-121.w82-122.abo.wanadoo.fr [82.122.144.121])
	by mwinf0906.wanadoo.fr (SMTP Server) with ESMTP id 8D9641C001A4
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 Jan 2005 17:50:37 +0100 (CET)
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

    Hi,

    I will only answer the intelfb problem. Are you using X ? I had=20
problems with the cursor and X, so i did a trick to restore the hw=20
cursor after an X session. And it's the messages you are seeing. Have=20
you always a good cursor, if yes the trick works and all is ok !

Sylvain

Andrew Morton a =E9crit:

>intelfb glitch...
>
>
>Begin forwarded message:
>
>Date: Wed, 29 Dec 2004 17:52:34 +0100
>From: Mateusz Berezecki <mateuszb@gmail.com>
>To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>Subject: device mapper & cryptsetup error and   intelfb
>
>
>1)
>Dec 29 17:42:41 localhost kernel: device-mapper: crypt: Error allocating=
=20
>crypto tfm
>Dec 29 17:42:42 localhost kernel: device-mapper: error adding target to=20
>table
>Dec 29 17:42:47 localhost udev[18896]: removing device node '/dev/dm-0'
>
>invoked with command:
>
>losetup /dev/loop0 /home/mb/fs1&&cryptsetup create crloop /dev/loop0 &&=20
>mount /dev/mapper/crloop /media/crypted
>
>2)
>
>i also get a plenty of  such messages
>
>intelfb: intelfb_check_var: accel_flags is 1
>intelfb: the cursor was killed - restore it !!
>intelfb: size 8, 16   pos 488, 0
>intelfb: intelfb_check_var: accel_flags is 1
>intelfb: the cursor was killed - restore it !!
>intelfb: size 8, 16   pos 792, 80
>intelfb: intelfb_check_var: accel_flags is 1
>intelfb: the cursor was killed - restore it !!
>intelfb: size 8, 16   pos 184, 752
>
>Is it normal behaviour ?
>
>
>hardware info:
>
>0000:00:02.0 VGA compatible controller: Intel Corp.=20
>82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
>thats from lspci
>and lspci -v
>
>0000:00:02.0 VGA compatible controller: Intel Corp.=20
>82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)=20
>(prog-if 00 [VGA])
>        Subsystem: Dell: Unknown device 0149
>        Flags: bus master, fast devsel, latency 0, IRQ 11
>        Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
>        Memory at f6f80000 (32-bit, non-prefetchable) [size=3D512K]
>        Capabilities: [d0] Power Management version 1
>
>Maybe this helps.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>-------------------------------------------------------
>The SF.Net email is sponsored by: Beat the post-holiday blues
>Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
> =20
>





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
