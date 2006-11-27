From: "Ben Gardner" <gardner.ben@gmail.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
	seconds to initialize
Date: Mon, 27 Nov 2006 10:28:04 -0600
Message-ID: <808c8e9d0611270828m4ff91349mdc7bf03fd6875e91@mail.gmail.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
	<20061121003447.GD5160@cosmic.amd.com>
	<808c8e9d0611210618n2d54aaft1e2afb1c73dcf74a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GojKz-0006l8-Dk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 08:28:09 -0800
Received: from wx-out-0506.google.com ([66.249.82.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GojKx-00012j-3I
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 08:28:09 -0800
Received: by wx-out-0506.google.com with SMTP id i30so2322265wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 27 Nov 2006 08:28:04 -0800 (PST)
In-Reply-To: <808c8e9d0611210618n2d54aaft1e2afb1c73dcf74a@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi Jordan,

> > Author: Jordan Crouse <jordan.crouse@amd.com>
> > Date:   Mon May 15 20:54:51 2006 -0600
> >
> >     FB: Get the Geode GX frambuffer size from the BIOS
> >
> >     Use the Geode GX BIOS virtual registers to get the actual size of the
> >     framebuffer.
> >
> >     Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>

The patch works. The frame buffer size now matches what is really there (4 MB).

Out of curiosity, where are the magic registers (0xAC1C, 0xAC1E) documented?
I searched "AMD Geode GX Processors Data Book", but had no luck...

Also, I notice that the pci_resource_len() shows 16 MB, even though
the resource should only cover 4 MB.  I assume this is a BIOS bug...
=)

Is there anything I can do to help get this pushed into the 2.6.19 kernel?

Thanks,
Ben

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
