From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Tue, 11 Mar 2003 16:07:26 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111607080.23668-100000@phoenix.infradead.org>
References: <1046913411.1206.185.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18smJ1-00019W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 08:08:44 -0800
In-Reply-To: <1046913411.1206.185.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> However, the brokenness is really on the driver side.  They are unable
> to change the video mode unless they are supplied with the correct
> timing parameters where in fact they actually have the best knowledge on
> how to calculate them.  
> 
> So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
> we let the drivers calculate it for themselves?  I go for the latter, as
> fbcon really should not have any business with hardware.

I agree. 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
