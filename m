From: "Praveen VS" <praveen@spacomp.com>
Subject: s6b33B0A  LCD controller & framebuffer console
Date: Mon, 14 Mar 2005 21:08:18 +0530
Message-ID: <007501c528ab$e27256f0$0400a8c0@praveenvs>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DArg9-0007eV-BO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:40:25 -0800
Received: from dvorak.siteprotect.com ([64.26.0.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DArg7-0005P4-QF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:40:25 -0800
Received: from praveenvs ([202.88.159.73])
	by dvorak.siteprotect.com (8.11.6/8.11.6) with ESMTP id j2EFeJB10946
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 09:40:19 -0600
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

We are writng a LCd driver forSamsung s6b33B0A in Linux2.6.9 .
The Controller is interfaced to the PXa255 externally thro VLIO.
We are successful in getting the Colors on the LCd by writing into it
RAW.

The Controller & the interface doesnot support the standard Framebuffer
console. How can we get a similar console to run our Gui application
based on QT embedded.

Can we get any or similar type of interface for which linux driver is
written, if so can we get any sample code or pointers on how to do it..


Thanks

Regards
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
