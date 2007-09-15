From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] s3c2410fb: byte ordering fixes
Date: Sat, 15 Sep 2007 08:17:30 +0800
Message-ID: <1189815450.8660.4.camel@daplas>
References: <46c1d7beb3dd8@wp.pl>
	<20070909112828.0bd6427a.krzysztof.h1@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLLv-0008U6-DD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:17:40 -0700
Received: from wa-out-1112.google.com ([209.85.146.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLLv-0007OV-4E
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:17:39 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1240336waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:17:35 -0700 (PDT)
In-Reply-To: <20070909112828.0bd6427a.krzysztof.h1@gmail.com>
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
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2007-09-09 at 11:28 +0200, Krzysztof Helt wrote:
> On Tue, 14 Aug 2007 18:26:38 +0200
> "Krzysztof Helt" <krzysztof.h1@wp.pl> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This patch sets correct bits related to the byte ordering
> > of the framebuffer. This was tested on little endian kernel
> > only. The big endian kernel may require different settings.
> > 
> > The patch also adds 32 bpp mode which is called 24 bpp by
> > Samsung. One pixel takes 32 bits but only 24 bits are used
> > in this mode.
> > 
> 
> Tony, 
> 
> This patch didn't make into the -mm tree with other s3c2410fb patches.
> Please look into it.

Sorry, I was a bit busy for the last couple of weeks so I wasn't able to
send your patches until now.

Anyway, what s3c2410fb patches did not make it to the -mm tree?

Tony 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
