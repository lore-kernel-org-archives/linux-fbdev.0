From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re: [PATCH] GeForce 5200 on rivafb
Date: Mon, 13 Dec 2004 17:57:56 -0800
Message-ID: <7vllc1tzdn.fsf@assigned-by-dhcp.cox.net>
References: <200412120511.31725.adaplas@hotpop.com>
	<7vd5xgmevm.fsf@assigned-by-dhcp.cox.net>
	<7vpt1fu97r.fsf@assigned-by-dhcp.cox.net>
	<200412140452.19873.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeUTa-0001QY-QD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Dec 2004 00:25:38 -0800
Received: from fed1rmmtai12.cox.net ([68.230.241.47])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CeUTZ-0006Wu-F3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Dec 2004 00:25:38 -0800
In-Reply-To: <200412140452.19873.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Tue, 14 Dec 2004 04:52:18 +0800")
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> Can you try this patch and enable nvidiafb-i2c. It adds
AAD> your monitor model to the database of displays with broken
AAD> edid's and attempts a fix. It checks first if the monitor
AAD> is GTF capable, and if it is, sets the input type from
AAD> digital to analog. (I don't think digital inputs can be GTF
AAD> capable).

Sorry, but I do not know what GTF is.  I'll trust you with that
detection logic ;-).

AAD> However, do you know if your monitor model does support digital input?

I looked at the back of the monitor last night.  There is a hole
about 1cm in diameter, which is covered.  Presumably their
slightly different model that shares the same enclosure uses the
hole for digital input cable?  But not the one I have.  The
datasheet I have on PF775 also says it is an anolog monitor with
D-sub connector and nothing else.

- http://www.tlccsi.com/pdf/pf775.pdf



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
