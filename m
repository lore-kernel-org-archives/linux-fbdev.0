From: Richard Smith <rsmith@bitworks.com>
Subject: Mobility M1 refresh code problem 2.4.26?
Date: Thu, 06 May 2004 14:28:22 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409A91D6.4000508@bitworks.com>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org> <20040501004059.GD30285@guug.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLoYC-00029r-1r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 12:28:56 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BLoYB-0004DE-Ki
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 12:28:55 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 May 2004 14:28:21 -0500
In-Reply-To: <20040501004059.GD30285@guug.org>
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

I'm trying to get the Mobility M1 atyfb in 2.4.26 to work on Dell 
Latitude CPx.

If I boot he laptop with a CRT connected and run X windows everything 
works.  The x windows log reports its using a refresh rate code of 12

Compile atyfb without generic LCD support.

If I load atyfb the screen is almost there but lots of the text is 
messed up.  Line spacing seems correct but the actual text is 
unreadable.  Like a clock is off or something

If I now load the X windows driver (Still using ATI driver and not FB) 
the same type issues apears on the graphics.  It's almost there but some 
pixels appear to be mssing or in the wrong spot.

The X log now is pretty much identical but says that its useing a 
refresh rate code of 7.  XCLK and reference clocks are the same.

If I boot under the LCD and run X I get refresh rate of 12
When I load atyfb the LCD blanks out. But if I "modprobe atyfb;startx"
I get the same wiggy screen as under an CRT and again a refresh code of
7.

If I enable the Generic LCD support and load atyfb the LCD now displays 
data but has the same problem as the CRT and againg a refresh rate code 
of 7 if I run X and similar issues as the CRT setup yet the wiggyness is 
different.  Still mostly recognizeable though.

Where does atyfb calculate what it need to to set the refresh rate code 
and any idea why it might be doing it incorrectly on this laptop?

Its my understanding that the atyfb tree in 2.4 currently has the best 
M1 support and not 2.6.x.  If not then can someone point me to where I 
can find the latest patch for 2.6




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
