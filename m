From: David Vrabel <dvrabel@arcom.com>
Subject: Re: [PATCH 2/7] fbdev: Make fb_find_mode() return
 failure if modular
Date: Thu, 17 Feb 2005 14:29:41 +0000
Message-ID: <4214AA55.3000006@arcom.com>
References: <200502172045.16677.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1mfC-0006Oh-FO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 06:29:54 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1mfA-0004bw-0n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 06:29:54 -0800
In-Reply-To: <200502172045.16677.adaplas@hotpop.com>
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

Antonino A. Daplas wrote:
> A few drivers call fb_find_mode() even if compiled as a module.  If the
> modedb parameter is NULL, the function will use default modedb array which
> is marked __init. This will cause a crash.  To avoid this, check if the
> driver is compiled as a module, and if it is, fail.

Why limit the default mode DB to built-in drivers only?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
