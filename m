From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Thu, 05 Feb 2004 18:22:57 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4022DE61.4010607@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>	 <401FF39B.7090406@bitworks.com>	 <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>	 <40210CEA.5080102@bitworks.com>	 <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>	 <4022838A.8010502@bitworks.com>	 <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>	 <4022B783.8070002@bitworks.com> <1076021854.8483.119.camel@gaston>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AotmN-0006FH-MH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 16:23:31 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AotmN-0001CV-9r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 16:23:31 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Feb 2004 18:22:54 -0600
In-Reply-To: <1076021854.8483.119.camel@gaston>
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
To: benh@kernel.crashing.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>>>>>1002:4c4d
>>>>
>>>>Wonder why your device ID is differnet than mine.  Can you send me a
>>>
>>>Because mine is AGP and yours is PCI?

> No, ATI used to have both versions of the chip with different IDs

Hmmmm.. Looking at the 2.4.24 aty code 0x4c4d uses the m64n_mob_p which 
is described as "3D Rage Mobility (PCI)".  0x4c4e is "3D Rage Mobility 
(AGP)"  Geert if your device is really an AGP device then the 
description in the driver is wrong.

Ah.. I see that in the 2.6 fbdiff both descriptions are now AGP.  Cool 
so that probally why my device id is different.  Is there anything 
different that you have to do to with using the chip between AGP and PCI 
then?

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
