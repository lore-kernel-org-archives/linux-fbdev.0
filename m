From: "seetaram Tekkalakot" <seetaram_nt@india.com>
Subject: Using VESA BIOS in Framebuffer driver
Date: Wed, 14 May 2003 12:20:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030514042029.24447.qmail@india.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 205-158-62-158.outblaze.com ([205.158.62.158] helo=spf1.us.outblaze.com)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Fnkp-0003gi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 21:20:35 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi Guys

I am developing a framebuffer driver for my PLC 69030 video card.
I have gone through the Source code of the Sample framebuffer driver and i have some clarifications needed. Please clarify my doubts.

1.How does the Frame buffer driver Switches graphics modes, i mean how does it initializes the graphics system say in 640*480*256 mode and switch to say 800*600*24 mode.
Does it depend on VESA BIOS calls to do this ?
Let me know.

2.How does the framebuffer driver achieve paging ?
Say my display memoy is 4mb and i want divide it into 4 pages then how will i do this ?

Please clarify my doubts

Thanks and regards
Seetaram
-- 
______________________________________________
http://www.india.com
Now with POP3/SMTP access for only US$14.95/yr

Powered by Outblaze


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
