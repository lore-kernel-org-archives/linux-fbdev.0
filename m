From: "xuhaoz" <xuhaoz@neonetech.com>
Subject: about fb_mmap
Date: Fri, 18 Jun 2004 14:08:14 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <PMEKJGJGKKPHMBEGKNMIEEIJCCAA.xuhaoz@neonetech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbCYy-0001rv-Km
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 23:09:20 -0700
Received: from [211.155.249.251] (helo=nnt.neonetech.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbCYx-0004a3-QE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 23:09:20 -0700
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


Hi all
	I have a question about fb_mmap in uclinux2.4.
	what is the usage of fb_mmap(struct file *file, struct vm_area_struct
*vma)
	my kernel is arm7 no mmu , does the fb_mmap function do some help for my
framebuffer driver if i use fb_mmap function?

		thanks for your help
		xuhaoz
				__________________
zhang xuhao
ICQ#: 116926669
More ways to contact me: http://wwp.icq.com/116926669
_________________________________________




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
