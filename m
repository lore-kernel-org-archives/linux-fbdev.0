From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch] intelfb: add (partial) support for 915G
Date: Wed, 2 Feb 2005 20:30:45 +0800
Message-ID: <200502022019.21453.adaplas@hotpop.com>
References: <41FB1AEB.4090206@XLsigned.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwJg8-0000Z2-IV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 04:32:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CwJg7-0006hy-UG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 04:32:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E0C1F137E12A
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  2 Feb 2005 12:32:09 +0000 (UTC)
In-Reply-To: <41FB1AEB.4090206@XLsigned.net>
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
To: "Buttchereit, Axel (XL)" <XL@XLsigned.net>, sylvain.meyer@worldonline.fr
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Saturday 29 January 2005 13:11, Buttchereit, Axel (XL) wrote:
> Add (partial) support for 915G
>   No HW cursor at the moment
>   Screen is blanked but signal/sync is not switched off
> Mostly derived from XFree86/Xorg driver
> Pass "vesa_modes" and VESA_MODEDB_SIZE in call to "fb_find_mode()"
>   to allow loading as module. Makes "vesa_modes" also the default
>   "modedb" when linking statically into the kernel.
> Change PREFERRED_MODE to more reasonable value "1024x768-32@70"
>

Can you resend?  Patch is malformed.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
