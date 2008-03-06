From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb: Please enable support for X850XT
Date: Thu, 06 Mar 2008 21:56:26 +1100
Message-ID: <1204800986.21545.255.camel@pasglop>
References: <20071206212809.GA8249@aragorn.home.lxtec.de>
	<68676e00712080518g6185e5d8oe74cca828d5f559d@mail.gmail.com>
	<20071209174346.GA18769@gandalf.home.lxtec.de>
	<20080305224208.81063f96.akpm@linux-foundation.org>
	<68676e00803060207x60c916e9s2adff45049715551@mail.gmail.com>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXDmY-0007Ep-Ms for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 02:57:02 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX198SjNejmdiNVDI8sKZAsRE+bA+JwhsPIc=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JXDmW-0001xM-SX
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 02:57:02 -0800
In-Reply-To: <68676e00803060207x60c916e9s2adff45049715551@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Jerome Glisse <glisse@freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net


On Thu, 2008-03-06 at 11:07 +0100, Luca Tettamanti wrote:
> >  It no longer applies.  Could you please redo it against current
> Linux
> >  mainline and resend, with a full changelog and signed-off-by:?
> Thanks.
> 
> I can send you what I'm using here, but I really don't think that it's
> suitable for mainline.
> With the recent progress with the in-kernel modesetting (hi Jerome :D)
>  radeonfb is going away soon, replaced with a generic "drmfb".

I agree. There is little point in adding more support to radeonfb at
this stage. It's on life support, in order to provide the basic console
for machines without VGA text mode such as powermacs, but it will be
replaced by the new stuff from Jerome soon enough.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
