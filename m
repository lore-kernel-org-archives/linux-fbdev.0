From: James Simmons <jsimmons@infradead.org>
Subject: Re: atyfb expert needed
Date: Wed, 11 Feb 2004 22:29:34 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402112228230.25659-100000@phoenix.infradead.org>
References: <1076537453.868.123.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar2sE-0007sn-5V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:30:26 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ar2pw-0002Lv-Av
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:28:04 -0800
In-Reply-To: <1076537453.868.123.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, alex.kern@gmx.de

On Thu, 12 Feb 2004, Benjamin Herrenschmidt wrote:

> Hi ! I'm calling again for an atyfb expert ;)
> 
> The current driver in James tree (with generic lcd support) breaks
> the display on the LT-G chip of the powerbook wallstreet. I don't
> have time at the moment to dig into every change (there's a lot).
> 
> The "effect" is that the screen appears to be cut in vertical bands,
> each of them displaying a slightly offseted version of what should be
> there with some noise near the right edge.
> 
> If that symptom rings any bell about what registers can be wrong,
> that would help me a lot figuring out what's up.
> 
> Ben.

The main guy is Alex kern. There is a DEBUG flag in atyfb_base.c. Set it 
to #define an send the results to Alex. I CC him.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
