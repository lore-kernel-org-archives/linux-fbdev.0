From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 14:10:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041018121033.GB5106@bytesex>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org> <20041017120728.GC10532@admingilde.org> <20041018083632.GE3065@bytesex> <20041018113929.GB3618@admingilde.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJWUt-0003Lq-7n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 05:20:19 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CJWUs-0000tk-I6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 05:20:19 -0700
Content-Disposition: inline
In-Reply-To: <20041018113929.GB3618@admingilde.org>
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

On Mon, Oct 18, 2004 at 01:39:29PM +0200, Martin Waitz wrote:
> hi :)
> 
> > Whenever writing to the gfx memory before finishing the initialization
> > is harmless or not probably depends on the hardware, I'd better not
> > count on it ...
> 
> when the application tries to access the framebuffer memory then
> the driver is asked to map the corresponding page.

On first access only, and even that only if the driver doesn't map the
pages at mmap() time already.  Not a single fb driver seems to map the
pages lazy today, grepping in drivers/video for nopage handles shows
nothing.  I'm not sure you can actually do that for iomem mappings.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
