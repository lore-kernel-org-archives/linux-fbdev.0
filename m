From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [Linux-fbdev-users] matroxfb, 2.6 and 2.4
Date: Wed, 4 Aug 2004 16:09:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E1105463BBE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsMT8-00068T-HX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 07:10:14 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BsMT8-00066l-1H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 07:10:14 -0700
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
To: Jonas Meurer <jonas@freesources.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On  4 Aug 04 at 13:51, Jonas Meurer wrote:
> 
> > > And for DRI I do not understand X code well enough to find where
> > > tests which should prevent X from hitting hardware should be added.
> 
> do you mean that usually it shouldn't change anything?

It should not change anything if X are not visible - X released video
card ownership when they switched back to text console, but they keep
banging adapter (they switch it to color depth X are using, reprogram
line length to the value they use, and foreground/background colors to
values they use) although matroxfb now has ownership.

Maybe you should try whether crash happens if you boot with 
'video=matroxfb:noaccel', but as you said that it occurs without DRI
too, it is not source of problem.
                                                    Petr
                                                    



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
