From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH 1/6] atyfb: Add boot/module option to override composite sync
Date: Sun, 13 Mar 2005 16:37:21 +0100
Message-ID: <200503131637.21630.alex.kern@gmx.de>
References: <200503130832.41113.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAVAR-0007zN-MK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 07:38:11 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DAVAQ-0007KR-0V
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 07:38:11 -0800
In-Reply-To: <200503130832.41113.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

Am Sonntag, 13. M=E4rz 2005 01:32 schrieb Antonino A. Daplas:
>   Some SPARC-based displays need the composite sync set to high.
>   Since none of the entries in the default db has the composite
>   sync set to high, using fb_find_mode() will produce a blank
>   display.
>
>   Add this new option to Documentation/fb/aty128fb.txt
>
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
We do not have documentation file for aty.
In other Part:
Acked-by: Alexander Kern <alex.kern@gmx.de>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
