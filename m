From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: framebuffer ioctl (fwd)
Date: Sat, 04 Sep 2004 23:44:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413A3735.9E7D2F11@orpatec.ch>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3iKq-0006zi-IU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 14:44:36 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C3iKn-0003bB-87
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 14:44:36 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 4 Sep 2004 23:49:32 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> 
> Would there be any major opposition to my adding
> some additional functions to the framebuffer ioctl
> interface? I want to add basic drawing functions,
> nothing too fancy, but enough to do away with things
> like SVGAlib.
> Zack
> 
IMO it should only be done if all of the graphic libs like SVGAlib, GGI,
DirectFB can profit from it. IMO it's very important that the future API
of the framebuffer in kernel 2.7.x is discussed before such changes are
done. Maybe a wish list should be started.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
