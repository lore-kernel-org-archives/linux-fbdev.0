From: "L.Y.Mesentsev" <L.Mesentsev@tvfiles.com>
Subject: TVIA CyberPro 5005 problem
Date: Tue, 12 Nov 2002 10:52:24 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DD0DD68.2070005@tvfiles.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [194.185.239.101] (helo=smtp.tvfiles.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18BXia-0000ND-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Nov 2002 01:52:25 -0800
Received: from tvfiles.com ([192.168.1.185])
	by smtp.tvfiles.com (8.11.2/8.11.2) with ESMTP id gAC9ASb27717
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Nov 2002 10:10:28 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi All,

Recently I've purchased a  settopbox from AllWell  ( 
http://www.gctglobal.com/Products/Set_Top_Box/Metallic6086N2/metallic6086n2.html 
)
equipped with  TVIA CyberPro 5005 chipset.  In order to use it with 
DirectFB + VDR under Linux I'm looking for framebuffer driver for it. 
 The only driver I've found is cyber2000fb available with a current 
kernels and it claims to support  ex-IGS (now TVIA) CyberPro 5000 
chipsets, that should be compatible with 5005 chipsets ( I have a full 
complete documentation on my chipset and it seems to be true ). The 
problem is that after cyber2000fb.o is correctly loaded into the kernel 
( it properly recognizes 500X chipset, video memory amount and don't log 
warnings either errors ) - I see a white square on the screen ( ~ 
640x480 on 720x576 )  traced with weird green diagonal lines. When I try 
to launch any example from DirectFB ( 640x480x16 60Hz for instance )  - 
the screen becomes flicking and  BW, but I can see the graphic output ( 
images & animation ).
Unfortunately I have not enough skill to solve this problem myself, but 
I have a full set of documentation for 500X chipset and  big desire to 
learn.

Please, help me to make this  chipset work  -  any help will be 
appreciated.  





-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
