From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Tue, 03 Feb 2004 16:18:10 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40201E22.6000708@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ao8su-0008Mu-HD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 14:19:08 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ao8st-0006aW-U0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Feb 2004 14:19:08 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Feb 2004 16:17:38 -0600
In-Reply-To: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Somehow this didn't make it to the list the first time... so I'm 
resending it.

James Simmons wrote:

 > Can you submit a patch.
 >

Sure but the problem is that it dosen't work.  All I did was duplicate 
the 0x4c4d device (m64n_mob_p) and change the device Id to 0x4c52. It 
detects my devices but the type and  ammount of ram it finds and various 
other things are incorrect. The 0x4c4d matches the M1s clock speeds but 
I don't know what all those other flags specified mean and the text 
description for the m64_mob_p says "3D Rage Mobility.... P/M AGP 2x" and 
my device is on the PCI bus.  The Marketing descriptions describe the M1 
as a "Rage Mobility" not a "3D Rage Mobility"

I suppose now would be the time to own up and mention that the above 
incorrect dection problems may not be the drivers fault at all.  I have 
a really special setup. (explained below) Howerver, since my device ID 
wasn't in the device table I don't know if the driver is _supposed_ to 
be able to get the right info.

Ok. Here's my crazy setup.  I have custom SBC that we re-designed with 2 
ATI M1's on it to replace 2 Assilliant 69030s which went end of life 
last year.  Both chips are on the PCI bus.

This board boots linuxBIOS rather than a normal BIOS.  LinuxBIOS has the 
ability to run videobios provided by the mfg but it only has limited 
bios int support.  The assilliant videobios must have had much fewer 
requirements than ATI's bios because it all worked fine and dandy.

The ATI videobios runs and will enable VSYNC but I don't ever get any 
video output.  So I suspect that there are a few int calls that it needs 
that LinuxBIOS dosen't have support for and its not setting some 
registers correctly or perhaps not at all.

lspci can read the pci config space and all the info looks good so right 
now I don't have any reason to believe that the hardware isn't hooked up 
to the pci bus right.

My hope was that the chip was up far enough that the framebuffer driver 
code would bring it to life.  But that didn't happen so thats why I 
wan't to know what the driver is supposed to be able to do.  So I have 
new untested hardware booting a half-ass videobios running an unknown 
driver.  Gee... wonder why it dosen't work? *grin*

And no.  I don't have a known good system as you can't buy video cards 
with an M1 on them. (At least I haven't found one yet)  Anybody know 
what laptop brands/models have an M1 in them?  That would be handy.

If someone can tell me what's supposed to work on a sane setup then I 
can begin to figure out why that dosen't happen on my setup.

I should also mention that in order to use these chips Bitworks had to 
enter into a NDA with ATI.  I have access to all the propritary info on 
the registers and so forth.

So I have to be careful with any patches I submit as ATI hasn't been 
very helpfull to me with what info I can and can't release.  I don't 
want to inadvertently release any NDA info and get us all into trouble. 
  (Anyone with experience in this area please feel free to contact me)

Obviously if the M1 is already supported by atyfb then ATI authorized 
that info to be released already and I don't have to worry quite so much 
about submitting patches to that code.


-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
