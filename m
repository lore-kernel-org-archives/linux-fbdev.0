From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: r128 driver problem
Date: Sat, 6 Nov 2004 08:35:46 +0800
Message-ID: <200411060835.53252.adaplas@hotpop.com>
References: <418B02BE.3040403@sun.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQEYp-0000Sw-CN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:36:07 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQEYo-0005rL-2N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:36:07 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 854279B6370
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  6 Nov 2004 00:35:59 +0000 (UTC)
In-Reply-To: <418B02BE.3040403@sun.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Bill Shannon <bill.shannon@sun.com>

On Friday 05 November 2004 12:34, Bill Shannon wrote:
> I'm looking for someone to help me with a problem I'm having with the
> r128 driver.  See attached messages for a description of the problem.
> I think I've proven that the problem is related to the driver/device,
> but I don't know enough about the device and how it works to fix the
> problem myself.  Any help would be much appreciated.
>

Looks like this is for the DRI people <dri-devel@lists.sourceforge.net>.

Tony

PS: The latest kernel snapshot contains an aty change that also installs an
interrupt handler that waits for vblank.  I doubt this is the cause of your
problems, but it's better to disable atyfb before sending mail to the DRI
list (in case you're using the latest kernel).




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
