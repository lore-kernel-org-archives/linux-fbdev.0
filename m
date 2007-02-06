From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 0/7] RFC: Cell SPE logos
Date: Tue, 6 Feb 2007 22:06:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702062201430.3088@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEYSJ-0005zY-D9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 14:06:29 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HEYSG-0003Wd-VH
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 14:06:26 -0800
In-Reply-To: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>


> I would like to hear your opinions about the patchset below (updated version
> compared to yesterday, lkml added to the CC list).
> 
> The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
> threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
> When booting Linux, 2 penguins logos are shown on the graphical console by
> the standard frame buffer console logo code.
> 
> To emphasize the existence of the SPEs (which can be used under Linux), we
> added a second row of (smaller) helper penguin logos, one for each SPE.
> I attached a PNG version of the helper penguin logo for reference.
> 
> Summaries:
> [PATCH 1/7] fbdev: Avoid vertical overflow when making space for the logo
> [PATCH 2/7] fbdev: fb_do_show_logo() updates
> [PATCH 3/7] fbdev: extract fb_show_logo_line()
> [PATCH 4/7] fbdev: move logo externs to header file
> [PATCH 5/7] fbdev: Add fb_append_extra_logo()
> [PATCH 6/7] fbdev: SPE helper penguin logo
> [PATCH 7/7] Cell: Draw SPE helper penguin logos
> 
> Thanks for your comments!

    Now that their are patches for the logo I would like to see a few more 
improvements that I haven't gotten too. I really like to see the logo 
drawn outside of fbcon. This way for embedded platforms without fbcon we 
could have the logo to know if the graphics device worked.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
