From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev cursor part 1.
Date: Tue, 17 Feb 2004 10:35:27 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076974526.1046.105.camel@gaston>
References: <Pine.LNX.4.44.0402162221001.21833-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AssLJ-0005Bf-NB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 15:40:01 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AssBo-0002Ay-PH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 15:30:12 -0800
In-Reply-To: <Pine.LNX.4.44.0402162221001.21833-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-02-17 at 09:26, James Simmons wrote:
> Hi!
> 
>    I broke up the cursor patch. This patch creates a seperate cursor 
> image drawing region and regular drawing region. It does not break any 
> drivers to my knowledge. I posted it anyways for people to test it. The 
> patch is against 2.6.3-rc3. Please try.

Andrew, that one seem to work fine for me, been hammered for some time
in the fbdev tree. It should go to -mm for a while imho so we get more
broader testing, and eventually in 2.6.4

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
