From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 09:30:38 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083195037.28991.99.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIyc7-00061N-H2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:37:15 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIyc7-0005rI-84
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:37:15 -0700
In-Reply-To: <20040428163730.GA24448@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> 
> DRM and fbdev must merge so i repeat: just a single
> kernel entity should own FIFO queues, shared locks,
> DMA, the framebuffer, IO registers, interrupts, etc.

Right. I've been discussing that problem for a while. I think we really
need some common work here. When a mode change is requested by userland,
we need to take that lock, but we also need to set some flag in the DRM
to invalidate all state. I'm not sure what is the best way to do that at
this point though.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
