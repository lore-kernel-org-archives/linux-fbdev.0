From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Mon, 09 Feb 2004 16:51:11 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40280EDF.5080709@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be> <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be> <4022838A.8010502@bitworks.com> <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be> <4022B783.8070002@bitworks.com> <Pine.GSO.4.58.0402061017120.398@waterleaf.sonytel.be> <4023F579.7030701@bitworks.com> <Pine.GSO.4.58.0402071852500.19574@waterleaf.sonytel.be>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqKGK-0000pS-3b
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 14:52:20 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AqKGJ-0007MR-MU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 14:52:19 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Feb 2004 16:42:58 -0600
In-Reply-To: <Pine.GSO.4.58.0402071852500.19574@waterleaf.sonytel.be>
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
To: geert@linux-m68k.org
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

 >>I don't think your chip is an M1.  The M1 is limited to 8 Megs of memory
 >>which is on chip and not expandable so I don't see how you can have 
16Megs.

 > It has 8 MiB of RAM.
 >
 > All Mach64 PCI/AGP variants show 16 MiB of PCI memory space, for up 
to 8 MiB of
 > video RAM. The second 8 MiB is the big endian aperture.

Ah my fbdev ignorance shows.  I messed with this lots this weekend and 
I'm pretty sure its a bios thing and not the driver.

In other news I gust got word today from ATI that I can release my code 
under GPL.  Woohoo!   I'm about to start porting over some dos code I 
have that is supposed to do a biosless init of the M1 for inclusion into 
LinuxBIOS.  I'll also try and add the same thing into atyfb when I have 
it all working.

Thanks for all your help.

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
