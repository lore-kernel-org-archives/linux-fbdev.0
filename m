From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Thu, 05 Feb 2004 11:55:22 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4022838A.8010502@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be> <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aonjh-0006na-Q9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 09:56:21 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Aonjg-0003zi-MK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 09:56:20 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Feb 2004 11:55:22 -0600
In-Reply-To: <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
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

>>How much?  Are things like the ammount and type of RAM autodetected or
>>just read from registers that the BIOS is supposed to set?

> Atyfb reads them from the registers.

So this is probally why all the values are jacked up.  They probally 
aren't set correctly to begin with.  I'll try hardcodeing them in the 
driver with what I think they should be.

> 1002:4c4d

Wonder why your device ID is differnet than mine.  Can you send me a 
'lspci -vv' of your M1?

James:

If you read this from the list...  I get your mail but for some reason I 
can't send you mail.  I get:

   Attempting TCP connection to [phoenix.ipv6.infradead.org : 25]
   A-record resolution of [phoenix.ipv6.infradead.org] in progress...
   Name server has no records of the requested type for that domain.

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
