From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Tue, 02 Dec 2003 02:32:40 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FCC4018.4020503@undead.cc>
References: <1070348676.4311.39.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AR51m-0007oI-Af
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Dec 2003 23:32:58 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AR51l-0005si-Pu
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Dec 2003 23:32:57 -0800
In-Reply-To: <1070348676.4311.39.camel@gaston>
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

>THe title says it all, is fbcon supposed to work properly in 15/16 bpp
>in 2.6 ? I tried making sure my palette was properly reset for the
>new bit depth etc... in radeonfb, but I only ever get pink chars on
>cyan background, I didn't do the color component math but it could
>very well be just an endian bug in the 15/16 bpp drawing routines.
>
>  
>
I breifly tried it on one machine that had a Nvidia TNT2 in it and it 
worked fine.   I just tried it on my 9200 and I get the magenta/cyan 
thing as well. 

John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
