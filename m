From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/10] nvidiafb: Fix i2c error handling
Date: Sat, 05 Mar 2005 17:54:10 -0800
Message-ID: <7v8y51k08t.fsf@assigned-by-dhcp.cox.net>
References: <200503060816.43987.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7kyQ-0004N2-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 17:54:26 -0800
Received: from fed1rmmtao12.cox.net ([68.230.241.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7kyN-0002jw-TN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 17:54:26 -0800
In-Reply-To: <200503060816.43987.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Sun, 6 Mar 2005 08:16:43 +0800")
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Could you tell me (and the list) what version of the source tree
these patches are relative to?  I do not think Linux 2.6.11 has
merged nvidiafb yet.

I've been using:

    Message-ID: <200502172045.36673.adaplas@hotpop.com>
    From: "Antonino A. Daplas" <adaplas@hotpop.com>
    Newsgroups: gmane.linux.fbdev.devel
    Subject: [PATCH 6/7] nvidiafb: Add update framebuffer driver for nVidia chipsets
    Date: Thu, 17 Feb 2005 20:45:36 +0800

and I presume the patches you are posting this week are on top
of these but I was not sure hence this question.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
