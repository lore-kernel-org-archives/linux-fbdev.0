From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: FB accel capabilities patch
Date: Wed, 19 May 2004 16:39:35 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085002775.40abd417121b0@mail.theboonies.us>
References: <Pine.LNX.4.44.0405192026290.28783-100000@phoenix.infradead.org>
Reply-To: David Eger <eger-dated-1085607583.de86ce@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQYmv-0000VT-Ca
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 14:39:45 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BQYmu-0008Kt-Uz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 14:39:45 -0700
In-Reply-To: <Pine.LNX.4.44.0405192026290.28783-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: akpm@osdl.org, Linux Frame Buffer Dev <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Quoting James Simmons <jsimmons@infradead.org>:

> > +/* FBIF = FB_Info.Flags */
> > +#define FBIF_MODULE		0x0001	/* Low-level driver is a module */
>
> Ug. You changed that. Could that remain the same.

Will it suffice to add

#define FBINFO_FLAG_MODULE FBIF_MODULE

for backwards compatibility?

I'd prefer the new flags to be FBIF_*, as the identifier
FBINFO_FLAG_HWACCEL_COPYAREA seems sorta long to me...

I'll sync with linus's bk tomorrow and try to rework my main patch; the
"mainline" patch I posted was against his bk shortly after 2.6.6...

> I have a patch coming that fixes the mode setting. It changes alot of the
> core fbcon.c so I will apply your patch to the fbdev-2.5 tree.

I take it this is in addition to your con2fb patch I have posted at that web
address?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
