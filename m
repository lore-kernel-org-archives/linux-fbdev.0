From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 17:56:49 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404291740560.1327-100000@phoenix.infradead.org>
References: <1083201619.21436.114.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJEqE-0001OS-8y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 09:56:54 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BJEqE-0006a5-0a
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 09:56:54 -0700
In-Reply-To: <1083201619.21436.114.camel@gaston>
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
Cc: Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > I would like to see that basic stuff being done in the kernel like
> > mode setting.  The drivers should have a better idea of modes than
> > libraries in userspace.

I agree. Mode setting is one of those things you have to do kernel side.

> Not really. The driver can extract the EDID infos from the card,
> but as far as building mode lists, at one point, we really want
> that to be moved down to userspace. One of the problems is that
> a lot of monitors have bogus EDID blocks. We need a mecanism to
> provide "overrides" based on manufacturer/product ID for example,
> I don't think it's something that should be in the kernel.

We already have such things in the kernel. DMI blacklist in the kernel on 
the x86 platform. Also we have PCI fixups in the kernel. Should we move 
those to userland as well. Now if you believe in a micro kernel design 
then that is a yes. In struct fb_monspecs we have a monitor identity 
field. So we can deal with this. Also if we have a corrupt EDID block then 
we can default to using the default modedb. Its not a hard problem.

> Finally, the geometry of screens is something that has nothing to
> do in the kernel imho.

I don't like micro kernel designs. This is way micro kernels handle this 
problem.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
