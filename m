From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] GeForce 5200 on rivafb
Date: Thu, 16 Dec 2004 04:02:38 +0800
Message-ID: <200412160402.39863.adaplas@hotpop.com>
References: <200412120511.31725.adaplas@hotpop.com> <200412140547.22222.adaplas@hotpop.com> <7vr7lt8gii.fsf@assigned-by-dhcp.cox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CefMQ-0005PO-OO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Dec 2004 12:02:58 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CefMQ-0008Tb-1E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Dec 2004 12:02:58 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 31D40B93279
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Dec 2004 20:02:44 +0000 (UTC)
In-Reply-To: <7vr7lt8gii.fsf@assigned-by-dhcp.cox.net>
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

On Tuesday 14 December 2004 15:51, Junio C Hamano wrote:
> >>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:
>
> AAD> Can you try this patch and enable nvidiafb-i2c. It adds your monitor
> model AAD> to the database of displays with broken edid's and attempts a
> fix. It AAD> checks first if the monitor is GTF capable, and if it is, sets
> the input AAD> type from digital to analog. (I don't think digital inputs
> can be GTF AAD> capable).
>
> AAD> Apply this patch too, I forgot to adjust the checksum.
>
> Thanks as always for a quick help.
>
> With those two patches, your fixup message appears in the boot
> log 6 times (is it expected?).  The monitor does not go blank

Yes, it should be printed only once. 

> anymore; it safely defaults to CRTCNumber 0.  Overall, it is as
> if I am using your nvidiafb driver without nvidia-i2c ;-).

No, of course not.  There are certain advantages:

1. Without boot options, your display will automatically go to
   1024x768@85 Hz, since this is the preferred timing.

2. The driver will refuse modes that exceeds the monitor's operating.

3.  Because your display is GTF capable, all you need to do is:

fbset -xres 1600 -yres 1200 /* xres and yres can be any value */

and as long as #2 is satisfied, the modeline for 1600x1200 at the highest
refresh rate will be computed, no need to enter a modline in /etc/fb.modes.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
