From: Jon Smirl <jonsmirl@yahoo.com>
Subject: More Linux kernel PCI IDs vs Xfree - Radeon
Date: Sat, 9 Aug 2003 23:00:03 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030810060003.13994.qmail@web14909.mail.yahoo.com>
References: <328A30E823B7D511A0BF00065B042A3B0172D768@fgl00exh01.fgl.atitech.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ljFO-0006Pb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 09 Aug 2003 23:00:06 -0700
In-Reply-To: <328A30E823B7D511A0BF00065B042A3B0172D768@fgl00exh01.fgl.atitech.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Stohr <AlexanderS@ati.com>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

If these lists are ok I can generate patches....

xf86PciInfo.h is missing the following ids:

4136 Radeon IGP 320M A6
4164 Radeon R300 Ad Secondary (DVI) output
4336 Radeon Mobility U1 C6
4337 Radeon IGP 340M C7
496e Radeon R250 In [Radeon 9000] (Secondary)
4c6e Radeon R250 Ln [Radeon Mobility 9000 M9]
[Secondary]
4e44 Radeon R300 ND [Radeon 9700 Pro]
4e45 Radeon R300 NE [Radeon 9500 Pro]
4e46 Radeon R300 NF [Radeon 9700]
4e47 Radeon R300 NG [FireGL X1]
4e48 Radeon R350 NH [Radeon 9800]
4e64 Radeon R300 Nd [Radeon 9700 Pro] (Secondary)
4e65 Radeon R300 Ne [Radeon 9500 Pro] (Secondary)
4e66 Radeon R300 Nf [Radeon 9700] (Secondary)
4e67 Radeon R300 Ng [FireGL X1] (Secondary)
4e68 Radeon R350 Nh [Radeon 9800] (Secondary)
CAB0 Radeon IGP or AGP bridge?

linux/pci_ids.h is missing:

4136 Radeon IGP 320M A6
4144 Radeon R300 AD [Radeon 9500 Pro]
4145 Radeon R300 AE [Radeon 9500 Pro]
4146 Radeon R300 AF [Radeon 9500 Pro]
4147 Radeon R300 AG [FireGL Z1/X1]
4164 Radeon R300 Ad Secondary (DVI) output
4336 Radeon Mobility U1 C6
4337 Radeon IGP 340M C7
496e Radeon R250 In [Radeon 9000] (Secondary)
4c64 Radeon R250 Ld [Radeon Mobility 9000 M9]
4c65 Radeon R250 Le [Radeon Mobility 9000 M9]
4c66 Radeon R250 Lf [Radeon Mobility 9000 M9]
4c67 Radeon R250 Lg [Radeon Mobility 9000 M9]
4c6e Radeon R250 Ln [Radeon Mobility 9000 M9]
[Secondary]
4e48 Radeon R350 NH [Radeon 9800]
4e64 Radeon R300 Nd [Radeon 9700 Pro] (Secondary)
4e65 Radeon R300 Ne [Radeon 9500 Pro] (Secondary)
4e66 Radeon R300 Nf [Radeon 9700] (Secondary)
4e67 Radeon R300 Ng [FireGL X1] (Secondary)
4e68 Radeon R350 Nh [Radeon 9800] (Secondary)
5148 Radeon R200 QH [Radeon 8500]
5149 Radeon R200 QI
514a Radeon R200 QJ
514b Radeon R200 QK
5168 Radeon R200 Qh
5169 Radeon R200 Qi
516a Radeon R200 Qj
516b Radeon R200 Qk



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
