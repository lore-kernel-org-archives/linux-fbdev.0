From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: (no subject)
Date: Sat, 15 Apr 2006 07:47:24 +0200
Message-ID: <444088EC.9020808@t-online.de>
References: <200604141502.k3EF2u4C031951@falbala.ti.uam.es>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUdkh-0002Mw-C0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:55:23 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FUdkg-0000z1-8j
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:55:23 -0700
In-Reply-To: <200604141502.k3EF2u4C031951@falbala.ti.uam.es>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


>intelfb: Framebuffer driver for Intel(R)
>830M/845G/852GM/855GM/865G/915G/915GM chipsets
>intelfb: Version 0.9.2
>intelfb: 00:02.0: Intel(R) 855GME, aperture size 128MB, stolen memory 892kB
>intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
>intelfb: Video mode must be programmed at boot time.
>
>
>the driver (*) is inside kernel.
>  
>
Yes - of course, why not? It should be possible to compile a framebuffer
driver into the kernel without problems, and it should be possible to
load it as a module ... even from within xterm ;-)

Why do you believe that this is related to any of the problems?

cu,
 knut


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
