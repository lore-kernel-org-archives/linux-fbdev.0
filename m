From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Framebuffer drivers maintainers
Date: Sat, 28 Aug 2004 15:48:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41308D44.8A57100B@orpatec.ch>
References: <41270AD0.FE6C7970@orpatec.ch> <20040828043938.GA1150@havoc.gtf.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C13Zq-0008AV-4D
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 06:49:06 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C13Zo-0007Xo-CO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 06:49:06 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Aug 2004 15:53:56 +0200
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
> radeonfb:
>    Ben Herrenschmidt took over from Ani Joshi for 2.6, though he's pretty busy,
>    so radeonfb maintainership tends to be a group effort.  I ported copyarea()
>    and fillrect() from the X radeon driver, so that accel code is my fault ;-)
> 
I can easily list several persons, but prefer just one. Of course anyone
can develop. Anytime in the future all the lastest driver sources should
be available via the driver list, so anybody can build a driver with
kbuild and test it on his station. IMO it makes much more sense to use
kbuild instead of patching and building the full source.

> cirrusfb:
>    I ported this to 2.6 after several years of bit rot, so I guess that makes me
>    the de facto maintainer ;-)
> 
Corrected.

BTW have you seen my thread in the users lists
"http://sourceforge.net/mailarchive/forum.php?thread_id=5425101&forum_id=2358"
? Do you have a solution or a workaround?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
