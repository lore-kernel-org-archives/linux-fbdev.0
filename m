From: James Simmons <jsimmons@infradead.org>
Subject: Re: I2C standalone vs integrated?
Date: Fri, 17 Oct 2003 17:43:34 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310171739520.363-100000@phoenix.infradead.org>
References: <1066299274.644.130.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAdvp-0008UX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 16:22:53 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAXjd-0003dh-5x
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 09:45:53 -0700
In-Reply-To: <1066299274.644.130.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Regarding the standalone, I'm not too sure about it. I even though about
> not using the linux i2c layer at all, it's not very convenient, and we
> need to wrap the i2c accesses in all sort of tweaks to make DDC work
> properly in all cases (all the stuff in radeon_probe_i2c_connector()
> typically).
> 
> I'd rather see things built on top of framebuffer drivers (fbcon staying
> something separate).

I see us doing something like ALSA did for i2c. I don't think it would be 
easy to use stand alone i2c drivers.




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
