From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Tue, 02 Dec 2003 17:53:09 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FCD17D5.4040804@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc> <1070403757.4300.75.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARJOU-0006LS-PK
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 14:53:22 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ARJOU-0005cO-7l
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 14:53:22 -0800
In-Reply-To: <1070403757.4300.75.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Little or big endian machine ? Rivafb is accelerated in 2.6 (radeonfb
>is not). Can you check if that makes any difference ? I'll do some
>more tests here to try to figure it out, but so far, XFree had proper
>colors even when using radeonfb (UseFBDev set to "true").
>  
>
Little.  It's an single processor Athalon box.  I'll do the test later 
tonight as I don't want to reboot the other machine at the moment.

John





-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
