From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sat, 11 Dec 2004 23:22:04 +0800
Message-ID: <200412112322.05601.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cd94f-00038y-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 07:22:21 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cd94e-00006M-NU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 07:22:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1EE11128AE49
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Dec 2004 15:22:11 +0000 (UTC)
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
To: Junio C Hamano <junkio@cox.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

--- Junio C Hamano <junkio@cox.net> wrote:

> >>>>> "AAD" == Antonino A Daplas
> <adaplas@hotpop.com> writes:
> 
Dec 10 19:04:40 siamese kernel: nvidiafb: nVidia device/chipset 
10DE0110
Dec 10 19:04:40 siamese kernel: nvidiafb: nVidia Corporation NV11 
[GeForce2 MX/MX 400]
Dec 10 19:04:40 siamese kernel: nvidiafb: EDID found from BUS1

The EDID block is properly detected, so that's a good sign.

Dec 10 19:04:40 siamese kernel:       Display is GTF capable
Dec 10 19:04:40 siamese kernel: nvidiafb: Unable to detect which 
CRTCNumber...
Dec 10 19:04:40 siamese kernel: ...Defaulting to CRTCNumber 1
Dec 10 19:04:40 siamese kernel: nvidiafb: Using DFP on CRTC 1
Dec 10 19:04:40 siamese kernel: Panel size is 1 x 1

Panel size of 1x1 is a bad sign.  (Panel size is set by video BIOS).

Can you try the following:

1. Change this line in drivers/video/fbmon.c

#undef DEBUG

to 

#define DEBUG

2. Experiment with the following boot options:
forceCRTC (values are 0 or 1) and flatpanel. 

So you can try this, for a start:

video=nvidiafb:forceCRTC:1

3.  If you see the penguin, but no text, do an fbset -accel false.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
