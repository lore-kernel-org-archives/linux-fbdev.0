From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 0/7] RFC: Cell SPE logos
Date: Wed, 31 Jan 2007 13:27:52 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCEZL-0004Vs-AK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:28:08 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCEZJ-00035o-RS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:28:07 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

	Hi,

I would like to hear your opinions about the patchset below (updated version
compared to yesterday, lkml added to the CC list).

The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
When booting Linux, 2 penguins logos are shown on the graphical console by
the standard frame buffer console logo code.

To emphasize the existence of the SPEs (which can be used under Linux), we
added a second row of (smaller) helper penguin logos, one for each SPE.
I attached a PNG version of the helper penguin logo for reference.

Summaries:
[PATCH 1/7] fbdev: Avoid vertical overflow when making space for the logo
[PATCH 2/7] fbdev: fb_do_show_logo() updates
[PATCH 3/7] fbdev: extract fb_show_logo_line()
[PATCH 4/7] fbdev: move logo externs to header file
[PATCH 5/7] fbdev: Add fb_append_extra_logo()
[PATCH 6/7] fbdev: SPE helper penguin logo
[PATCH 7/7] Cell: Draw SPE helper penguin logos

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
