From: Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: Q40 fbdev updates.
Date: Wed, 5 May 2004 22:51:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040505205133.GA23557@linux-m68k.org>
References: <Pine.GSO.4.58.0404251320190.11039@waterleaf.sonytel.be> <Pine.LNX.4.44.0404270115470.9732-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLjDJ-0002fb-Je
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 06:47:01 -0700
Received: from mail-in-04.arcor-online.net ([151.189.21.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BLjDJ-0003xL-Du
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 06:47:01 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404270115470.9732-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard.Zidlicky@stud.informatik.uni-erlangen.de

On Tue, Apr 27, 2004 at 01:15:53AM +0100, James Simmons wrote:
> 
> Applied your changes.
> 

Thanks guys, works perfectly, especially the odd colormap
problem is now gone :)

- fix email addr

--- q40fb.c.orig        2004-05-05 22:01:08.000000000 +0200
+++ q40fb.c     2004-05-05 22:25:02.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2001 
  *
- *      Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
+ *      Richard Zidlicky <rz@linux-m68k.org>
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for


Richard



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
