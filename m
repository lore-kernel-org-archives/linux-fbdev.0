From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fw: Problem with 2.6.11-bk[3456]
Date: Fri, 11 Mar 2005 15:55:44 +1100
Message-ID: <1110516944.32556.352.camel@gaston>
References: <20050310204728.3969cfa1.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9cGv-0005D6-1g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 21:01:13 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D9cGu-0003cK-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 21:01:12 -0800
In-Reply-To: <20050310204728.3969cfa1.akpm@osdl.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Clayton <andrew@digital-domain.net>

On Thu, 2005-03-10 at 20:47 -0800, Andrew Morton wrote:
> Thanks for the report, Andrew.  I'll add this to my (huge) pile of
> post-2.6.10 regressions...

I saw a couple of DRM fixes around, could be that. Or could be related
to radeonfb, was the user using it ? Can he test with vgacon ? Though
I'm not aware of any problem with the 9200SE ...

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
