From: Ralph <expires-30-06-2003@0x01.de>
Subject: Unable to set very low resolutions
Date: Fri, 9 May 2003 19:41:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030509174159.GA7720@endlos.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from moutng.kundenserver.de ([212.227.126.186])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19EBr1-00012B-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 May 2003 10:40:20 -0700
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 19EBqz-0002Pz-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 May 2003 19:40:17 +0200
Received: from [217.231.148.63] (helo=elephant.endlos.net)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 19EBqz-0004dL-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 May 2003 19:40:17 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

Are there known issues setting very low resolutions?  I'm using
kernel 2.4.20 and the aty128fb driver, but from what I hear (or
rather don't hear) from other people it's not limited to that
driver.

The following is a working modeline for my card and my 15.75 kHz
monitor:

	modeline 320x240  6.04186  \
	         320 328 352 384  240 244 247 262  -hsync -vsync

I've converted that to the following fb.modes entry:

	mode "lowres"
        geometry 320 240 320 240 8
        timings 165511 32 8 15 4 24 3    
        hsync low
        vsync low
	endmode

But when I try to fbset this mode, I get this instead:

	mode "320x240-103"
	    # D: 10.410 MHz, H: 27.110 kHz, V: 103.471 Hz
	    geometry 320 240 320 240 8
	    timings 96061 14 26 15 4 24 3
	    accel true
	    rgba 8/0,8/0,8/0,0/0
	endmode

How so?  I really want to get this working and I'd be happy to
provide any information I can.

Ralph


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
