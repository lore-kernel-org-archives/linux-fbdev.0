From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Sun, 25 Feb 2007 19:10:25 +0800
Message-ID: <1172401825.6187.2.camel@daplas>
References: <ephv35$4i3$1@sea.gmane.org> <1172153358.4306.17.camel@daplas>
	<cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
	<1172161290.4198.12.camel@daplas>
	<cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
	<1172187249.4279.7.camel@daplas>
	<cb7bb73a0702230534o4e2c7e9frd5f2b05accf18c05@mail.gmail.com>
	<1172300694.4109.50.camel@daplas>
	<cb7bb73a0702240116g33a9b5bv2e3668a536a70938@mail.gmail.com>
	<1172351769.4415.5.camel@daplas>
	<cb7bb73a0702250226k53369655vc9c4e5a71c337a8c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLHEe-0001n3-23 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 03:08:08 -0800
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLHEb-0002GE-Hk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 03:08:07 -0800
Received: by py-out-1112.google.com with SMTP id a29so540674pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 03:08:03 -0800 (PST)
In-Reply-To: <cb7bb73a0702250226k53369655vc9c4e5a71c337a8c@mail.gmail.com>
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
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos@people.it>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

On Sun, 2007-02-25 at 11:26 +0100, Giuseppe Bilotta wrote:
> On 2/24/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Sat, 2007-02-24 at 10:16 +0100, Giuseppe Bilotta wrote:
> > >
> > > Keep in mind that setting nvidiafb to totally ignore the EDID (either
> > > by not compiling in EDID support or by using e.g. the ignoreedid patch
> > > I had proposed) the snow effect is extremely reduced,
> >
> > I did not know that, just scanned the entire thread. Try this patch, it
> > makes use of fb_ddc_read*() which I believe has extra steps to prevent
> > display corruption.  It also incorporates Luca's i2c fix.
> 
> Applied. No noticeable difference, in the sense that the EDID debug
> output is still the same and so is the snow effect.
> 

Here's a temporary workaround:

In drivers/video/nvidia/nv_i2c.c:nvidia_probe_i2c_connector(),comment
this out:

	if (par->chan[conn - 1].par)
		edid = fb_ddc_read(&par->chan[conn - 1].adapter);

and make sure CONFIG_FIRMWARE_EDID=y.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
