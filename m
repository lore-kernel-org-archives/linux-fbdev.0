From: David Lerner <dsl@zai.com>
Subject: setting mode for tdfx driver
Date: Sun, 20 Apr 2003 11:09:40 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3EA2B834.8050808@zai.com>
References: <1050827079.1008.4.camel@peck>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from lakemtao04.cox.net ([68.1.17.241])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 197GS1-00057l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Apr 2003 08:09:53 -0700
Received: from zai.com ([68.100.117.250]) by lakemtao04.cox.net
          (InterMail vM.5.01.04.05 201-253-122-122-105-20011231) with ESMTP
          id <20030420150940.FAOB13930.lakemtao04.cox.net@zai.com>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sun, 20 Apr 2003 11:09:40 -0400
In-Reply-To: <1050827079.1008.4.camel@peck>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I have been using the tdfx device with various kernels and it has
come up as desired with the kernel parameter
video=tdfx:1280x1024@61. This stoped working with kernel 2.5.66.

Digging through the source code reveals that the driver now responds 
to the name tdfxfb. The Documentation/fb/modedb.txt file should be 
updated to reflect this change. It reads:

     Drivers that support modedb boot options
     Boot Name     Cards Supported

     ami         - Amiga chipset frame buffer
     aty128fb    - ATI Rage128 / Pro frame buffer
     atyfb       - ATI Mach64 frame buffer
     tdfx        - 3D Fx frame buffer

It should read:

     Drivers that support modedb boot options
     Boot Name     Cards Supported

     amifb       - Amiga chipset frame buffer
     aty128fb    - ATI Rage128 / Pro frame buffer
     atyfb       - ATI Mach64 frame buffer
     tdfxfb      - 3D Fx frame buffer


A patch submission by the responsible maintainer will help others 
using the tdfx/tdfxfb driver. I believe that the indicated change 
for the ami driver is also required.

Thanks,
Dave



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
