From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: VesaFB/OFFb power management.
Date: Sat, 25 Oct 2003 23:54:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067118878.3570.17.camel@gaston>
References: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADWN3-0003Fm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 14:54:53 -0700
Received: from griffin-can-au.getin2net.com ([203.43.225.34])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADWN0-0002oX-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 25 Oct 2003 14:54:51 -0700
Received: from gaston ([10.100.1.33])
	by griffin-can-au.getin2net.com (8.11.6/8.11.6) with ESMTP id h9PIrUs23272
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 07:53:30 +1300
In-Reply-To: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-10-23 at 01:09, James Simmons wrote:
> I like to be able to suspend and resume these drivers. I noticed the 
> SA1100 driver does this using struct device_driver. Is it possible to do 
> this for VesaFB/OFFb ? What would be the bus field then?There isn't much you can do with offb. This is a completely static
driver that inherits from the HW as it was set by the firmware and
can't change anything later on... except the palette with some hacks
on some known cards...

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
