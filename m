From: David Eger <eger@havoc.gtf.org>
Subject: Re: Framebuffer drivers maintainers
Date: Sat, 28 Aug 2004 00:39:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040828043938.GA1150@havoc.gtf.org>
References: <41270AD0.FE6C7970@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C0v0J-00077e-19
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 Aug 2004 21:39:51 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C0v0H-00048q-EE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 Aug 2004 21:39:50 -0700
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	by havoc.gtf.org (Postfix) with ESMTP id 3FB2B76AE
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Aug 2004 00:39:39 -0400 (EDT)
Received: (from eger@localhost)
	by havoc.gtf.org (8.12.10/8.12.10/Submit) id i7S4dcoB001390
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 00:39:38 -0400
Content-Disposition: inline
In-Reply-To: <41270AD0.FE6C7970@orpatec.ch>
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
To: linux-fbdev-devel@lists.sourceforge.net

radeonfb:
   Ben Herrenschmidt took over from Ani Joshi for 2.6, though he's pretty busy,
   so radeonfb maintainership tends to be a group effort.  I ported copyarea() 
   and fillrect() from the X radeon driver, so that accel code is my fault ;-)

cirrusfb:
   I ported this to 2.6 after several years of bit rot, so I guess that makes me
   the de facto maintainer ;-)

-David Eger


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
