From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with radeon new ROM probe code
Date: Thu, 25 Sep 2003 15:41:27 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064497287.694.8.camel@gaston>
References: <1064425449.15996.58.camel@gaston>
	 <20030924181257.78090.qmail@web14914.mail.yahoo.com>
	 <20030925053916.GA2068@iliana>  <20030925121025.GA30733@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2WNz-000254-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 06:42:23 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A2WNx-0005fo-GJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 06:42:21 -0700
In-Reply-To: <20030925121025.GA30733@suse.de>
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
To: Stefan Reinauer <stepan@suse.de>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Jon Smirl <jonsmirl@yahoo.com>, Michel DXnzer <michel@daenzer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Whether it's an Open Firmware card or not can be read from the PCI
> headers stored in the ROM. Check the romheaders utility from OpenBIOS
> CVS ( http://www.openbios.org/ )
> 
> Look at the code here:
> http://cvs.openbios.org/cgi-dom/viewcvs.cgi/utils/romheaders.c?rev=1.2&content-type=text/vnd.viewcvs-markup
> 
> The program prints whether the rom is OpenFirmware, x86 or HP PA-Risc.
> Note that graphics cards can theoretically contain ROM images for both
> x86 and OF in one chip.

Yup, "Mac" cards can contain in theory both OF and x86 BIOS drivers, though
I yet have to find a vendor doing that....

Thanks for the pointers to code, I'll dig that out.

Regards,
Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
