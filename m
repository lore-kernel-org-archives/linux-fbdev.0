From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.11-rc5
Date: Fri, 25 Feb 2005 17:04:17 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0502251657220.9237@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de>
 <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org> <20050226005321.GA26468@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4qMd-0007ng-Jy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:03:23 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D4qMb-0008Dm-T1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:03:23 -0800
In-Reply-To: <20050226005321.GA26468@suse.de>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net



On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
> sparse doesnt do that, yet? (I never looked at it.)

No, it doesn't look at the section info. I guess I could do it, but there 
_is_ a "make buildcheck" which does it based on perl stuff and the link 
information. 

And I can do "make buildcheck" myself, but some people have done it before
and know which ones are false positives etc, so I was hoping..

Hint hint, wherever you are..

		Linus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
