From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Framebuffer drivers maintainers
Date: Sat, 28 Aug 2004 17:22:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4130A349.17DDE7D2@orpatec.ch>
References: <41270AD0.FE6C7970@orpatec.ch> <20040828043938.GA1150@havoc.gtf.org> <41308D44.8A57100B@orpatec.ch> <20040828150510.GA20778@havoc.gtf.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C152m-00024X-Rx
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 08:23:04 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C152h-0004et-7e
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 08:23:04 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Aug 2004 17:27:52 +0200
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

David Eger wrote:
> 
> I'm in the middle of moving to Pittsburgh and starting graduate school;
> I saw some posts on lkml where BenH found that the Radeon 7500 worked OK
> if you told it to use noaccel, so that does sound like a problem in my code.

If you could say me where I can specify the noaccel, I'll try it. I can
live for a few weeks if it just works, I can always boot back into
2.4.27. Unfortunatly my driver is automatically loaded somewhen during
hardware detection. I tried to unload/reload it with modconf but since
it's in use it isn't possible.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
