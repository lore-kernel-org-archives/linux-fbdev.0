From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: framebuffer ioctl
Date: Mon, 06 Sep 2004 17:36:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413C83F7.D4CB1EAD@orpatec.ch>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net> <200409060926.07163.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4LZf-0006pW-Ie
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 08:38:31 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C4LZc-0008Bo-U2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 08:38:30 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 6 Sep 2004 17:41:35 +0200
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

"Antonino A. Daplas" wrote:
> 
> On Monday 06 September 2004 01:13, Zack wrote:
> > 4. new features would be optional anyway: fullscreen-guis need not
> > recognize their existence, but would benefit from doing so
> > since some fb drivers would override the generic routines
> > to implement accelerated routines.
> >
> 
> One of the limitations of the in-kernel drawing routines is that they were
> never designed to be used in user space.  This has been discussed a long time
> ago so that the upper layer need not know the characteristics of the
> low-level driver.
> 
I'm neither pro nor contra moving drawing routines into the kernel but
this has to be discussed and written down.

The question is not if its kernel or user space but what functionality
has to be provided by a graphic driver. I don't care if it's a
monolithic solution or if it's divided into user and kernel part but
it's necessary that this is now nailed down so anyone can use this API
and work on a common goal. Also it makes it easier to code drivers when
everything is collected into on place.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
