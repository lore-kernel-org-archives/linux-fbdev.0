From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Thu, 16 Sep 2004 14:04:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3B9599C3EB4@vcnet.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7uyD-0003tZ-17
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 05:02:37 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7uyB-000679-H0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 05:02:36 -0700
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

On 16 Sep 04 at 12:58, Michal 'hramrach' Suchanek wrote:
> On Wed, Sep 15, 2004 at 01:06:14PM +0200, Petr Vandrovec wrote:
> > On 15 Sep 04 at 8:09, Michal 'hramrach' Suchanek wrote:
> > > I tried using the framebuffer console with matroxfb on a 2.6 kernel and
> > > I see only reddish pattern on the screen. I do not get any letters.
> > > However, I can run X with UseFBdev option and a directfb program.
> > > I can also use the fbcons on an iMac with atifb.
> > > Tested with 2.6.7, with 2.6.8.1 I still do not get usable fbcons.
> > > THe hardware is G400 and G550.
> > 
> > Your .config ?  You either did not build fbcon to the kernel or
> > you are using modular matroxfb.  You cannot do that.
> 
> OK, compiling it into kernel works.
> 
> But I wonder how should I know. I re-read the documentation that comes
> with the kernel and I did not find any word about this.
> Also it worked with 2.4 kernels.

It is not matroxfb's bug, it is how fbcon works in 2.6.x, it uses
only drivers which existed at a time fbcon was loaded...  Usually
people find it by trial & error, or they ask...

You can also grab 
http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matroxfb-2.6.9-rc2.gz,
with it you should be able to use modular matroxfb.
                                                    Petr
                                                    



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
