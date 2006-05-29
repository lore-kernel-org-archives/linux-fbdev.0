From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Mon, 29 May 2006 16:22:22 +0300
Message-ID: <447AF58E.3050803@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com> <44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr> <447A3CC0.9060403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkhcQ-0000j4-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 06:17:14 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FkhcQ-0001mr-E1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 06:17:14 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkhcO-0004zZ-2p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 06:17:14 -0700
In-Reply-To: <447A3CC0.9060403@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

> 
> Too many differences since the timings for the 2 modes are also different.
> If you can match the timings, as shown by fbset and xvidtune, this should
> minimize the variation.
> 
[snip]
> 
> savagefb does save the initial registers and reuses part of them when setting
> the mode, so if you can boot with vga= parameter that matches the initial mode
> of savagefb, it might help. Try this:
> 
> video=savagefb:1024x768-16@60 vga=0x317
> 

thanks for the hand holding.

Let me reiterate to make sure I understood correctly.

Let's concentrate in one mode because trying all the modes is very time consuming.
Since I am interested mainly in 640x480-16@xx that means vga=0x311. That also
means I shouldn't fiddle with SVGATextMode before loading the savagefb driver.
Right now I am doing a lot of mode3; SVGATextMode -x to restore the console.

So I am booting with video=savagefb:640x480-16@60 vga=0x317 and prevent
SVGATextMode from running.

Now for mode setting. I will run X, xvidtune, fetch the mode. I will use
http://www.tldp.org/HOWTO/Framebuffer-HOWTO-18.html
instructions to convert the mode to a line fbset understands. Then
I will force my SDL test app to use the mode previously set by fbset
and then I will run the savagedump to compare with the X dump.

I will try the procedure above ASAP and report back unless you have any
objections in the methodology.

         .bill


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
