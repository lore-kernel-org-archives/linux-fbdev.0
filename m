From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer kbuild -- add options for building software ops
 (0/4)
Date: Tue, 15 Feb 2005 10:45:51 +0000
Message-ID: <4211D2DF.2070302@arcom.com>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be> <Pine.LNX.4.56.0502141724240.6781@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D10DP-0003vZ-7O
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:45:59 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D10DN-0008PF-Oi
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:45:59 -0800
In-Reply-To: <Pine.LNX.4.56.0502141724240.6781@pentafluge.infradead.org>
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

James Simmons wrote:
>>>1/2 -- add the FB_SOFTWARE_CFB_OPS option to Kconfig and Makefile
>>>2/2 -- make all drivers (where appropriate) select FB_SOFTWARE_CFB_OPS
>>
>>But I'd prefer to have 3 separate options, since some drivers don't need all 3
>>of them, e.g.:
>>  - CONFIG_CFB_FILLRECT
>>  - CONFIG_CFB_COPYAREA
>>  - CONFIG_CFB_IMAGEBLT
> 
> We should have CONFIG_SOFT_CURSOR for the sotftware cursor, softcursor.c, as 
> well. David could you add that as well? 

Done. Even though it seems of little use.  It seems only two drivers
don't use soft_cursor (rivafb and intelfb).

A new set of four patches to follow.

1/4 -- add FB_CFB_xxx options to framebuffer Kconfig and Makefile
2/4 -- make all framebuffer drivers (where appropriate) select FB_CFB_xxx
3/4 -- add FB_SOFT_CURSOR options to framebuffer Kconfig and Makefile
4/4 -- make all framebuffer drivers (where appropriate) select
FB_SOFT_CURSOR.

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
