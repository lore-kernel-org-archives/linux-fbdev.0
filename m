From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
Date: Sat, 4 Sep 2004 14:53:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409041453.01644.adaplas@hotpop.com>
References: <200409041108.40276.adaplas@hotpop.com> <41393829.6020302@winischhofer.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3UQB-0002HU-8j
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Sep 2004 23:53:11 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3UQA-0005Yz-Q1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Sep 2004 23:53:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2D49D71044
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Sep 2004 06:53:00 +0000 (UTC)
In-Reply-To: <41393829.6020302@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>, adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Saturday 04 September 2004 11:36, Thomas Winischhofer wrote:
> > 5. Because driver initialization will be dependent on the link order,
> > hardware that depends on other subsystems (agpgart, usb, serial, etc) may
> > choose to initialize after the subsystems they depend on.
> >
> > Signed-off-by: Antonino Daplas <adaplas@pol.net>
>
> I don't really see a benefit but it's ok with me.
>

Mainly cleanup, but also point #5.  The i810fb, for instance, depends on agpgart, but
agpgart gets initialized way after fbdev.  The workaround is for i810fb to explicitly
call intel_agp_init().  Besides the ugliness, forcibly initializing the agpgart subsystem
out of sequence may cause problems.

With this change, in theory, I can move i810fb's link order so it gets initialized after
agpgart.

> (Thanks for considering the "unified" nature of sisfb, by the way. Very
> considarate. Very much appreciated.)
>
> I assume that you tested this stuff before posting it here.

Yes, with hardware that I have.  I did try to at least compile test what I can.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
