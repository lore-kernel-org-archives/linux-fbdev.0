From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: savagefb not working on thinkpad T23 in
	1400x1050
Date: Fri, 8 Dec 2006 15:47:19 -0500
Message-ID: <a728f9f90612081247w713c37d5h2966a35bd8bb6089@mail.gmail.com>
References: <20061127201146.GA13885@amd64.of.nowhere>
	<Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gsmcr-00057y-Pw for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 12:47:21 -0800
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gsmcr-0000YC-FF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 12:47:21 -0800
Received: by ug-out-1314.google.com with SMTP id z38so904021ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 08 Dec 2006 12:47:19 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: neo@directfb.org, Jurriaan <thunder7@xs4all.nl>, dok@directfb.org

On 12/8/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > I got myself a shiny new IBM ThinkPad T23. I've used one for years, and
> > it worked fine with savagefb and XFree/X.org. The old one had a 1024x768
> > LCD screen, the new one has a 1400x1050 LCD screen.
> >
> > Unfortunately, savagefb doesn't work correctly on the new laptop.
> >
> > X.org works just fine in 1400x1050.

By default xorg uses the bios to set modes.  Also, most of the panels
on thinkpads run at 50 Hz so you may have to tweak your mode.

Alex

>
> Can you enable debug in fbmon and post your dmesg. Also what default mode
> is it trying to go to?
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
