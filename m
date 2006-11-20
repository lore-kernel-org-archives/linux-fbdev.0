From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 20 Nov 2006 16:34:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmC6s-0001pE-7i for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 08:35:06 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmC6p-0007KQ-Fb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 08:35:06 -0800
In-Reply-To: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-fbdev-devel@lists.sourceforge.net


> Hi all,
> 
> I'm using the Geode GX processor and the associated frame buffer
> driver in 2.6.19-rc5.
> I have a 640x480 LCD attached, without DDC support (not sure if that matters).
> 
> The frame buffer driver takes 12.5 seconds to initialize.
> 
> Is this normal?
> 
> Relevant kernel log:
> [   18.516093] io scheduler deadline registered (default)
> [   18.539818] gxfb 0000:00:01.1: 16384 Kibyte of video memory at 0x41000000
> [   31.052135] Console: switching to colour frame buffer device 80x30
> [   31.070906] fb0: Geode GX frame buffer device
> [   31.094200] Real Time Clock Driver v1.12ac
> 
> I tried building the driver as a module, but that makes no difference
> -- modprobe 'hangs' for 13 seconds.
> 
> I looked through the Geode driver code and didn't see anything obvious
> that would eat up 13 seconds.
> 
> Any idea as to what is going on?

No idea. I do have hardware with this chipset altho I don't have a 2.6.X 
kernel running on it. So I will see what the problem is in the next few 
weeks.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
