From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: S3triofb, pm3fb, retz3fb: abandoned?
Date: Thu, 13 May 2004 16:26:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A38578.7030403@irisa.fr>
References: <Pine.GSO.4.58.0405031952180.27296@waterleaf.sonytel.be> <Pine.LNX.4.58.0405131607090.24805@rosencrantz.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOH9v-0003cA-H6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 07:26:03 -0700
Received: from smtp.irisa.fr ([131.254.130.26])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOH9v-0000z8-2o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 07:26:03 -0700
In-Reply-To: <Pine.LNX.4.58.0405131607090.24805@rosencrantz.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

David Eger wrote:
> I ran across some interesting things grepping for "scrollmode" in the
> fb sources.  The framebuffer drivers shouldn't know about the console
> (at least any more), so references to "scrollmode" says something's up.
> I found the following:
> drivers/video/pm3fb.c:     disp[l_fb_info->board_num].scrollmode = 0;      /* SCROLL_YNOMOVE; *//* 0 means "let fbcon choose" */

I'm still the maintainer for pm3fbin 2.4, but not in 2.6.
Too many changes, so little time. Someone was planning on
updating it for 2.6, dunno the current status.

-- 
Romain Dolbeau


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
