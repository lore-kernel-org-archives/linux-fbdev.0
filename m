From: "Armin Krieg" <warcomp@gmx.at>
Subject: Re: problems with radeonfb in linux-2.6.11-rc3
Date: Sat, 12 Feb 2005 01:03:03 +0100 (MET)
Message-ID: <1473.1108166583@www37.gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Czkki-0002S3-CA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 16:03:12 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Czkkg-0001ZW-G3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 16:03:12 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

> Sounds like it could be related to the recently added colour buffer
> tiling... CC'ing dri-devel, please follow up there only about this
> problem. Does your X server log contain 'Color tiling enabled by
> default'? If so, does Option "ColorTiling" "off" fix the problem?
>
yes fixes the problem !

wkr. Armin Krieg

-- 
Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS
GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
