From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Radeon 2D Acceleration for 2.6
Date: Wed, 21 Jan 2004 22:10:09 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1074683409.973.16.camel@gaston>
References: <Pine.LNX.4.50L0.0401201543490.1525-200000@rosencrantz.pok.ibm.com>
	 <1074638876.793.47.camel@gaston>
	 <Pine.LNX.4.50L0.0401210008080.16594-100000@rosencrantz.pok.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjGFd-0002MZ-Ao
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jan 2004 03:10:25 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AjGFc-0000aV-TE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jan 2004 03:10:25 -0800
In-Reply-To: <Pine.LNX.4.50L0.0401210008080.16594-100000@rosencrantz.pok.ibm.com>
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

On Wed, 2004-01-21 at 10:09, random wrote:
> Ben asks:
> > Can you re-export the cset as a patch in unified diff form please ?
> > 
> > (bk export -tpatch -du)
> 
> Now that I know the shortcut ;-)

Ok, it appears to work (though the gain isn't terrific, we probably
need imageblt for that). I reworked it and merged in my tree.

I tried to debug the lack of accel and it appears there is some more
deep breakage with fbcon in this regard. I gave up for now and made
accel unconditional (except for noaccel at boot).

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
