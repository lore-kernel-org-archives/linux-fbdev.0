From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Interlace for rivafb driver
Date: Tue, 28 Jan 2003 19:29:36 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301281927590.12076-100000@phoenix.infradead.org>
References: <1043536112.1281.53.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dbQx-0005Yf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jan 2003 11:30:12 -0800
In-Reply-To: <1043536112.1281.53.camel@h9n1fls20o980.telia.com>
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

On 26 Jan 2003, Fredrik Noring wrote:

> Attached patch implements interlace for the rivafb driver and
> the hardware that supports it (Riva 128, TNT, TNT2, some GeForce 
> cards and possibly others).
> 
> It's a patch against 2.4.21-pre2 (with polarity and sync patches)
> but it should fit with 2.5.x too skipping riva_hw.c and riva_hw.h 
> which already are adopted from XFree86.

Applied. 


P.S
   To Tony. I applied your patches as well. The only patch I didn't was 
the DIRECTCOLOR patch. The X server freaked out for my card when the video 
mode was in a DIRECTCOLOR state.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
