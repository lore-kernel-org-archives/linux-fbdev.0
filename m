From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] ATI Mach64 accelerated imgblit
 (sligthly improved)
Date: Mon, 19 Jan 2004 18:11:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401191810530.2709-100000@phoenix.infradead.org>
References: <200401172035.39409.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aids7-0003Tk-Qk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 10:11:35 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aids7-0006Tj-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 10:11:35 -0800
In-Reply-To: <200401172035.39409.alex.kern@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Kern <alex.kern@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> No, it's only imageblit, which has issue.
> Regards
> Alex Kern

Applied your patch. I tested it and it works wonderful. I haven't tested 
in 24 bpp mode tho. I think that is a minor issue.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
