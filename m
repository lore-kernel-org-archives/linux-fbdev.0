From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.21-rc8 vesafb memory remapping...
Date: 27 Jun 2003 12:54:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1056714867.4348.36.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.GSO.4.21.0306271340000.2794-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86] helo=lxorguk.ukuu.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19VrrJ-0005bZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Jun 2003 04:57:41 -0700
In-Reply-To: <Pine.GSO.4.21.0306271340000.2794-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Thomas Backlund <tmb@iki.fi>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Gwe, 2003-06-27 at 12:51, Geert Uytterhoeven wrote:
> 	Hi Marcelo,
> 
> Can we please have a fix for vesafb in the next -pre*? Currently it maps 8
> times too much memory due to a bits/bytes confusion.

You want to allocate a bit more than the minimum needed for the scroll
buffers and you also have to check for banked stuff. Thats fixed in -ac



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
