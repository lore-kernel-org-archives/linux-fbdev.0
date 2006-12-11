From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: savagefb not working on thinkpad T23 in
	1400x1050
Date: Sun, 10 Dec 2006 22:00:54 -0500
Message-ID: <a728f9f90612101900v176168b0m3fc92d32874b0a30@mail.gmail.com>
References: <20061127201146.GA13885@amd64.of.nowhere>
	<Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
	<20061210192907.GB21994@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GtbPW-0000Gn-L6 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Dec 2006 19:00:58 -0800
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GtbPU-0000ef-6g
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Dec 2006 19:00:58 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1290274ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 10 Dec 2006 19:00:54 -0800 (PST)
In-Reply-To: <20061210192907.GB21994@amd64.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>, neo@directfb.org, dok@directfb.org

On 12/10/06, thunder7@xs4all.nl <thunder7@xs4all.nl> wrote:
> From: James Simmons <jsimmons@infradead.org>
> Date: Fri, Dec 08, 2006 at 08:30:13PM +0000
> >
> > > I got myself a shiny new IBM ThinkPad T23. I've used one for years, and
> > > it worked fine with savagefb and XFree/X.org. The old one had a 1024x768
> > > LCD screen, the new one has a 1400x1050 LCD screen.
> > >
> > > Unfortunately, savagefb doesn't work correctly on the new laptop.
> > >
> > > X.org works just fine in 1400x1050.
> >
> > Can you enable debug in fbmon and post your dmesg. Also what default mode
> > is it trying to go to?
> >
> >
> I've enabled debug in fbmon and gotten this dmesg (after 'modprobe
> savagefb'). I don't see any debug messages. I also don't see any i2c
> messages, and there's no *i2c* files under /sys.
>
> I notice I didn't say clearly in my first post that 800x600 works,
> 1024x768 works, 1280x1024 flickers very badly, and 1400x1050 is
> unreadable. Also, X.org tells me it's using a 60 Hz frequency, not 50 Hz
> as someone else supposed. A part of Xorg.log is also below.
>

Well, the bios claims it's 60Hz, but IIRC, if you look at the dclk
registers it runs the panel at something lower..

Alex

> Thanks for your interest,
> Jurriaan
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
