From: Ant Allen <aallen@race-technology.com>
Subject: Screen flipping on linux fb on pxa255
Date: Fri, 26 Mar 2004 00:12:14 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403260012.14090.aallen@race-technology.com>
Reply-To: aallen@race-technology.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6ewm-0003RL-SP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 16:11:40 -0800
Received: from mail21b.london21-verio.com ([213.130.33.22])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B6ewk-0000rt-9X
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 16:11:38 -0800
Received: from www.race-technology.com (213.130.43.213)
	by mail21b.london21-verio.com (RS ver 1.0.92vs) with SMTP id 3-0545979893
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Mar 2004 00:11:33 +0000 (GMT)
Content-Disposition: inline
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

Hi all,

I have a CRT connected to a pxa255 running linux 2.4.18.  By changing the boot 
options I can choose from a list of 3 resolutions, but smem_len is always 
exactly one screen at that resolution.

I need to double buffer the screen from my application using the pan_display 
ioctl or the yoffset parameter in the vinfo struct.  How can I set this up?

Does anyone have any example code or a patch for the kernel source to do this?  
I'd be very grateful for any help with this. 

Feel free to point me to somewhere more appropriate for this question if need 
be.

Thanks
Ant



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
