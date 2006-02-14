From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700
	(M26) and ATOM bios support
Date: Wed, 15 Feb 2006 08:28:49 +1100
Message-ID: <1139952530.7903.31.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F97jG-0007rD-LL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Feb 2006 13:28:58 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1F97jF-00083H-8S
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Feb 2006 13:28:58 -0800
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
Cc: Solomon Peachy <pizza@shaftnet.org>

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
> 
> This code still has quirks, but I'm not sure if those are due to bugs in
> my patch or incomplete/buggy support for the RV410.  So I'd appreciate
> it if people could try this out, especially if they have a newer ATOM
> BIOS in their radeon card, and let me know what happens. 
> 
> Finally, this patch also has PCI IDs added for my Radeon Mobility X700 
> (M26) adapter. 

Hi !

What's the status of this patch ? Do you have a new version ? People are
heving enough problems with recent cards to justify getting something in
soon...

Thanks,
Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
