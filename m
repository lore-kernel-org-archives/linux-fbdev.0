From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] sstfb.c: make some code static
Date: Thu, 25 Nov 2004 16:50:45 +0000
Message-ID: <1101401444.18354.35.camel@localhost.localdomain>
References: <20041121153646.GA2829@stusta.de>
	 <1101336587.2571.1.camel@localhost.localdomain>
	 <20041125153607.GC3537@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXNoe-0007Iw-E8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 09:54:00 -0800
Received: from [81.2.110.250] (helo=localhost.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CXNod-00037o-HR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 09:54:00 -0800
In-Reply-To: <20041125153607.GC3537@stusta.de>
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

On Iau, 2004-11-25 at 15:36, Adrian Bunk wrote:
> The "ifdef crap" comes from the fact, that after making the functions 
> static, gcc warns if they are unused.

__attribute__ is your friend in that situation.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
