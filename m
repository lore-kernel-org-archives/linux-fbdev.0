From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH] ATI Mach64 accelerated imgblit (sligthly improved)
Date: Sat, 17 Jan 2004 20:35:39 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401172035.39409.alex.kern@gmx.de>
References: <200401170120.25603.alex.kern@gmx.de> <Pine.GSO.4.58.0401171924220.1950@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhwEY-0004p1-5w
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 11:35:50 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AhwEX-00044I-L1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 11:35:49 -0800
In-Reply-To: <Pine.GSO.4.58.0401171924220.1950@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Samstag, 17. Januar 2004 19:25 schrieb Geert Uytterhoeven:
> On Sat, 17 Jan 2004, Alexander Kern wrote:
> > here is a patch. Now it works with SUN12x22 font and 8, 16 and 32 bpp. I
> > have the strange issues with 24bpp. Should we simply drop acceleration
> > for this resolution?
>
> All acceleration, or just the imageblit? I don't think there's a problem
> with rectangle fill/copy in 24 bpp, or is there?
>
> Gr{oetje,eeting}s,
>
> 						Geert
No, it's only imageblit, which has issue.
Regards
Alex Kern



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
