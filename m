From: Lobiuc Andrei <alobiuc@yahoo.com>
Subject: Re: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support
Date: Tue, 22 Mar 2005 04:32:36 -0800 (PST)
Message-ID: <20050322123236.2079.qmail@web30905.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDiZF-0005CG-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 04:33:05 -0800
Received: from web30905.mail.mud.yahoo.com ([68.142.200.158])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DDiYv-0005EH-Ap
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 04:33:05 -0800
In-Reply-To: 6667
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--- Andrew Morton <akpm@osdl.org> wrote:
> Lobiuc Andrei <alobiuc@yahoo.com> wrote:
> >
> > 
> > --- Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > 
> > > Lobiuc, are you able to test 2.6.12-rc1 and/or
> > > 2.6.12-rc1-mm1, see if we've
> > > made any progress on this?
> > > 
> > > Thanks.
> > > 
> > Ok, I'll give it a try and I'll let you know as
> soon
> > as possible. Thanks for the reply, I thought my
> > problem was totally forgotten.
> > I can only hope that 2.6.12-rc1 will bring some
> > improvements as I tested 2.6.11.5 but it made no
> > difference from 2.6.11.
> 
> OK.  Please be sure to do reply-to-all when you have
> a result.
> 
> Thanks.
> 
Dear Mr. Morton, I'm sorry to inform you that the
2.6.12-rc1 kernel version did not bring any
improvements regarding my problem.
I compiled it several times, using different options
settings but with no luck.
I'll sumarize once again the problem to avoid any
confusions: I'm running Debian GNU/Linux on a AthlonXP
2800+/512Mb RAM/130Gb 2xHD/ASUS Radeon 9200SE
computer.
Since the 2.6.11 kernel, the graphic card would not
work properly as in the bootup process resulting in
some drm errors. Still, the 2.6.11, 2.6.11.2 and the
2.6.11.5 versions allowed the card to function
properly if I'd compile the kernel with SMP support
enabled.
The 2.6.12-rc1 kernel, even with SMP enabled, results
in the same errors, the card being unusable by the
DRM.

I compiled 2.6.12-rc1 in 3 (three) different ways:
1. -AGP and AGP_ATI as built-in
   -DRM and DRM_RADEON as built-in
   -FB AND FB_RADEON as built-in; FB_RADEON_OLD as
module
2. -AGP and AGP_ATI modules
-DRM and DRM_RADEON modules
	-FB and FB_RADEON built-in; no FB_RADEON_OLD


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
