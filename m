From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 19:21:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410301921.34961.adaplas@hotpop.com>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041030032425.GI6677@stusta.de> <1099124920.2822.3.camel@laptop.fenrus.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNrK0-0001VA-Nu
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Oct 2004 04:23:00 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNrJz-0002Ub-MM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Oct 2004 04:23:00 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 69C8E952897
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Oct 2004 11:22:44 +0000 (UTC)
In-Reply-To: <1099124920.2822.3.camel@laptop.fenrus.org>
Content-Disposition: inline
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
To: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Saturday 30 October 2004 16:28, Arjan van de Ven wrote:
> > The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with
> > code adding usage of them in Linus' tree:
>
> that makes me really really curious why the fb driver calls into the
> backend and not just the agp frontend layer like the rest of the world
> does...
>

Because all functions in the frontend are marked static and are accessible
only via ioctl.

Anyway, I think the drivers can make do without the
agp_backend_acquire/release() functions, since all they do is
increment/decrement  a use count field.  I don't know about agp_copy_info()
but it might be possible to get the agp information from pci_dev structure.
This part I'm not sure.

What's wrong with exporting the symbols back again?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
