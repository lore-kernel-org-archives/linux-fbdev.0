From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 7/7] fbcon: Fix big-endian bogosity in slow_imageblit()
Date: Tue, 4 Apr 2006 15:13:51 -0700
Message-ID: <20060404221351.GK6150@kroah.com>
References: <4427E490.9010002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQtnN-0004mF-S3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 15:14:41 -0700
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=aria.kroah.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FQtnN-0003R3-Hr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 15:14:41 -0700
Content-Disposition: inline
In-Reply-To: <4427E490.9010002@gmail.com>
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, stable@kernel.org, Herbert Poetzl <herbert@13thfloor.at>

On Mon, Mar 27, 2006 at 09:11:44PM +0800, Antonino A. Daplas wrote:
> The monochrome->color expansion routine that handles bitmaps which have
> (widths % 8) != 0 (slow_imageblit) produces corrupt characters in big-endian.
> This is caused by a bogus bit test in slow_imageblit().

queued to -stable, thanks.

greg k-h



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
