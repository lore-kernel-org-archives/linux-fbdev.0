From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 17:52:35 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310171751200.966-100000@phoenix.infradead.org>
References: <20031016210643.GD19795@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAXqD-0002ZS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 09:52:41 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAXqC-0004Yb-D0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 09:52:40 -0700
In-Reply-To: <20031016210643.GD19795@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Carlo E. Prelz" <fluido@fluido.as>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> - Could I2C be ported to kernel I2C api and separated?, so it use would not
> require the fbdev module loaded.

I don't think that can be done. At least not easily.
 
> - PCI IDs list should be in pci_ids.h as every other drivers, reality is
> that adding new IDs to pci_ids.h is not hard so your driver will not be the
> exception to the rule.

I agree here. We do need to watch out for the AGP drivers. Changing PCI 
Id's can break them. I dicovered that recently.




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
