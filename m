From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13566] New: nvidiafb
 doesn't get my oooold monitor working
Date: Mon, 29 Jun 2009 16:04:42 -0700
Message-ID: <20090629160442.0cbd68b8.akpm@linux-foundation.org>
References: <bug-13566-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MLPwd-0004r5-Nj
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 23:07:27 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLPu3-0002li-Gj for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 23:07:27 +0000
In-Reply-To: <bug-13566-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: bugzilla-daemon@bugzilla.kernel.org, ericitaquera@gmail.com, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 18 Jun 2009 13:04:12 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13566
> 
>            Summary: nvidiafb doesn't get my oooold monitor working
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.30
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: ericitaquera@gmail.com
>         Regression: No

There's more info at the above link

> 
> Nvidiafb doesn't get my ooooooold black & white 7" CRT VGA monitor working. I
> have an GeForce 6200 one:
> 
> root@slackade:~# lspci  | grep -i vga
> 01:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 6200
> TurboCache(TM)] (rev a1)
> 
> 
> This is the dmesg output with this old monitor ( or without any ) plugged to
> the VGA output:
> 
> root@slackade:~# dmesg | grep nvidia
> nvidiafb 0000:01:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> nvidiafb: Device ID: 10de0161 
> nvidiafb: CRTC0 analog not found
> nvidiafb: CRTC1 analog not found
> nvidiafb: CRTC 1 is currently programmed for TV
> nvidiafb: Using TV on CRTC 1
> nvidiafb: Panel is TMDS
> nvidiafb: MTRR set to ON
> nvidiafb: Flat panel dithering disabled
> nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)
> root@slackade:~# 
> 
> After that, even if I switch to a brand new 1080p lcd the screen just blinks
> with weird vertical stripes.
> 
> If I reboot with a newer monitor plugged to VGA output all works fine:
> 
> root@slackade:~# dmesg | grep nvidia
> nvidiafb 0000:01:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> nvidiafb: Device ID: 10de0161 
> nvidiafb: CRTC0 analog found
> nvidiafb: CRTC1 analog not found
> nvidiafb: CRTC 0 appears to have a CRT attached
> nvidiafb: Using CRT on CRTC 0
> nvidiafb: MTRR set to ON
> nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xD0000000)
> root@slackade:~# 
> 
> Tnx in advance!
> 

hm.  drivers/video/nvidia/ isn't exactly a hive of development activity
but let's switch this over to the mailing list and see if there's any
help.


------------------------------------------------------------------------------
