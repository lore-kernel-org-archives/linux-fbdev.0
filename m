From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-users] radeon/2.6.5-rc1-mm1 sets strange frequencies
Date: Wed, 17 Mar 2004 21:48:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403172145380.19415-100000@phoenix.infradead.org>
References: <20040317073840.GA15392@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040317073840.GA15392@middle.of.nowhere>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-users@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> After booting 2.6.5-rc1-mm1 with this command-line:
> 
> kernel /vmlinuz-265rc1mm1 root=/dev/hda3 video=radeonfb:1600x1200-32@75 acpi=force
> 
> I get a warning on my monitor:
> 
> fH 271.5 kHz
> fV 217.2 Hz

I haven't seen that before :-/ The kernel isn't generating that. I just 
looked threw the code.

> That is obviously not what I meant by 1600x1200-32@75.
> 
> fbset -V tells me:
> 
> Linux Frame Buffer Device Configuration Version 2.1 (23/06/1999)
> (C) Copyright 1995-1999 by Geert Uytterhoeven
> 
> 
> mode "1600x1200-75"
>     # D: 202.511 MHz, H: 93.755 kHz, V: 75.004 Hz
>     geometry 1600 1200 1600 1200 32
>     timings 4938 304 64 46 1 192 3
>     hsync high
>     vsync high
>     rgba 8/16,8/8,8/0,0/0
> endmode

This looks right.


> Obviously, it's bad that I define what video-mode I want and radeonfb
> starts changing that to bogus values. The monitor is an Eizo F931,
> connected via a Rose Electronics Vista KVM.

What is you want exactly?



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
