From: Roman Sergeev <sungeneral@gmail.com>
Subject: Re: [Bugme-new] [Bug 13976] New: viafb + vmalloc
Date: Fri, 14 Aug 2009 20:33:46 +0400
Message-ID: <BE54F6D1-53DA-4989-A0BB-ECE309B1D921@gmail.com>
References: <bug-13976-10286@http.bugzilla.kernel.org/>
	<20090813123622.624240c7.akpm@linux-foundation.org>
	<4A84849A.3000807@gmx.de>
	<FE2B7370-64DF-43D4-B0E3-C65EB1AD1986@gmail.com>
	<4A852527.7040705@gmx.de>
	<9B8E82A6-A4A5-4654-8555-5590A7B1D0F3@gmail.com>
	<4A855C11.2020805@gmx.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sungeneral@gmail.com>) id 1Mbzj6-0008Dl-1m
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 16:34:01 +0000
Received: from ey-out-1920.google.com ([74.125.78.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mbzj1-0001n5-VB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 16:34:00 +0000
Received: by ey-out-1920.google.com with SMTP id 5so332945eyb.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Aug 2009 09:33:50 -0700 (PDT)
In-Reply-To: <4A855C11.2020805@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi!
On 14.08.2009, at 16:44, Florian Tobias Schandinat wrote:

> Hi,
>
> thanks a lot for your testing!
>
> Roman Sergeev schrieb:
>> test # 1
>> * send to kernel "vmalloc=260M"
>> # modprobe viafb
>
> For my patch to fix this bug I would be interested in something like  
> this:
> * send to kernel "vmalloc=260M"
> # modprobe viafb viafb_accel=0
> If it is similar to the result of test #2 I could simply disable  
> hardware acceleration if the second ioremap fails which is IMHO  
> better than refusing to work as hardware acceleration is a nice to  
> have but not crucial for device operation.
>
yes, it's working
log:
Jun 22 06:15:50 mini2133 [   59.646904] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 22 06:15:50 mini2133 [   59.727808] vmap allocation for size  
16781312 failed: use vmalloc=<size> to increase size.
Jun 22 06:15:50 mini2133 [   59.732024] Console: switching to colour  
frame buffer device 80x30
# grep viafb /proc/modules
viafb 71840 1 - Live 0xef642000
i2c_algo_bit 4656 1 viafb, Live 0xef624000


>> test # 2
>> * send to kernel "vmalloc=300M"
>> * modprobe viafb
>> * loaded ok
>> status:
>> # grep viafb /proc/modules
>> viafb 71840 1 - Live 0xece42000
>> i2c_algo_bit 4656 1 viafb, Live 0xece24000
>> log:
>> Jun 21 23:52:12 mini2133 [   47.308459] VIA Graphics Intergration  
>> Chipset framebuffer 2.4 initializing
>> Jun 21 23:52:12 mini2133 [   47.393518] Console: switching to  
>> colour frame buffer device 80x30
>> but i see "test color mode"
>> ...
>> if i loading  module with parametrs "modprobe viafb  
>> viafb_mode=800x600 viafb_refresh=60"
>> they still go "test color mode"
>> log:
>> Jun 22 00:28:11 mini2133 [  142.994541] VIA Graphics Intergration  
>> Chipset framebuffer 2.4 initializing
>> Jun 22 00:28:11 mini2133 [  143.079079] Console: switching to  
>> colour frame buffer device 100x37
>
> This looks fine. I'd guess the driver itself is working.  
> Unfortunately I do not fully understand the term "test color mode".  
> Can you describe what you see? monocolor, if yes what color or some  
> strange patterns? even whether it is shown immediately or is somehow  
> slowly painted might help.
>
> Perhaps using the module parameter viafb_active_dev= with one of  
> CRT, DVI or LCD helps?
> If it doesn't....well I'm aware of one bug in that code that I hit  
> on my netbook. Will send you a fix if your observations sound related.

# modprobe viafb viafb_accel=0 viafb_active_dev=LCD viafb_mode=1024x768
works....
log:
Jun 22 06:30:01 mini2133 [   40.666874] VIA Graphics Intergration  
Chipset framebuffer 2.4 initializing
Jun 22 06:30:01 mini2133 [   40.748196] vmap allocation for size  
16781312 failed: use vmalloc=<size> to increase size.
Jun 22 06:30:01 mini2133 [   40.752198] Console: switching to colour  
frame buffer device 128x48

# fbset -i

mode "1024x768-60"
     # D: 64.998 MHz, H: 48.362 kHz, V: 60.002 Hz
     geometry 1024 768 1024 768 32
     timings 15385 160 24 29 3 136 6
     rgba 8/16,8/8,8/0,0/0
endmode

Frame buffer device information:
     Name        : Via
     Address     : 0xc0000000
     Size        : 268435456
     Type        : PACKED PIXELS
     Visual      : TRUECOLOR
     XPanStep    : 0
     YPanStep    : 1
     YWrapStep   : 0
     LineLength  : 4096
     MMIO Address: 0xfc000000
     MMIO Size   : 16777216
     Accelerator : Unknown (50)

"test color mode" - it's like lcd test : red-green-blue-grey- 
gradient-...etc

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
