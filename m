From: "Ben Gardner" <gardner.ben@gmail.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
	seconds to initialize
Date: Mon, 20 Nov 2006 16:47:54 -0600
Message-ID: <808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmHvy-0007Eh-QA for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 14:48:14 -0800
Received: from wx-out-0506.google.com ([66.249.82.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GmHvx-0003eM-Fs
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 14:48:14 -0800
Received: by wx-out-0506.google.com with SMTP id i30so2889626wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 20 Nov 2006 14:48:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-fbdev-devel@lists.sourceforge.net

I tracked it down to the memset_io() call in gxfb_core.c that clears
all the video memory.

It take 12.5 seconds to memset() a mere 16,384 Kibyte of memory.
That seems a bit strange to me.

What's stranger is the time it takes to clear the fb memory:
The first 4 MB clear in 0.01 s each.
The last 12MB are SLOW.

Check out this dd output:
~ # time dd if=/dev/zero of=/dev/fb0 bs=1M count=4
4+0 records in
4+0 records out
real    0m 0.04s
user    0m 0.00s
sys     0m 0.04s
~ # time dd if=/dev/zero of=/dev/fb0 bs=1M count=5
5+0 records in
5+0 records out
real    0m 1.08s
user    0m 0.00s
sys     0m 1.08s
~ # time dd if=/dev/zero of=/dev/fb0 bs=1M count=10
10+0 records in
10+0 records out
real    0m 6.29s
user    0m 0.00s
sys     0m 6.29s
~ # time dd if=/dev/zero of=/dev/fb0 bs=1M count=16
16+0 records in
16+0 records out
real    0m 12.54s
user    0m 0.00s
sys     0m 12.54s

Removing the memset_io() didn't seem to affect anything other than
speeding the boot by 12.5 seconds.

Would anyone object to a patch that removes the call to memset_io() ?

If there's some reason why that shouldn't be removed, is it OK to
reduce the memset_io() to clear the memory used by the current
resolution (xres * yres * bpp / 8)?

Thanks,
Ben

On 11/20/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > Hi all,
> >
> > I'm using the Geode GX processor and the associated frame buffer
> > driver in 2.6.19-rc5.
> > I have a 640x480 LCD attached, without DDC support (not sure if that matters).
> >
> > The frame buffer driver takes 12.5 seconds to initialize.
> >
> > Is this normal?
> >
> > Relevant kernel log:
> > [   18.516093] io scheduler deadline registered (default)
> > [   18.539818] gxfb 0000:00:01.1: 16384 Kibyte of video memory at 0x41000000
> > [   31.052135] Console: switching to colour frame buffer device 80x30
> > [   31.070906] fb0: Geode GX frame buffer device
> > [   31.094200] Real Time Clock Driver v1.12ac
> >
> > I tried building the driver as a module, but that makes no difference
> > -- modprobe 'hangs' for 13 seconds.
> >
> > I looked through the Geode driver code and didn't see anything obvious
> > that would eat up 13 seconds.
> >
> > Any idea as to what is going on?
>
> No idea. I do have hardware with this chipset altho I don't have a 2.6.X
> kernel running on it. So I will see what the problem is in the next few
> weeks.
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
