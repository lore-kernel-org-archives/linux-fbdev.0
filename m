From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Funny sync calculation correction
Date: Sat, 25 Jan 2003 19:13:22 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301251912560.2597-100000@phoenix.infradead.org>
References: <1043450243.10711.41.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cVkb-0000H4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Jan 2003 11:13:58 -0800
In-Reply-To: <1043450243.10711.41.camel@h9n1fls20o980.telia.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fredrik Noring <noring@nocrew.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

> I've been digging around in the rivafb module to find out why some
> modes converted from XFree86 4.2 don't work on some display devices.
> Here's a funny part of the riva_load_video_mode function (Linux
> 2.4.21-pre2):
> 
> 	hStart = (hDisplaySize + video_mode->right_margin) / 8 + 2;
> 	hEnd   = (hDisplaySize + video_mode->right_margin +
> 		 video_mode->hsync_len) / 8 - 1;
> 
> Please notice how "hsync_len" does not actually represent the length
> of the sync. Rather, it's compensated with 24 pixels. The corresponding
> code in the XFree86 4.2 (nv_dac.c) contains no such compensation:
> 
>     int horizStart      = (mode->CrtcHSyncStart/8) - 1;
>     int horizEnd        = (mode->CrtcHSyncEnd/8)   - 1;
> 
> The difference seems to be almost insignificant for modern multisync
> screens, but devices such as TV:s get confused by the current version.
> Is there a reason for the difference in calculations?
> 
> The attached patch corrects the calculations in accordance with XFree86
> and works better with the modelines I've tested. 
> 
> Please give it a try. Thanks,

Works fine. I applied it to the 2.5.X tree.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
