From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] GeForce 5200 on rivafb
Date: Tue, 14 Dec 2004 20:02:54 +0800
Message-ID: <200412142002.56081.adaplas@hotpop.com>
References: <200412120511.31725.adaplas@hotpop.com> <200412140452.19873.adaplas@hotpop.com> <7vllc1tzdn.fsf@assigned-by-dhcp.cox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeBOm-0008Du-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 04:03:24 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CeBOm-0002Gg-8r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 04:03:24 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9D23FB81AE7
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Dec 2004 12:03:18 +0000 (UTC)
In-Reply-To: <7vllc1tzdn.fsf@assigned-by-dhcp.cox.net>
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

On Tuesday 14 December 2004 09:57, Junio C Hamano wrote:
> >>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:
>
> AAD> Can you try this patch and enable nvidiafb-i2c. It adds
> AAD> your monitor model to the database of displays with broken
> AAD> edid's and attempts a fix. It checks first if the monitor
> AAD> is GTF capable, and if it is, sets the input type from
> AAD> digital to analog. (I don't think digital inputs can be GTF
> AAD> capable).
>
> Sorry, but I do not know what GTF is.  I'll trust you with that
> detection logic ;-).

Generalized Timing Formula.  It's a VESA standard that allows mode setting
given just the horizontal and vertical resolutions, and any of the following:

vertical refresh,
horizontal frequency, or
dotclock.

Meaning, no need for mode tables, and it can support practically any combination
of xres, yres and refresh rates.

>
> AAD> However, do you know if your monitor model does support digital input?
>
> I looked at the back of the monitor last night.  There is a hole
> about 1cm in diameter, which is covered.  Presumably their
> slightly different model that shares the same enclosure uses the
> hole for digital input cable?  But not the one I have.  The
> datasheet I have on PF775 also says it is an anolog monitor with
> D-sub connector and nothing else.

Ok.  I would presume that the model that does support digital input will also
have a different model id in its EDID block.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
