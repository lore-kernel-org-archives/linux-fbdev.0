From: "Antonino A. Daplas" <adaplas@swissinfo.org>
Subject: Re: [patch] intelfb: add (partial) support for 915G
Date: Thu, 3 Feb 2005 12:42:22 +0800
Message-ID: <200502031242.24560.adaplas@swissinfo.org>
References: <41FB1AEB.4090206@XLsigned.net> <200502022019.21453.adaplas@hotpop.com> <4201026F.1080309@XLsigned.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwZT5-0001Xx-Q3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 21:23:51 -0800
Received: from md1.swissinfo.org ([146.159.4.92])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CwZT4-0007hl-9q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 21:23:51 -0800
Received: from mail.swissinfo.org ([194.6.181.33])
	by md1.swissinfo.org (phad1.swissinfo.org [146.159.6.9])
	(MDaemon.PRO.v7.2.1.R)
	with ESMTP id 23-md50000275925.msg
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Feb 2005 05:39:32 +0100
In-Reply-To: <4201026F.1080309@XLsigned.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Cc: sylvain.meyer@worldonline.fr, adaplas@pol.net

On Thursday 03 February 2005 00:40, Buttchereit, Axel (XL) wrote:
> Antonino A. Daplas wrote:
> > On Saturday 29 January 2005 13:11, Buttchereit, Axel (XL) wrote:
> >>Add (partial) support for 915G
> >>  No HW cursor at the moment
> >>  Screen is blanked but signal/sync is not switched off
> >>Mostly derived from XFree86/Xorg driver
> >>Pass "vesa_modes" and VESA_MODEDB_SIZE in call to "fb_find_mode()"
> >>  to allow loading as module. Makes "vesa_modes" also the default
> >>  "modedb" when linking statically into the kernel.
> >>Change PREFERRED_MODE to more reasonable value "1024x768-32@70"
> >
> > Can you resend?  Patch is malformed.
>
> Sure!
> But it would be much easier for me, if I know what's wrong with my patch.

It's line-wrapped, I think, your mailer probably mangled it.  You can resend
the patch as a text attachment.

>
> I assume that the kernel source version I was using is wrong (outdated),
> i. e. I have to make my patch base on (at least) version 2.6.11-rc2.

The source tree is not a problem, you can use any kernel >= 2.6.10.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
