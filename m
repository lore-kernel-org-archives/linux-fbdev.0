From: Jak <rfjak@eircom.net>
Subject: Re: Extending vesafb for modes switching ?
Date: Tue, 3 Feb 2004 18:27:58 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402031827.58226.rfjak@eircom.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ao8HC-0000y8-LL
	for Linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 13:40:10 -0800
Received: from mail03.svc.cra.dublin.eircom.net ([159.134.118.19])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ao8HC-0006ao-63
	for Linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 13:40:10 -0800
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
To: Linux-fbdev-devel@lists.sourceforge.net
Cc: GUtopiste@free.fr

There already seems to be such a patch : I have not tried it, but have come 
across it. The following is extracted from the README

 DRIVER FRAMEBUFFER FOR VESA GRAPHIC CARDS
                                Version 1.0
                       (C) 2003 Raster Software Vigo


This piece of code wants to be a Framebuffer driver for Linux boxes, able to
work with all VESA 2.0-compliant graphic card. The difference between this
driver and the one supplied with the kernel is that this driver allows to
change in-the-fly the resolution and color depth, and even to have each
console in a different graphic mode.

This driver is for the 2.4.x kernel series.


DISCLAIMER

This driver is distributed "as is", without warranty of any kind, under the
terms of the GPL license, version 2 or later. You can find it in the file
COPYING.
CONTACTING WITH THE AUTHOR

Sergio Costas Rodriguez
mailto:raster@rastersoft.com
http://www.rastersoft.com


OTHER SOFTWARE PACKAGES USED IN THIS PROJECT:

LRMI library
http://sourceforge.net/projects/lrmi




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
