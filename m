From: Raphael Assenat <raph@raphnet.net>
Subject: atyfb h/vsync polarity
Date: Wed, 22 Jun 2005 10:08:42 -0400
Message-ID: <20050622140842.GV20191@midgar.lan.raphnet.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dl5uQ-0005yx-GM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Jun 2005 07:08:54 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1Dl5uQ-0002Ch-39
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Jun 2005 07:08:54 -0700
Received: from gate1.raphnet.net ([66.11.176.18] helo=midgar.lan.raphnet.net)
	by roc.holo.8d.com with asmtp (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24)
	(Exim 4.34)
	id 1Dl5uH-0000S3-Gi
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Jun 2005 10:08:50 -0400
Received: from raph by midgar.lan.raphnet.net with local (Exim 3.35 #1 (Debian))
	id 1Dl5uE-0001fx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jun 2005 10:08:42 -0400
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I am a Linux Sparc64 user, and recently I decided to switch from 2.4
kernel series to 2.6 series. Everything worked well, but I had trouble
getting the framebuffer console to work.

In openboot, my monitor worked perfectly. But as soon as Linux
configured the framebuffer, my monitor would loose sync. I compared the
output given by fbset on the working configuration (2.4 kernel) and the
non-working configuration (2.6.12 kernel). Every setting was identical,
except that the output on 2.4 had 'hsync high'. I tried 'fbset -hsync
high', but the screen still did not sync, and fbset still did not report
'hsync high', as if the setting was ignored.

After digging a little bit, I found this in
drivers/video/aty/atyfb_base.c:

if(vdisplay < 400) {
		h_sync_pol = 1;
		v_sync_pol = 0;
} else if(vdisplay < 480) {
		h_sync_pol = 0;
		v_sync_pol = 1;
} else if(vdisplay < 768) {
		h_sync_pol = 0;
		v_sync_pol = 0;
} else {
		h_sync_pol = 1;
		v_sync_pol = 1;
}

So no mater what sync polarity we ask for, the driver overrides them. I commented
the code above in my build, and the framebuffer console finally works.

It seems strange to me that the driver ignores the sync polarity we request,
but I'm sure the above code exists for a good reason so I would not suggest to
simply remove it as a fix. Can anyone explain why this code is
necessary?

The fact that this cause problems for me is probably due to my particular video setup:
Ultra10 vga -> passive VGA csync on hsync pin to sync on green adapter -> 
passive VGA to 13W3 adapter -> GDM-17E11 SGI monitor (requires sync-on-green).

IMHO, the driver should preserve the settings from openboot, not only the 
resoltion and sync frequencies, but also the sync polarities. 

Regards,
Raphael Assenat



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
