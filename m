From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when "sensors" used as non-root
Date: Fri, 18 Mar 2005 04:11:09 +0800
Message-ID: <200503180411.09538.adaplas@hotpop.com>
References: <20050317110941.4e5801fa.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC1Kq-0000qY-4r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 12:11:12 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DC1Kn-00023d-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 12:11:11 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B999D14C427B
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 20:10:56 +0000 (UTC)
In-Reply-To: <20050317110941.4e5801fa.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: khali@linux-fr.org, salahx@yahoo.com

On Friday 18 March 2005 03:09, Andrew Morton wrote:
> This might be a savagefb bug?

This is being discussed in another "Who should I write to about this OOPS in
2,6,11-mm3?".  Just tested a fix by Jean Delvare which, based on my limited
knowledge on i2c, seems to work.

You're also in the CC list of the said thread, BTW.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
