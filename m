From: Steve Longerbeam <stevel@mvista.com>
Subject: Re: Compiling Rage xlinit.c
Date: Fri, 14 May 2004 15:48:28 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A54CBC.8020603@mvista.com>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org> <40A14FFC.102@bitworks.com> <40A520E8.20702@bitworks.com> <40A539EE.5050008@mvista.com> <40A54546.7080400@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOlTk-0008AN-9g
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 15:48:32 -0700
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=av.mvista.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOlTi-0002P8-UL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 15:48:31 -0700
In-Reply-To: <40A54546.7080400@bitworks.com>
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
To: rsmith@bitworks.com
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com



Richard Smith wrote:

> Steve Longerbeam wrote:
>
>> What kernel source tree and rev is this? Xlinit.c only supports the
>> Xpert98 card, nothing else, although it might be a simple matter
>> to get it working with other RageXL based cards. It has never been
>> ported to 2.6 either.
>>
>
> Someone chopped on it then because the only place I've ever seen it 
> was in the 2.6 tree.  In the 2.6 tree there is an xlinit.c file and a 
> config option to compile it but it never shows up in the makefile and 
> never gets compiled.  And if it did it would break anyway.
>
> These patches do not appear to be in the 2.4.25 tree.
>
> So I just assumed it was something added for 2.6.  That explains why 
> it dosen't compile.  Also the 2.6 tree xlinit.c mentions the Victoria 
> card as well as the Xpert98. Did someone add that? 


I added that originally, forgot to mention it. Yes, if you were
to by miracle get a hold of a Victoria card, you would see that
it gets initialized fine with xlinit. ATI lent me one for development.
It's very similar to the Xpert98, different video memory type and
pixel clocks though.

>
>
> I'm trying to adapt it to a Mobility M1 which is mach64 based.


Is the M1 Rage XL? If not, I'm not sure xlinit.c will be of much use
to you. Keep in mind that xlinit.c was a serious reverse engineering
hack job. I used a PCI bus analyzer to capture the bus I/O activity
created by the Xpert98's BIOS. Then converted the capture output
to C, and tried to make it look half sensible without breaking the
card init. Most of the delays in xlinit.c are the actual time deltas
reported by the bus analyzer between RageXL register accesses.
The point I'm trying to make is that xlinit.c is verbatim init
activity from specifically the Xpert98 card's BIOS. So I have
very little confidence that it will successfully init any other
type of mach64 card.

This reverse engineering job was necessary because ATI does not
publish documentation on how to initialize their chips, atleast not
for the mach64 family. Maybe that's changed now, but not when
I was doing the work.

Steve

>   I've ported it to a userspace app, fixed up the compile problems and 
> tried to get all the register settings relevant to an M1.  In most 
> cases they are identical.   The pll registers seem to be correct 
> because my hsync and vsync are good and the right frequency but 
> something still isn't right because I only get a blank screen.
>
> If I then load the 2.4.25 atyfb and try to write an image I get a 
> brief flash of some scrambled data and then back to a black screen.
>
> Loading X appears to work fine and I have a big white square for a 
> mouse cursor which moves around as it should  but still black screen.
>
> I suspect that I have something messed up with my memory settings.
>
>
>



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
