From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Kernel warning from Matrox Framebuffer in
	2.6.20.1
Date: Sat, 24 Feb 2007 16:31:51 -0800
Message-ID: <45E0D8F7.9050803@vc.cvut.cz>
References: <306590.53720.qm@web52912.mail.yahoo.com>
	<200702241818.24675.linux@rainbow-software.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HL7JM-0001IF-J1 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 16:32:20 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HL7JL-0001iE-2u
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 16:32:20 -0800
In-Reply-To: <200702241818.24675.linux@rainbow-software.org>
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
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chris Rankin <rankincj@yahoo.com>

Ondrej Zary wrote:
> On Saturday 24 February 2007 14:08, Chris Rankin wrote:
>> Hi,
>>
>> I have just booted 2.6.20.1 on my Pentium 3 machine, which has a G400 MAX
>> graphics card. This machine uses the Matrox framebuffer and TV-OUT modules,
>> and I have found these warnings in the kernel log:
>>
>> **WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical
>> device; fix it! **WARNING** I2C adapter driver [DDC:fb0 #1] forgot to
>> specify physical device; fix it! **WARNING** I2C adapter driver [MAVEN:fb0]
>> forgot to specify physical device; fix it!
> 
> I'm seeing something like that since installing 2.6.20.1 yesterday:
> 
> matroxfb: Matrox Mystique (PCI) detected
> PInS memtype = 0
> matroxfb: MTRR's turned on
> matroxfb: 1024x768x8bpp (virtual: 1024x4096)
> matroxfb: framebuffer at 0xE1000000, mapped to 0xcc880000, size 4194304
> Console: switching to colour frame buffer device 128x48
> fb0: MATROX frame buffer device
> **WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical device; 
> fix it!

Can you try current git tree?  I believe that it is already fixed by 
Jean Delvare checkin from Feb 13th (thanks Jean!)
							Petr



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
