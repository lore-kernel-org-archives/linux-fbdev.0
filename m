From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700
	(M26) and ATOM bios support
Date: Thu, 05 Jan 2006 20:59:15 +1100
Message-ID: <1136455156.4840.76.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuRsy-0007TI-AL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 01:58:20 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EuRsx-0006xS-3D
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 01:58:20 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k059qNWG022433
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 5 Jan 2006 03:52:24 -0600
In-Reply-To: <20060103204404.GA23313@shaftnet.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2006-01-03 at 15:44 -0500, Stuffed Crust wrote:
> Signed-off-by:  Solomon Peachy <pizza@shaftnet.org>
> 
> Newer Radeon graphics cards use a different table layout in their 
> BIOSes, known as 'ATOM'.  
> 
> I've attached a patch (against 2.6.15) which implements the PLL and LVDS
> parsing out of the ATOM BIOSes, using the current X.org sources as a
> reference.  Notably absent is the code which detects the connectors and
> TDMS information, but it's of lesser importance at the moment.

Inresting. I started doing that (and updated the pre-ATOM BIOS code too)
but never finished... One thing you could do that would be useful is
move the various BIOS code to separate function and setup function
pointers that can be set based on the BIOS type instead of the endless
stream if (atom_bios) xxx else yyy. That way, it will be cleaner and
I'll be able to more easily add other variations like retreiving infos
from Open Firmware on ppc etc...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
