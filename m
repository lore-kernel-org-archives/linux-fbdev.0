From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Fri, 17 Sep 2004 13:32:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D0DC5E58F9@vcnet.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8Gyk-0005X8-9R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 04:32:38 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C8Gyj-0002fc-MQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 04:32:38 -0700
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
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 17 Sep 04 at 10:51, Michal 'hramrach' Suchanek wrote:
> > It is not matroxfb's bug, it is how fbcon works in 2.6.x, it uses
> > only drivers which existed at a time fbcon was loaded...  Usually
> > people find it by trial & error, or they ask...
> > 
> > You can also grab 
> > http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matroxfb-2.6.9-rc2.gz,
> > with it you should be able to use modular matroxfb.
> 
> It does not apply to my (2.6.8.1) kernel. But since it works when

No big surprise as it is for 2.6.9-rc2, as name says...  You can pick up
older versions if you want...

> However, I still get a minor problem with the driver.
> When I switch between the default 640x480-60 mode and 1024x768-85 mode
> the 1024x768 gets interlaced, with completely different timings. I have
> to use fbset to restore it to 1024x768-85.

It will work with patch above.
                                                            Petr
                                                            



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
