From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: some nvidiafb test results
Date: Mon, 13 Dec 2004 02:59:55 +0800
Message-ID: <200412130259.57008.adaplas@hotpop.com>
References: <200412112353.06870.rfjak@eircom.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdZ1P-0003M9-UU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 11:04:43 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdZ1P-0005YB-7A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 11:04:43 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0B1BDB52911
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Dec 2004 19:04:31 +0000 (UTC)
In-Reply-To: <200412112353.06870.rfjak@eircom.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, John Kinsella <rfjak@gofree.indigo.ie>

On Sunday 12 December 2004 19:04, John Kinsella wrote:
> But when I test nvidiafb on my Toshiba Satellite laptop with 32Mb GeForce4
> 420Go, things are not so good : rivafb works OK for the last few 2.6.x
> releases, but nvidiafb does not. With nvidiafb, I get a display shifted so
> that the first column appears over near the right hand side of screen. The
> first 4 columns also appear twice e.g. for login prompt "Toshiba login", I
> see "ToshTosh login" over near the right margin of the screen. Using fbset
> to display the resolution timings, I get different results between nvidiafb
> & rivafb.
> NB: no EDID is available for the LCD, so I usually pass in a mode like
> video=rivafb:1024x768-60

Can you turn off debugging in both rivafb and nviidiafb?  Then, enable debugging
in drivers/video/fbmon.c by changing this line:

#undef DEBUG
to
#define DEBUG.

Then send me the dmesg for both nvidiafb and rivafb.

Thanks.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
