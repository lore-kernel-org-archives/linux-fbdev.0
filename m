From: "arun c" <arun.edarath@gmail.com>
Subject: How to implement rotation for framebuffer?
Date: Fri, 4 Apr 2008 14:32:24 +0530
Message-ID: <c656a4d20804040202g370948e2pa4d70b1f693df2cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhhoX-0003Xz-O8 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 02:02:25 -0700
Received: from wr-out-0506.google.com ([64.233.184.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhhoW-0000MQ-Ci
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 02:02:25 -0700
Received: by wr-out-0506.google.com with SMTP id c48so2777873wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 04 Apr 2008 02:02:24 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,

I am working on 2430SDP. SDP has omap2430 as the processor and it's
display controller supports rotation of framebuffer in hardware.

I will explain the hardware rotation in brief.

1) One Physical framebuffer is allocated in memory
2) This physical address ( as well as width and height) is programmed in the
    VRFB Module (the hardware rotation engine, it stands for virtual rotated
    frame buffer)
3)Then VRFB gives you 4 addresses ( virtual addresses which are
transparent to applications)
    VBA0      --> Address for 0 degree rotation
    VBA90    --> Address for 90 degree rotation
    VBA180  --> Address for 180 degree rotation
    VBA270  --> Address for 270 degree rotation

Rotation is achieved like this
Assume you want 90 degree rotation

Processor writes all picture data to VBA90 space and lcd reads all
data from VBA0 space

For this kind of implementation i need to change fb_fix_screeninfo
members (smem_start ,smem_len) and fb_info member( screen_base)
dynamically according to degree of rotation.

Please anybody suggest me  good ways to implement this kind of
rotation in my driver or point me to some code so that i can refer and
implement the same.

Regards,
Arun C

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
