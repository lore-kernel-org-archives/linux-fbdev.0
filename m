From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Radeon 2D Acceleration for 2.6
Date: Wed, 21 Jan 2004 08:40:00 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1074634799.764.27.camel@gaston>
References: <Pine.LNX.4.50L0.0401201543490.1525-200000@rosencrantz.pok.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj3ds-0001gL-EE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jan 2004 13:42:36 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aj3ds-0000DZ-23
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jan 2004 13:42:36 -0800
In-Reply-To: <Pine.LNX.4.50L0.0401201543490.1525-200000@rosencrantz.pok.ibm.com>
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
To: random <eger@theboonies.us>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-01-21 at 01:44, random wrote:
> Included are copyarea() and fillrect() for Radeon.  It is based on BenH's
> new driver in drivers/video/aty, and it works on my PowerBook.
> Please test.
> 
> To make this work, I've had to tell radeonfb.c to expect to always run
> accelerated.  It was checking if the FB_ACCELF_TEXT bit was set in the var
> passed in to enable acceleration, and it never was;  consequently, it
> never "ran accelerated" meaning it never called radeon_engine_init() and
> such.
> 
> Also, this is my first experience with BitKeeper, so let me know if I've
> screwed something up there (and anywhere else for that matter).

Excellent ! I planned to work on that after the big merge. I'll
review the patch this week and send it to James myself if it's
ok. Regarding FB_ACCEL_TEST, I suppose it could be the initial
mode set by radeonfb missing it, I'll check what's up, I don't
want to force it from userland requested modes at this point.

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
