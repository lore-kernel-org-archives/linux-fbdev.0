From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 12:32:57 +0000
Message-ID: <200411231232.57420.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411222347.17562.andrew@walrond.org> <200411230950.24311.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWZr4-0004id-4T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 04:33:10 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWZr1-0004xE-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 04:33:09 -0800
In-Reply-To: <200411230950.24311.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Tuesday 23 Nov 2004 01:50, Antonino A. Daplas wrote:
> On Tuesday 23 November 2004 07:47, Andrew Walrond wrote:
> >
> > Note the erroneous panel detection; this is a 1600x1200 tft lcd. The
> > panel is detected as 1024x768 in every following case.
>
> The panel size is programmed by the BIOS, not sure what what we can do
> about that.  So even if your display supports 1600x1200, you're still
> limited to 1024x768.

What, the video-card BIOS? Shouldn't it get the correct info from the EDID?

andrew@orac fbdev $ read-edid-1.4.1/parse-edid edid.dsub.32
read-edid-1.4.1/parse-edid: parse-edid version 1.4.1
read-edid-1.4.1/parse-edid: EDID checksum passed.

        # EDID version 1 revision 3
Section "Monitor"
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
        Identifier "iiyama "
        VendorName "IVM"
        ModelName "iiyama "
        # Block type: 2:0 3:fd
        HorizSync 30-80
        VertRefresh 56-85
        # Max dot clock (video bandwidth) 170 MHz
        # Block type: 2:0 3:fc
        # DPMS capabilities: Active off:yes  Suspend:yes  Standby:yes

        Mode    "1024x768"      # vfreq 59.196Hz, hfreq 48.363kHz
                DotClock        65.000000
                HTimings        1024 1040 1104 1344
                VTimings        768 781 783 817
                Flags   "-HSync" "-VSync"
        EndMode
        Mode    "1600x1200"     # vfreq 60.000Hz, hfreq 75.000kHz
                DotClock        162.000000
                HTimings        1600 1664 1856 2160
                VTimings        1200 1201 1204 1250
                Flags   "+HSync" "+VSync"
        EndMode
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
EndSection

>
> It seems that EDID block is not detected whether digital or analog. I think
> I missed a Kconfig changeset. Should be fixed with the included patch.
>
> Select y to FB_NVIDIA_I2C.
>

Ok, with your incremental patch, DSUB connection and no kernel params, the 
kernel boots into a corruption free 1600x1200 (200xwhatever) console with two 
nice penguins, after detecting EDIDs on BUS2 and BUS3.
Unfortunately, it then  Oops's like this: (copied by hand)

 Oops : PREEMPT SMP

 tty_open+342  chrdev_open+457
 dentry_open+315 filp_open+62
 get_unused_fd+244 sys_open+76
 init+652   child_rip+8
 init+0    child_rip+0

 RIP: check_tty_count+58

Booting with DVI connection and no params gives me a corruption free 1024x768 
console with two nice penguins. It also then Oopses in an identical way to 
above.

Getting closer...

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
