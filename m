From: Miles Lane <miles.lane@gmail.com>
Subject: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Fri, 25 Mar 2005 23:50:56 -0500
Message-ID: <a44ae5cd050325205012399ccc@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <20050324203118.345c6004.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DF3GJ-0003Y4-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Mar 2005 20:51:03 -0800
Received: from wproxy.gmail.com ([64.233.184.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DF3GH-0005Wu-Uw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Mar 2005 20:51:03 -0800
Received: by wproxy.gmail.com with SMTP id 69so873507wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Mar 2005 20:50:56 -0800 (PST)
In-Reply-To: <20050324203118.345c6004.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: khali@linux-fr.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, 24 Mar 2005 20:31:18 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> (Added the mailing list - trust that's ok)
> 
> Miles Lane <miles.lane@gmail.com> wrote:
> >
> > Kernel command line: BOOT_IMAGE=Linux ro root=306 video=nvidiafb
> > init=/etc/init lang=us apm=power-off nomce
> > nvidiafb: nVidia device/chipset 10DE0312
> > nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
> > nvidiafb: CRTC0 found
> > nvidiafb: CRTC1 not found
> > nvidiafb: EDID found from BUS1
> > nvidiafb: CRTC 0 appears to have a CRT attached
> > nvidiafb: Using CRT on CRTC 0
> >
> > >> I am wondering whether the following two lines point to the problem.
> >
> > allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
> > nvidiafb: cannot ioremap FB base
> 
> Quite possibly.
> 
> I'll do rc2-mm3 tonight - please test that.  It has fixes.

Hello Andrew,

mm3 did not fix the problem.  I still get a blank framebuffer console.
I still get these two errors:
allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
nvidiafb: cannot ioremap FB base
Also, I still get the /sys listing Oops when listing the i2c entries
for the nvidiafb.
Lastly, I get the Oops that halts booting if I include certain other
i2c drivers in the build.
Removing nvidiafb from the build allows me to get a completely usable
build of 2.6.12-rc1-mm3.

I haven't heard anything from the author of the nvidiafb driver about
the various issues I have reported.

Thanks,
               Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
