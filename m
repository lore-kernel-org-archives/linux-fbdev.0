From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Optimized cfbimgblt.c
Date: Tue, 25 Jan 2005 20:58:07 +0800
Message-ID: <200501252058.13632.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtQHb-0003Gy-6J
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Jan 2005 04:58:59 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CtQHZ-0003ib-Je
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Jan 2005 04:58:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E559F1372656
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jan 2005 12:58:22 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@pentafluge.infradead.org

On Thursday 20 January 2005 04:25, jsimmons@pentafluge.infradead.org wrote:
> Here is a patch for packed pixel software imageblit. Since the code to
> draw a color image and a mono image are almost the same I merged them.
> Second I made the code generic enough to work on big endian and little
> endian code at the same time. I set my radeon card in my x86 box to big
> endian mode and tested. It worked for me but I like people on big endian
> machines to test it. The last fix was to deal with the 16 color logo. The
> fb_set_logo was unpacking the 4bpp info. Now cfb_imageblit can handle the
> logo data directly. Most hardware expects the data not to be unpacked.
> Another bug was image.depth was always set to 8 in fb_show_logo. This is
> in correct. Please test. Thank you.

Hi James,

Tested on vesafb: works
Tested on rivafb: crashes on fb_show_logo().

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
