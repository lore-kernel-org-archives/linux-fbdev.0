From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] GeForce 5200 on rivafb
Date: Tue, 14 Dec 2004 05:47:19 +0800
Message-ID: <200412140547.22222.adaplas@hotpop.com>
References: <200412120511.31725.adaplas@hotpop.com> <7vpt1fu97r.fsf@assigned-by-dhcp.cox.net> <200412140452.19873.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdy2g-0005Ln-9o
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 13:47:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdy2f-0001WV-Mu
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 13:47:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1AEE1A8146E
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Dec 2004 21:47:24 +0000 (UTC)
In-Reply-To: <200412140452.19873.adaplas@hotpop.com>
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
To: Junio C Hamano <junkio@cox.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 14 December 2004 04:52, Antonino A. Daplas wrote:

> Can you try this patch and enable nvidiafb-i2c. It adds your monitor model
> to the database of displays with broken edid's and attempts a fix. It
> checks first if the monitor is GTF capable, and if it is, sets the input
> type from digital to analog. (I don't think digital inputs can be GTF
> capable).

Apply this patch too, I forgot to adjust the checksum.

Tony

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2004-12-14 04:38:30 +08:00
+++ b/drivers/video/fbmon.c	2004-12-14 05:46:20 +08:00
@@ -119,8 +119,10 @@
 				b = edid + EDID_STRUCT_DISPLAY;
 				/* Only if display is GTF capable will
 				   the input type be reset to analog */
-				if (b[4] & 0x01)
+				if (b[4] & 0x01) {
 					b[0] &= ~0x80;
+					edid[127] += 0x80;
+				}
 			}
 		}
 	}





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
