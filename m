From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 19:23:40 +0000
Message-ID: <200411231923.40572.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411231801.14328.andrew@walrond.org> <200411240226.03203.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWgGW-0008Ir-Kr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:23:52 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWgGT-00087R-MW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:23:52 -0800
In-Reply-To: <200411240226.03203.adaplas@hotpop.com>
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

On Tuesday 23 Nov 2004 18:26, Antonino A. Daplas wrote:
>
> For now, I'll add checks during the initializatiion that will refuse modes
> greater than the panel size.
>
Even if they are listed in the list of supported modes and detailed modes in 
the EDID?

My (dvi) edid lists valid modes of

      First DETAILED Timing is preferred
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Standard Timings
      1280x1024@60Hz
      1024x819@85Hz
      800x640@85Hz
      640x512@85Hz
   Detailed Timings
      65 MHz 1024 1040 1104 1344 768 781 783 817 -HSync -VSync

      162 MHz 1600 1664 1856 2160 1200 1201 1204 1250 +HSync +VSync

Ok, the first detailed mode is preferred, but the second is equal;y supported.

> Unfortunately, without any docs on how to adjust the default panel size,
> you will be limited to this resolution only.

I'm a bit confused now. On one hand you seem to be testing for and rejecting 
modes > panel size in the driver; But here I infer that the hardware won't 
accept these modes unless we can somehow reset the panel size first?

>
> Does vesafb work in x86_64?  If it does you can add this in your
> commandline:
>
> vga=0x307
>
> 0x306 is the code for 1280x1024, see Documentation/fb/vesafb.txt.
>
> Then check your dmesg if the panel size also changed.  If it did, then
> you can do this:
>
> vga=0x307 video=nvidiafb:1280x1024@60.

And this is just a possible means of tricking the hardware into adjusting the 
panel size for us?

Sorry about all the questions, but I want to understand so I can investigate 
further. Its frustrating having massively expensive screens with the latest 
digital dvi cables behaving like a cheap 1024x768 monitor ;)

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
