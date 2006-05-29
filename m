From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Tue, 30 May 2006 05:00:07 +0800
Message-ID: <447B60D7.8020204@gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com> <44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr> <447A3CC0.9060403@gmail.com> <447AF58E.3050803@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkpDU-0002p0-Fh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:24:00 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fkoqg-00054x-Bq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:00:26 -0700
Received: by py-out-1112.google.com with SMTP id b29so221333pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 May 2006 14:00:22 -0700 (PDT)
In-Reply-To: <447AF58E.3050803@iit.demokritos.gr>
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
To: vasvir@iit.demokritos.gr
Cc: linux-fbdev-devel@lists.sourceforge.net

Vassilis Virvilis wrote:
> Antonino A. Daplas wrote:
> 
>>
>> Too many differences since the timings for the 2 modes are also
>> different.
>> If you can match the timings, as shown by fbset and xvidtune, this should
>> minimize the variation.
>>
> [snip]
>>
>> savagefb does save the initial registers and reuses part of them when
>> setting
>> the mode, so if you can boot with vga= parameter that matches the
>> initial mode
>> of savagefb, it might help. Try this:
>>
>> video=savagefb:1024x768-16@60 vga=0x317
>>
> 
> thanks for the hand holding.
> 
> Let me reiterate to make sure I understood correctly.
> 
> Let's concentrate in one mode because trying all the modes is very time
> consuming.
> Since I am interested mainly in 640x480-16@xx that means vga=0x311. That
> also
> means I shouldn't fiddle with SVGATextMode before loading the savagefb
> driver.
> Right now I am doing a lot of mode3; SVGATextMode -x to restore the
> console.
> 
> So I am booting with video=savagefb:640x480-16@60 vga=0x317 and prevent
> SVGATextMode from running.
> 
> Now for mode setting. I will run X, xvidtune, fetch the mode. I will use
> http://www.tldp.org/HOWTO/Framebuffer-HOWTO-18.html
> instructions to convert the mode to a line fbset understands. Then
> I will force my SDL test app to use the mode previously set by fbset
> and then I will run the savagedump to compare with the X dump.
> 
> I will try the procedure above ASAP and report back unless you have any
> objections in the methodology.

Much simpler if you just load X first with UseBIOS False then dump the regs.
Do the same with UseBIOS True.  You mentioned that X does not work if the
option UseBIOS is false.

Tony 


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
