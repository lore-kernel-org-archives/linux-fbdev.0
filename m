From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Thu, 24 Mar 2005 20:31:18 -0800
Message-ID: <20050324203118.345c6004.akpm@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEgU4-00027F-4Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Mar 2005 20:31:44 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DEgU2-0003py-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Mar 2005 20:31:44 -0800
In-Reply-To: <a44ae5cd0503242023233dc23f@mail.gmail.com>
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
To: Miles Lane <miles.lane@gmail.com>
Cc: khali@linux-fr.org, linux-fbdev-devel@lists.sourceforge.net


(Added the mailing list - trust that's ok)

Miles Lane <miles.lane@gmail.com> wrote:
>
> Kernel command line: BOOT_IMAGE=Linux ro root=306 video=nvidiafb
> init=/etc/init lang=us apm=power-off nomce
> nvidiafb: nVidia device/chipset 10DE0312
> nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
> nvidiafb: CRTC0 found
> nvidiafb: CRTC1 not found
> nvidiafb: EDID found from BUS1
> nvidiafb: CRTC 0 appears to have a CRT attached
> nvidiafb: Using CRT on CRTC 0
> 
> >> I am wondering whether the following two lines point to the problem.
> 
> allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
> nvidiafb: cannot ioremap FB base

Quite possibly.

I'll do rc2-mm3 tonight - please test that.  It has fixes.

> CONFIG_AGP_NVIDIA=y
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=m
> CONFIG_I2C_ALGOPCA=m
> CONFIG_I2C_ISA=m
> CONFIG_I2C_NFORCE2=m
> 
> CONFIG_FB=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SOFT_CURSOR=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_NVIDIA=y
> CONFIG_FB_NVIDIA_I2C=y
> CONFIG_FRAMEBUFFER_CONSOLE=y


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
