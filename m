From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: framebuffer ioctl
Date: Tue, 07 Sep 2004 17:58:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413DDA94.F9F61839@orpatec.ch>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
		 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
		 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
		 <9e4733910409061402372095b1@mail.gmail.com>
		 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
		 <9e47339104090707172cdc258d@mail.gmail.com>
		 <Pine.GSO.4.58.0409071623550.518@waterleaf.sonytel.be> <9e4733910409070738a46cafb@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4iMU-0000tB-VH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 08:58:26 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C4iMR-00040F-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 08:58:25 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 7 Sep 2004 18:03:25 +0200
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

Jon Smirl wrote:
> 
> That's what the numbers compare. I think he wants me to compare it to
> his new render implementation that uses the 3D hardware.  But that's
> what I'm against. I don't want to see even more drivers trying to take
> control of the 3D hardware and causing even more conflicts.
> Implementing X on GL completely removes the need for expanding XAA to
> include using the 3D hardware. This pratice of ten different groups
> programming the video hardware however they want has got to stop or
> Linux is never going to be competitive with Mac/Longhorn.
> 
What me concern here is there is a little too much talk about X.
Enhancing the framebuffer has nothing to do with X, it has to do with
providing a common set of functionality for _all_ the graphic libraries
however many there are and X is _just_ one of them.

Please correct me if I miss understood your intention.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
