From: Raphael Assenat <raph@8d.com>
Subject: Re: [PATCH 1/2] mbxfb: Fix a chip bug?
 resulting in	wrong pixclock
Date: Tue, 15 Aug 2006 08:47:03 -0400
Message-ID: <44E1C247.8040004@8d.com>
References: <44E0C3A4.6050407@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCyIt-0004r3-Dt for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 05:45:55 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GCyIr-0005QM-0a
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 05:45:55 -0700
In-Reply-To: <44E0C3A4.6050407@8d.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Raphael Assenat wrote:
> This is a workaround for what I think is a bug in the 2700G chip.
> 
> The PLL output frequency is adustable using 3 values (M, N and P. See
> code for formula). The N value range is documented to be 1 to 7 but when
> it is set to 1, the output frequency is lower than it should be (divided 
> by 2),
> giving unexpected results such as no sync on a CRT display.
I just thought it might be useful to post information about how to reproduce this:

Install fbset and link /etc/fb.modes to the fb.modes.ATI distributed with fbset.

Do 'fbset "800x600-70" -depth 16' and the generated pixel clock will result in a v-sync 
around 25 hz. The 800x600-60 and 800x600-72 modes will work correctly, with the expected 
v-sync values.

After applying the patch, the "800x600-70" mode works correctly.

Here are the modelines from my fb.modes file, just in case:
mode "800x600-70"
     # D: 44.90 MHz, H: 44.544 kHz, V: 70.04 Hz
     geometry 800 600 800 600 8
     timings 22272 40 24 15 9 144 12
     hsync high
endmode

mode "800x600-60"
     # D: 40.00 MHz, H: 37.879 kHz, V: 60.32 Hz
     geometry 800 600 800 600 8
     timings 25000 88 40 23 1 128 4
     hsync high
     vsync high
endmode

mode "800x600-72"
     # D: 50.00 MHz, H: 48.090 kHz, V: 72.19 Hz
     geometry 800 600 800 600 8
     timings 20000 64 56 23 37 120 6
     hsync high
     vsync high
endmode



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
