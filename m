From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] sstfb.c: make some code static
Date: Wed, 24 Nov 2004 22:49:47 +0000
Message-ID: <1101336587.2571.1.camel@localhost.localdomain>
References: <20041121153646.GA2829@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXLW7-0000Uk-3J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:26:43 -0800
Received: from [81.2.110.250] (helo=localhost.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CXLW4-0001bE-UI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:26:42 -0800
In-Reply-To: <20041121153646.GA2829@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Sul, 2004-11-21 at 15:36, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.

No it doesn't. It makes some functions static (which is fine) and adds
some nasty messy pointless #ifdefs. It touches no variable at all.

Please check your description texts and also don't fill the kernel with
ifdef crap. Probably the __setup stuff should be a module param new
style too.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
