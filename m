From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 2.6 fbcon and 15/16 bpp
Date: Tue, 02 Dec 2003 18:04:36 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1070348676.4311.39.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AR4b8-0006uA-ND
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Dec 2003 23:05:26 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AR4b8-00009e-7I
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Dec 2003 23:05:26 -0800
Received: from [202.81.18.30] (helo=gaston.ozlabs.ibm.com)
	by pentafluge.infradead.org with asmtp (Exim 4.22 #5 (Red Hat Linux))
	id 1AR4cZ-00059C-SC
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Dec 2003 07:06:56 +0000
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

THe title says it all, is fbcon supposed to work properly in 15/16 bpp
in 2.6 ? I tried making sure my palette was properly reset for the
new bit depth etc... in radeonfb, but I only ever get pink chars on
cyan background, I didn't do the color component math but it could
very well be just an endian bug in the 15/16 bpp drawing routines.

Ben.


(BTW. I never had any useful reply to my previous few questions about
the fbdev initialisation and about the mode settings...)





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
