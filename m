From: James Simmons <jsimmons@infradead.org>
Subject: Re: Compiling Rage xlinit.c
Date: Tue, 18 May 2004 23:06:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405172122310.796-100000@phoenix.infradead.org>
References: <40A55CFB.60803@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQCjA-0001QG-NS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 15:06:24 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BQCj9-00041h-SX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 15:06:24 -0700
In-Reply-To: <40A55CFB.60803@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Smith <rsmith@bitworks.com>
Cc: stevel@mvista.com, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com


Sorry about the delayed response. I recieved that patch along time ago. 
It was ported to 2.6.X and I placed it into the BK repo for fbdev.
Xui from tyan sent me a patch to get it going. Since you have the specs to 
boot from scratch I really like to work with you on this. The code for the 
mach64 is old. I have newer code in my BK repos. If you need a patch I can 
send it to you.


> > Is the M1 Rage XL? If not, I'm not sure xlinit.c will be of much use
> > to you. Keep in mind that xlinit.c was a serious reverse engineering
> > hack job. I used a PCI bus analyzer to capture the bus I/O activity
> 
> Its not a XL directly but the programming manual is the same for all the 
> Rage based chips.  I haven't done a register to register compare but 
> most every thing seems to jive with the docs I have.
> 
>  > created by the Xpert98's BIOS. Then converted the capture output
>  > to C, and tried to make it look half sensible without breaking the
>  > card init. Most of the delays in xlinit.c are the actual time deltas
> 
> This explains/answers some of the next questions I was going to ask 
> about the whys of what that code does.  Some of the settings are confusing.
> 
> > very little confidence that it will successfully init any other
> > type of mach64 card.
> 
> That may be true...  But from what I've gone through so far the bit 
> values that are in the registers are really close to what I think they 
> should be from looking at the docs.  However, if the inter-register 
> timing is crucial then that changes things.
> 
> > This reverse engineering job was necessary because ATI does not
> > publish documentation on how to initialize their chips, atleast not
> > for the mach64 family. Maybe that's changed now, but not when
> > I was doing the work.
> 
> I think this has changed.  I've received code from ATI that can do a 
> biosless init of a RAGE III and a RAGE Pro.  Both mach64 based.  I've 
> also got permission from them to release whatever I end up with GPL.
> 
> That code however doesn't understand the M1 and its really, messy.  I've 
> managed to port it over as well but I get the same damn black screen. 
> Clocks are ok but no actual video output.
> 
> I've also got the VBIOS source kit.  But going through that code is very 
> painful.  I'm good with assembly but it just sucks trying to figure out 
> what they are doing register by freaking register.
> 
> I guess that's all I have left though, the VBIOS source and perhaps 
> using a bus analyzer like you did.  The analyzer may be faster 
> considering the level I'm already at where I think I just have a few 
> bits messed up in a memory config register.
> 
> Ok well thanks for all your info.  Oh BTW what PCI analyzer did you use? 
>   We don't have one.  Are there some simple ones that I can get for a 
> few hundred dollars?
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
