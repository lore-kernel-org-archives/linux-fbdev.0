From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Thu, 05 Feb 2004 15:37:07 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4022B783.8070002@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be> <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be> <4022838A.8010502@bitworks.com> <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AorBa-0003CP-Dm
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 13:37:22 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AorBZ-0001tD-VD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 13:37:22 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Feb 2004 15:37:09 -0600
In-Reply-To: <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>
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

>>>1002:4c4d
>>
>>Wonder why your device ID is differnet than mine.  Can you send me a
>
> Because mine is AGP and yours is PCI?

Should not matter.  Chip has both interfaces on it and AGP is just PCI 
with some additional signals.

>>'lspci -vv' of your M1?
> I can, but not right now. If the answer above doesn't satisfy you, just ask
> again.
> 

No rush. Im messing with a different project right now anyway.  But yes 
I'd still like a -vv of your chip when you can.

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
