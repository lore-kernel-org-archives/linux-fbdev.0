From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 10:36:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041018083632.GE3065@bytesex>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org> <20041017120728.GC10532@admingilde.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJTNA-0007Me-Kp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 02:00:08 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CJTN9-0000jp-TA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 02:00:08 -0700
Content-Disposition: inline
In-Reply-To: <20041017120728.GC10532@admingilde.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

On Sun, Oct 17, 2004 at 02:07:28PM +0200, Martin Waitz wrote:
> hi :)
> 
> On Fri, Oct 15, 2004 at 03:13:13PM +0200, Gerd Knorr wrote:
> > You have a application running which uses the framebuffer device, then
> > suspend with that app running.  You'll have to restore the state of
> > the device _before_ restarting all the userspace proccesses, otherwise
> > the app will not be very happy.
> 
> As long as the app only interfaces with the framebuffer device and not
> directly with the hardware it won't notice.

Well, mmap("/dev/fb") will just map the gfx cards memory into
the applications address space, so they _will_ interface with
the hardware.

> The apps data will simply not show up on the screen until the
> usermode helper finishes.

Whenever writing to the gfx memory before finishing the initialization
is harmless or not probably depends on the hardware, I'd better not
count on it ...

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
