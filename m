From: Otto Wyss <otto.wyss@bluewin.ch>
Subject: Linux GUI considerations
Date: Tue, 04 Feb 2003 23:19:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E403C75.2DBCC9F8@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from isp247n.hispeed.ch ([62.2.95.247] helo=smtp.hispeed.ch)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gBPo-0004Bi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Feb 2003 14:19:40 -0800
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
To: "'wx-dev@lists.wxwindows.org'" <wx-dev@lists.wxwindows.org>, linux-fbdev-devel@lists.sourceforge.net

Sorry for bringing this subject up here but IMO it's very important for
a better success of Linux (specifically for Linux on the desktop). And
IMO wxWindows is (or could be) one important component in helping
bringing more acceptance to Linux. Besides also wxWindows would profit
from a widespread Linux.

I fully agree with James Simmons when he complains about "Linux will
NEVER move into the desktop market!" (See
"http://www.kerneltraffic.org/kernel-traffic/kt20030131_203.html"). But
it's not only the free beer mentality or the missing jobs. It's also
because there is no pressure for any manufacture to invest at least a
minimum amount in Linux because not even home users are attracted by
Linux not to speak of business users.

Now why don't use everybody Linux if it's free? IMO one of the main
reason is there isn't a nice looking GUI and what's there is much too
complicate to set up. No end user (except "fanatics" like we) will ever
go through fixing an X configuration if it doesn't work right out of the
box which is much too much the case. And no end user will ever even look
at the console. No reseller will ever sell a machine with Linux to an
end user just because of these facts. Almost none of the PDA manufatures
considers Linux since it's almost impossible to bring anything nice on
the screen.

And what about the framebuffer alternative? While it might have the
potential to overcome the above obstacles, it's not even considered by
the vast majority of the current Linux user base itself. It's obvious to
anybody that the current framebuffer API isn't well suited as a base GUI
interface. Otherwise everybody would start using it, porting their
software to it. Even if it's done (like GTK 2.0) there is no use of the
framebuffer except as a base for an X server or a bigger console. Just
ask yourself, why isn't there already a framebuffer port in wxWindows?

What could be done to change this situation, especially what can the
wxWindows and the framebuffer people do? Since wxWindows has to draw its
controls on many different machines it's probably well known how an easy
to use interface of the underlying system should look like. And the
framebuffer people certainly know well how such an interface could be
implemented. So why don't sit some wxWindows guys together with some
framebuffer guys and try to work out a solution which suits both sides? 

Of course anybody of us has more than enough of his own tasks but it's
probably not asked too much about sharing its knowledge at least in
giving ideas or hints in which direction such a task should head. Also
to hear if this is altogether useless or if a successful solution could
be reached is welcomed. I'd be very pleased if some could be persuaded
into actually contributing anything, is it advice, knowledge or code.
IMO it's time that this task gets started.

What I'd like to know is what kind of API or functionality is necessary
for using it directly from wxWindows so a useful port could be
considered. Best would be if a specification or wish list could be
worked out which could be given to the framebuffer people for
consideration. They then might give feedback what can be done and how
much effort it'd need to implement. Or if there are other alternatives?

I'd like to keep this discussion here in the wx-dev mailing list (at
least for the start) but welcome any suggestions for a better place.

O. Wyss


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
