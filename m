From: Steve Longerbeam <stevel@mvista.com>
Subject: Re: Compiling Rage xlinit.c
Date: Fri, 14 May 2004 17:22:53 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A562DD.6000608@mvista.com>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org> <40A14FFC.102@bitworks.com> <40A520E8.20702@bitworks.com> <40A539EE.5050008@mvista.com> <40A54546.7080400@bitworks.com> <40A54CBC.8020603@mvista.com> <40A55CFB.60803@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOmx6-0004Cx-2L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 17:22:56 -0700
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=av.mvista.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOmx5-0001tt-Mh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 17:22:55 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: rsmith@bitworks.com
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com



Richard Smith wrote:

> Steve Longerbeam wrote:
>
>> Is the M1 Rage XL? If not, I'm not sure xlinit.c will be of much use
>> to you. Keep in mind that xlinit.c was a serious reverse engineering
>> hack job. I used a PCI bus analyzer to capture the bus I/O activity
>
>
> Its not a XL directly but the programming manual is the same for all 
> the Rage based chips.  I haven't done a register to register compare 
> but most every thing seems to jive with the docs I have.
>
> > created by the Xpert98's BIOS. Then converted the capture output
> > to C, and tried to make it look half sensible without breaking the
> > card init. Most of the delays in xlinit.c are the actual time deltas
>
> This explains/answers some of the next questions I was going to ask 
> about the whys of what that code does.  Some of the settings are 
> confusing.
>
>> very little confidence that it will successfully init any other
>> type of mach64 card.
>
>
> That may be true...  But from what I've gone through so far the bit 
> values that are in the registers are really close to what I think they 
> should be from looking at the docs.  However, if the inter-register 
> timing is crucial then that changes things. 


well, maybe you can get it running with a little work then. One thing
I forgot to mention: xlinit.c is reading the PCI_SUBSYSTEM_ID and
looking for the xpert98/Victoria subid's - you should add a case for the M1
and a new xl_card_cfg_t table entry if you know those values for the M1.

>
>
>> This reverse engineering job was necessary because ATI does not
>> publish documentation on how to initialize their chips, atleast not
>> for the mach64 family. Maybe that's changed now, but not when
>> I was doing the work.
>
>
> I think this has changed.  I've received code from ATI that can do a 
> biosless init of a RAGE III and a RAGE Pro.  Both mach64 based.  I've 
> also got permission from them to release whatever I end up with GPL.
>
> That code however doesn't understand the M1 and its really, messy.  
> I've managed to port it over as well but I get the same damn black 
> screen. Clocks are ok but no actual video output.
>
> I've also got the VBIOS source kit.  But going through that code is 
> very painful.  I'm good with assembly but it just sucks trying to 
> figure out what they are doing register by freaking register.
>
> I guess that's all I have left though, the VBIOS source and perhaps 
> using a bus analyzer like you did.  The analyzer may be faster 
> considering the level I'm already at where I think I just have a few 
> bits messed up in a memory config register.
>
> Ok well thanks for all your info.  Oh BTW what PCI analyzer did you 
> use?  We don't have one.  Are there some simple ones that I can get 
> for a few hundred dollars? 


I don't remember the name of the analyzer I used, I will find out and 
let you know.

Steve




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
