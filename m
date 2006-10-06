From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Silicon motion 501 driver
Date: Fri, 6 Oct 2006 13:52:41 +0100
Message-ID: <a728f9f90610060552lfaed133t307a295628833b17@mail.gmail.com>
References: <20060514223741.GB20765@kyllikki.org>
	<4523B7A1.5070504@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVpC0-00087u-Fc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 05:52:44 -0700
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GVpBz-0005um-0k
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 05:52:44 -0700
Received: by ug-out-1314.google.com with SMTP id p27so313667ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Oct 2006 05:52:41 -0700 (PDT)
In-Reply-To: <4523B7A1.5070504@anagramm.de>
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

FWIW,  I'm working on an X driver for the smi501 chips as well.  It
supports XAA and purports to support dualhead although at the moment,
I can't get crtc2 to actually display anything other than the hardware
cursor.  Although up until just recently I didn't have any hardware to
test with.  I'm wondering if there is some FB enable bit somewhere
that I'm missing, or if perhaps the smi501 is like the lynx chips and
the framebuffers for each crtc have to be contiguous and fit into a
single accelerator surface, however Vincent's patch seems to indicate
otherwise.  Any thoughts would be appreciated.

http://www.botchco.com/alex/xorg/smi501.tar.gz

Alex

On 10/4/06, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello, Vincent,
>
> Vincent Sanders wrote:
> > Attached you will find a first cut of a driver for the silicon motion
> > SM501 mobile multimedia companion chip.
>
> Good to see, I was working on the SM501 also for a while and
> I am looking now to get it into the kernel, too.
>
> > The driver actually breaks down into a "base" driver for all the
> > available functions and a framebuffer driver for the video elements.
>
> What is the status of your development? Did you push it upstream already?
>
> > Comments and patches gratefully received, I don't know how much more
> > complete a driver has to be for consideration for mainline merge but
> > that is the ultimate aim.
>
> Any help needed? Please give me an update about your progress.
>
> Best greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
