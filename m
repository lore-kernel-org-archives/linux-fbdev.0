From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Compiling Rage xlinit.c
Date: Fri, 14 May 2004 17:16:38 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A54546.7080400@bitworks.com>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org> <40A14FFC.102@bitworks.com> <40A520E8.20702@bitworks.com> <40A539EE.5050008@mvista.com>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOkz9-000673-Jf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 15:16:55 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BOkz9-0003hN-6O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 15:16:55 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 17:16:40 -0500
In-Reply-To: <40A539EE.5050008@mvista.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: stevel@mvista.com
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com

Steve Longerbeam wrote:

> What kernel source tree and rev is this? Xlinit.c only supports the
> Xpert98 card, nothing else, although it might be a simple matter
> to get it working with other RageXL based cards. It has never been
> ported to 2.6 either.
> 

Someone chopped on it then because the only place I've ever seen it was 
in the 2.6 tree.  In the 2.6 tree there is an xlinit.c file and a config 
option to compile it but it never shows up in the makefile and never 
gets compiled.  And if it did it would break anyway.

These patches do not appear to be in the 2.4.25 tree.

So I just assumed it was something added for 2.6.  That explains why it 
dosen't compile.  Also the 2.6 tree xlinit.c mentions the Victoria card 
as well as the Xpert98. Did someone add that?

I'm trying to adapt it to a Mobility M1 which is mach64 based.  I've 
ported it to a userspace app, fixed up the compile problems and tried to 
get all the register settings relevant to an M1.  In most cases they are 
identical.   The pll registers seem to be correct because my hsync and 
vsync are good and the right frequency but something still isn't right 
because I only get a blank screen.

If I then load the 2.4.25 atyfb and try to write an image I get a brief 
flash of some scrambled data and then back to a black screen.

Loading X appears to work fine and I have a big white square for a mouse 
cursor which moves around as it should  but still black screen.

I suspect that I have something messed up with my memory settings.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
