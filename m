From: Fredrik Noring <noring@nocrew.org>
Subject: Re: Vertical retrace interrupts?
Date: 31 Jan 2003 01:16:50 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043972211.17160.35.camel@h9n1fls20o980.telia.com>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	<1043893384.1052.127.camel@localhost.localdomain> 
	<1043927116.7576.40.camel@thor> 
	<1043968889.1002.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailg.telia.com ([194.22.194.26])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eOqz-0007wn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 16:16:21 -0800
In-Reply-To: <1043968889.1002.40.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Antonino,

fre 2003-01-31 klockan 00.22 skrev Antonino Daplas:
> However, at least 3 people have mailed me that they are using their
> somewhat old pc as a set top box with mplayer, DirectFB and i810fb. No
> X.  The image instability is noticeable because they are driving
> big-screen TV's, especially because DirecFB is double-buffered, with
> triple-buffering in the TODO list.

I don't think vertical retrace synchronisation is strictly necessary 
for excellent video playback on low-grade systems. Reason is that I
believe most graphics cards delay the flip automatically in hardware
using shadow registers which load the real registers during retrace.

The software only needs to flip the buffers with approximately the same
frequency, and it'll work fine.

I've sent a few patches to the Xine (video player) developers to improve
the frame buffer driver and player. The new driver allocates as many
buffers as possible natively in video RAM. Thus, with a 16 MB TNT card
you'll get about 9 buffers at 768x576x32 (PAL DVD) resolution. That
should give the driver plenty of margins to deal with occasional
scheduling problems etc. because the only essential thing it needs to
do meanwhile is flipping buffers using the FBIOPAN_DISPLAY ioctl. This
can be done with the regular Linux kernel frame buffer drivers.

I think Xine being threaded (as compared with mplayer which is not) is
an advantage when implementing this. It's still work-in-progress but I
hope the theory will work out when I have the ability to do more
advanced tests than I've done so far. :)

	Fredrik




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
