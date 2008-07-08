From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 08/10] am200epd: convert to
	shared fb and use gpio api
Date: Tue, 8 Jul 2008 08:43:54 -0400
Message-ID: <45a44e480807080543q5a106541nf497a751d3d20b56@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-9-git-send-email-jayakumar.lkml@gmail.com>
	<4851D98A.5000508@gmail.com>
	<45a44e480806142342n7f0be549se6ded1a93d363d65@mail.gmail.com>
	<4855D18E.5010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGCY2-0003ig-Ip for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 05:43:58 -0700
Received: from ik-out-1112.google.com ([66.249.90.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KGCY0-0005BO-QG
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 05:43:58 -0700
Received: by ik-out-1112.google.com with SMTP id c21so1176646ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Jul 2008 05:43:55 -0700 (PDT)
In-Reply-To: <4855D18E.5010609@gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jun 15, 2008 at 7:35 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> I saw the device's name being "pxa2xx-fb", so I assume the pxafb.c
> will take over the device, while I didn't see the
> platform_unregister_device() in your module unload patch, could you
> please be more specific on this, and see if we can work out a better
> solution.
>

Ok, here's my details of the platform handling between am200epd, pxafb
and metronomefb as currently implemented in this patch.

a) At a high level, the concept is that metronomefb is the upper layer
driver that has no arch specific knowledge. It manages interaction
with the Metronome controller. It requires a framebuffer, IO and panel
information from its platform device driver. In this case, its
platform device driver is am200epd.
b) am200epd gets its framebuffer access from pxafb and uses the gpio
api to perform IO on behalf of metronomefb.
c) So, the layers are metronomefb which uses am200epd which uses pxafb.
d) Module reference counting is metronomefb refcounts am200epd which
refcounts pxafb
e) Platform handling between metronomefb and am200epd is am200_device.
am200epd owns the platform_device and metronomefb is the
platform_driver. am200_device is alloc/add-ed and unregistered by
am200epd.
f) Platform handling between am200epd and pxafb is
am200_pxa_device_fb. am200epd owns the platform_device and pxa2xx-fb
(pxafb) is the platform_driver. am200_pxa_device_fb is alloc/add-ed
and unregistered by am200epd.

Okay, now we go to the details:
1] Loading
- The platform_device used between metronomefb and am200epd is
am200_device. It is platform_device_alloced/added by am200epd at init
time and also unregistered by am200epd at exit time.
- Metronomefb reference counts am200epd to make sure that am200epd
cannot be unloaded underneath it.
- Metronomefb calculates the size of additional framebuffer memory it needs.
- am200_setup_fb is called from metronomefb.
- am200_setup_fb calls am200_pxa_register_device.
- This calls platform_device_alloc("pxa2xx-fb" and passes pxafb the
am200_pxa_device_fb platform_device struct through platform_device_add
- pxafb then goes through its probe routine
- pxafb calls pxafb_map_video_memory in which we call
inf->share_video_mem which is am200epd's callback to get access to the
framebuffer and to refcount pxafb
- that completes setup and we return from platform_device_add in
am200epd which causes return from setup_fb back to metronomefb

2] Running
- so now setup is complete and refcounting will be metronomefb 0 ,
am200epd 1 [ by metronomefb] , pxafb 1 [ by am200epd]
eg:
am200epd                5832  1
pxafb                  16712  1
metronomefb             8296  0

3] Unloading
- because of the refcounting, the only order of unloading that this
system allows is metronomefb, am200epd, pxafb.
- when metronomefb is unloaded, board->cleanup and module_put is done
on am200epd
- now am200epd can be unloaded
- when rmmod am200epd, we do:
- am200_exit which does platform_device_unregister on am200_pxa_device_fb
- platform calls pxafb_remove which calls unshare_video_mem
- am200_unshare_video_mem then does the module_put on pxafb so now
pxafb is also ready for cleanup
- then back to am200_exit where we do platform_device_unregister on
am200_device which is clean
- now pxafb can be unloaded like normal

Weaknesses of current implementation:
- double framebuffer devices show up, eg: fb0 and fb1. pxafb registers
a framebuffer and so does metronomefb. But in reality there is only
one display output because pxa's AMLCD bus feeds into metronome and
finally into the E-Ink panel. I should probably add a flag requesting
pxafb skip registering its fb. But at the moment it doesn't harm the
system so I've left it for a future cleanup.
- not sure why the module owner names don't show up in lsmod output.
maybe something to look at but doesn't appear to harm the system.
- probably unnecessary unshare_video_mem because pxafb can't be
unloaded before am200epd in this design. I put this anyway because it
feels symmetrical to have a share and an unshare and I was worried
about stuff like rmmod -f.

I hope this all makes sense and that the design is okay. If not,
please don't hesitate to feedback, I'm happy to rework anything.

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
